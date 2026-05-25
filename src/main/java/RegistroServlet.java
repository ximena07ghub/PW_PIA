import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import datos.DBConnection;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
@MultipartConfig
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombres = clean(request.getParameter("nombres"));
        String apellidos = clean(request.getParameter("apellidos"));
        String fechaNacimiento = clean(request.getParameter("fechaNacimiento"));
        String correo = clean(request.getParameter("correo")).toLowerCase();
        String nombreUsuario = clean(request.getParameter("nombreUsuario"));
        String password = clean(request.getParameter("password"));
        String confirmPassword = clean(request.getParameter("confirmPassword"));

        if (nombres.isEmpty() || apellidos.isEmpty() || fechaNacimiento.isEmpty()
                || correo.isEmpty() || nombreUsuario.isEmpty() || password.isEmpty()
                || confirmPassword.isEmpty()) {
            response.sendRedirect("registro.jsp?error=campos");
            return;
        }

        if (!passwordCumpleReglas(password)) {
            response.sendRedirect("registro.jsp?error=password");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("registro.jsp?error=confirmar");
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            if (usuarioExiste(connection, correo, nombreUsuario)) {
                response.sendRedirect("registro.jsp?error=existe");
                return;
            }

            String sql = "INSERT INTO usuarios "
                    + "(nombres, apellidos, fecha_nacimiento, correo, nombre_usuario, password_hash) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, nombres);
                statement.setString(2, apellidos);
                statement.setString(3, fechaNacimiento);
                statement.setString(4, correo);
                statement.setString(5, nombreUsuario);
                statement.setString(6, PasswordUtil.hash(password));
                statement.executeUpdate();
            }

            response.sendRedirect("login.jsp?registro=ok");
        } catch (SQLException ex) {
            log("No se pudo registrar el usuario.", ex);
            response.sendRedirect("registro.jsp?error=" + tipoError(ex));
        }
    }

    private boolean usuarioExiste(Connection connection, String correo, String nombreUsuario) throws SQLException {
        String sql = "SELECT id FROM usuarios WHERE correo = ? OR nombre_usuario = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, correo);
            statement.setString(2, nombreUsuario);

            try (ResultSet result = statement.executeQuery()) {
                return result.next();
            }
        }
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }

    private boolean passwordCumpleReglas(String password) {
        boolean tieneMayuscula = false;
        boolean tieneMinuscula = false;
        boolean tieneNumero = false;
        boolean tieneSimbolo = false;

        for (int i = 0; i < password.length(); i++) {
            char actual = password.charAt(i);
            tieneMayuscula = tieneMayuscula || Character.isUpperCase(actual);
            tieneMinuscula = tieneMinuscula || Character.isLowerCase(actual);
            tieneNumero = tieneNumero || Character.isDigit(actual);
            tieneSimbolo = tieneSimbolo || !Character.isLetterOrDigit(actual);
        }

        return password.length() >= 8
                && tieneMayuscula
                && tieneMinuscula
                && tieneNumero
                && tieneSimbolo;
    }

    private String tipoError(SQLException ex) {
        String message = ex.getMessage() == null ? "" : ex.getMessage().toLowerCase();

        if (message.contains("driver")) {
            return "driver";
        }

        if (message.contains("access denied") || message.contains("using password")) {
            return "credenciales";
        }

        if (message.contains("unknown database")) {
            return "base";
        }

        if (message.contains("communications link failure") || message.contains("connection refused")) {
            return "conexion";
        }

        return "db";
    }
}
