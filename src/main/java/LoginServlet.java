import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String login = clean(request.getParameter("login"));
        if (login.isEmpty()) {
            login = clean(request.getParameter("correo")); // compatibilidad con el formulario anterior
        }
        String password = clean(request.getParameter("password"));

        if (login.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=1");
            return;
        }

        String sql = "SELECT id, nombres, apellidos, fecha_nacimiento, correo, nombre_usuario, password_hash "
                + "FROM usuarios WHERE correo = ? OR nombre_usuario = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, login.toLowerCase());
            statement.setString(2, login);

            try (ResultSet result = statement.executeQuery()) {
                if (!result.next() || !PasswordUtil.hash(password).equals(result.getString("password_hash"))) {
                    response.sendRedirect("login.jsp?error=1");
                    return;
                }

                HttpSession sesion = request.getSession(true);
                sesion.setAttribute("usuarioId", result.getInt("id"));
                sesion.setAttribute("nombres", result.getString("nombres"));
                sesion.setAttribute("apellidos", result.getString("apellidos"));
                sesion.setAttribute("nombreUsuario", result.getString("nombres"));
                sesion.setAttribute("nombreUsuarioLogin", result.getString("nombre_usuario"));
                sesion.setAttribute("correoUsuario", result.getString("correo"));
                sesion.setAttribute("fechaNacimiento", result.getString("fecha_nacimiento"));
            }

            response.sendRedirect("dashboard.jsp");
        } catch (SQLException ex) {
            log("No se pudo iniciar sesión.", ex);
            response.sendRedirect("login.jsp?error=" + tipoError(ex));
        }
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
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
