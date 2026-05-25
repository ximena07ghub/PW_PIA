import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import datos.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/ActualizarPerfilServlet")
@MultipartConfig
public class ActualizarPerfilServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        String usuarioAnterior = (String) session.getAttribute("nombreUsuarioLogin");

        if (usuarioAnterior == null || usuarioAnterior.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");

        String sitioWeb = request.getParameter("sitio");
        String biografia = request.getParameter("bio");
        String talentos = request.getParameter("talentos");
        String genero = request.getParameter("genero");
        String intereses = request.getParameter("intereses");

        if (nombres == null || nombres.trim().isEmpty()
                || usuario == null || usuario.trim().isEmpty()
                || correo == null || correo.trim().isEmpty()) {
            response.sendRedirect("editarPerfil.jsp?error=campos_obligatorios");
            return;
        }

        if (apellidos == null) apellidos = "";
        if (sitioWeb == null) sitioWeb = "";
        if (biografia == null) biografia = "";
        if (talentos == null) talentos = "";
        if (genero == null) genero = "";
        if (intereses == null) intereses = "";

        nombres = nombres.trim();
        apellidos = apellidos.trim();
        usuario = usuario.trim();
        correo = correo.trim();
        sitioWeb = sitioWeb.trim();
        biografia = biografia.trim();
        talentos = talentos.trim();
        genero = genero.trim();
        intereses = intereses.trim();

        String fotoPerfil = (String) session.getAttribute("fotoPerfil");

        try {
            Part fotoPart = request.getPart("foto");

            if (fotoPart != null && fotoPart.getSize() > 0) {
                String nombreArchivo = Paths.get(fotoPart.getSubmittedFileName())
                        .getFileName()
                        .toString();

                String extension = "";
                int punto = nombreArchivo.lastIndexOf(".");
                if (punto >= 0) {
                    extension = nombreArchivo.substring(punto);
                }

                String carpetaRelativa = "uploads/perfiles";
                String carpetaReal = getServletContext().getRealPath("/") + File.separator
                        + "uploads" + File.separator + "perfiles";

                File carpeta = new File(carpetaReal);
                if (!carpeta.exists()) {
                    carpeta.mkdirs();
                }

                String nombreSeguro = usuario.replaceAll("[^A-Za-z0-9_.-]", "_");
                String nombreFinal = System.currentTimeMillis() + "_" + nombreSeguro + extension;
                File archivoDestino = new File(carpeta, nombreFinal);

                fotoPart.write(archivoDestino.getAbsolutePath());
                guardarCopiaPersistente(archivoDestino, nombreFinal);

                fotoPerfil = carpetaRelativa + "/" + nombreFinal;
            }

            try (Connection con = DBConnection.getConnection()) {
                String sql = "UPDATE usuarios SET "
                        + "nombres=?, "
                        + "apellidos=?, "
                        + "correo=?, "
                        + "nombre_usuario=?, "
                        + "foto_perfil=?, "
                        + "sitio_web=?, "
                        + "biografia=?, "
                        + "talentos=?, "
                        + "genero=?, "
                        + "intereses=? "
                        + "WHERE nombre_usuario=?";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, nombres);
                ps.setString(2, apellidos);
                ps.setString(3, correo);
                ps.setString(4, usuario);
                ps.setString(5, fotoPerfil);
                ps.setString(6, sitioWeb);
                ps.setString(7, biografia);
                ps.setString(8, talentos);
                ps.setString(9, genero);
                ps.setString(10, intereses);
                ps.setString(11, usuarioAnterior);

                ps.executeUpdate();

                Integer usuarioId = (Integer) session.getAttribute("usuarioId");
                if (usuarioId != null) {
                    String sqlTalento = "INSERT INTO comunidad_talentos (usuario_id, talento, busca) "
                            + "VALUES (?, ?, ?) "
                            + "ON DUPLICATE KEY UPDATE talento = VALUES(talento), busca = VALUES(busca)";
                    try (PreparedStatement psTalento = con.prepareStatement(sqlTalento)) {
                        psTalento.setInt(1, usuarioId);
                        psTalento.setString(2, talentos);
                        psTalento.setString(3, intereses);
                        psTalento.executeUpdate();
                    }
                }
            }

            session.setAttribute("nombres", nombres);
            session.setAttribute("apellidos", apellidos);
            session.setAttribute("correoUsuario", correo);
            session.setAttribute("nombreUsuarioLogin", usuario);
            session.setAttribute("nombreUsuario", nombres);
            session.setAttribute("fotoPerfil", fotoPerfil);

            session.setAttribute("sitioWeb", sitioWeb);
            session.setAttribute("biografia", biografia);
            session.setAttribute("talentos", talentos);
            session.setAttribute("genero", genero);
            session.setAttribute("intereses", intereses);

            response.sendRedirect("perfil.jsp");

        } catch (Exception e) {
            throw new ServletException("Error al actualizar perfil", e);
        }
    }

    private void guardarCopiaPersistente(File archivoSubido, String nombreFinal) throws IOException {
        String realPath = getServletContext().getRealPath("/");
        if (realPath == null || archivoSubido == null || !archivoSubido.exists()) {
            return;
        }

        File actual = new File(realPath).getCanonicalFile();
        while (actual != null) {
            File webappProyecto = new File(actual, "src/main/webapp");
            if (webappProyecto.isDirectory()) {
                File carpetaPersistente = new File(webappProyecto, "uploads/perfiles");
                if (!carpetaPersistente.exists()) {
                    carpetaPersistente.mkdirs();
                }

                Files.copy(
                        archivoSubido.toPath(),
                        new File(carpetaPersistente, nombreFinal).toPath(),
                        StandardCopyOption.REPLACE_EXISTING
                );
                return;
            }
            actual = actual.getParentFile();
        }
    }
}
