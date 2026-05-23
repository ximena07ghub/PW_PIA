import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import datos.DBConnection;

@WebServlet("/PublicarComunidadServlet")
public class PublicarComunidadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuarioId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int usuarioId = (Integer) session.getAttribute("usuarioId");

        String contenido = request.getParameter("contenido");
        String tipo = request.getParameter("tipo");

        if (contenido == null || contenido.trim().isEmpty()) {
            response.sendRedirect("comunidad.jsp?error=contenido");
            return;
        }

        contenido = contenido.trim();

        try (Connection con = DBConnection.getConnection()) {
            String sqlPublicacion = "INSERT INTO comunidad_publicaciones "
                    + "(usuario_id, tipo, contenido) VALUES (?, ?, ?)";

            PreparedStatement psPublicacion = con.prepareStatement(sqlPublicacion);
            psPublicacion.setInt(1, usuarioId);
            psPublicacion.setString(2, tipo);
            psPublicacion.setString(3, contenido);
            psPublicacion.executeUpdate();

            String sqlTalento = "INSERT INTO comunidad_talentos (usuario_id, talento, busca) "
                    + "SELECT id, talentos, intereses FROM usuarios WHERE id = ? "
                    + "ON DUPLICATE KEY UPDATE usuario_id = usuario_id";

            PreparedStatement psTalento = con.prepareStatement(sqlTalento);
            psTalento.setInt(1, usuarioId);
            psTalento.executeUpdate();

            response.sendRedirect("comunidad.jsp");

        } catch (Exception e) {
            throw new ServletException("Error al publicar en comunidad", e);
        }
    }
}