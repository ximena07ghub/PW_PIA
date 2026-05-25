import datos.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/CursoProgresoServlet")
public class CursoProgresoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer usuarioId = usuarioId(request);
        if (usuarioId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            writeJson(response, "{\"courses\":[],\"activity\":[]}");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            String json = "{\"courses\":" + cursosJson(con, usuarioId)
                    + ",\"activity\":" + actividadJson(con, usuarioId) + "}";
            writeJson(response, json);
        } catch (SQLException ex) {
            throw new ServletException("No se pudo cargar el progreso.", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Integer usuarioId = usuarioId(request);
        if (usuarioId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            writeJson(response, "{\"ok\":false}");
            return;
        }

        String action = clean(request.getParameter("action"));

        try (Connection con = DBConnection.getConnection()) {
            // Mantiene cursos y actividad separados por usuario.
            if ("deleteCourse".equals(action)) {
                eliminarCurso(con, usuarioId, request);
                guardarActividad(con, usuarioId, "Ruta", "Eliminaste un curso de tu ruta.", request);
            } else if ("activity".equals(action)) {
                guardarActividad(con, usuarioId, request);
            } else {
                guardarCurso(con, usuarioId, request);
                guardarActividad(con, usuarioId, request);
            }

            writeJson(response, "{\"ok\":true}");
        } catch (SQLException ex) {
            throw new ServletException("No se pudo guardar el progreso.", ex);
        }
    }

    private void eliminarCurso(Connection con, int usuarioId, HttpServletRequest request) throws SQLException {
        String sql = "DELETE FROM usuario_cursos WHERE usuario_id = ? AND curso_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ps.setString(2, clean(request.getParameter("courseId")));
            ps.executeUpdate();
        }
    }

    private Integer usuarioId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioId") == null) {
            return null;
        }
        return (Integer) session.getAttribute("usuarioId");
    }

    private void guardarCurso(Connection con, int usuarioId, HttpServletRequest request) throws SQLException {
        String sql = "INSERT INTO usuario_cursos "
                + "(usuario_id, curso_id, titulo, categoria, total_modulos, modulos_completados, modulos_completados_lista, porcentaje) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE titulo = VALUES(titulo), categoria = VALUES(categoria), "
                + "total_modulos = VALUES(total_modulos), modulos_completados = VALUES(modulos_completados), "
                + "modulos_completados_lista = VALUES(modulos_completados_lista), porcentaje = VALUES(porcentaje)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ps.setString(2, clean(request.getParameter("courseId")));
            ps.setString(3, clean(request.getParameter("title")));
            ps.setString(4, clean(request.getParameter("category")));
            ps.setInt(5, number(request.getParameter("totalModules")));
            ps.setInt(6, number(request.getParameter("completedModules")));
            ps.setString(7, clean(request.getParameter("completedList")));
            ps.setInt(8, number(request.getParameter("percent")));
            ps.executeUpdate();
        }
    }

    private void guardarActividad(Connection con, int usuarioId, HttpServletRequest request) throws SQLException {
        String tipo = clean(request.getParameter("activityType"));
        String descripcion = clean(request.getParameter("activityText"));
        guardarActividad(con, usuarioId, tipo, descripcion, request);
    }

    private void guardarActividad(Connection con, int usuarioId, String tipo, String descripcion,
            HttpServletRequest request) throws SQLException {
        if (tipo.isEmpty() || descripcion.isEmpty()) {
            return;
        }

        String sql = "INSERT INTO usuario_actividad (usuario_id, tipo, descripcion, curso_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ps.setString(2, tipo);
            ps.setString(3, descripcion);
            ps.setString(4, clean(request.getParameter("courseId")));
            ps.executeUpdate();
        }
    }

    private String cursosJson(Connection con, int usuarioId) throws SQLException {
        String sql = "SELECT curso_id, titulo, categoria, total_modulos, modulos_completados, modulos_completados_lista, porcentaje "
                + "FROM usuario_cursos WHERE usuario_id = ? ORDER BY fecha_actualizacion DESC";
        StringBuilder json = new StringBuilder("[");

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                boolean comma = false;
                while (rs.next()) {
                    if (comma) json.append(",");
                    json.append("{")
                            .append("\"id\":\"").append(escape(rs.getString("curso_id"))).append("\",")
                            .append("\"title\":\"").append(escape(rs.getString("titulo"))).append("\",")
                            .append("\"category\":\"").append(escape(rs.getString("categoria"))).append("\",")
                            .append("\"totalModules\":").append(rs.getInt("total_modulos")).append(",")
                            .append("\"completedModules\":").append(rs.getInt("modulos_completados")).append(",")
                            .append("\"completedList\":\"").append(escape(rs.getString("modulos_completados_lista"))).append("\",")
                            .append("\"percent\":").append(rs.getInt("porcentaje"))
                            .append("}");
                    comma = true;
                }
            }
        }

        return json.append("]").toString();
    }

    private String actividadJson(Connection con, int usuarioId) throws SQLException {
        String sql = "SELECT tipo, descripcion, fecha_creacion FROM usuario_actividad "
                + "WHERE usuario_id = ? ORDER BY fecha_creacion DESC LIMIT 5";
        StringBuilder json = new StringBuilder("[");

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                boolean comma = false;
                while (rs.next()) {
                    if (comma) json.append(",");
                    json.append("{")
                            .append("\"type\":\"").append(escape(rs.getString("tipo"))).append("\",")
                            .append("\"text\":\"").append(escape(rs.getString("descripcion"))).append("\",")
                            .append("\"date\":\"").append(escape(rs.getString("fecha_creacion"))).append("\"")
                            .append("}");
                    comma = true;
                }
            }
        }

        return json.append("]").toString();
    }

    private void writeJson(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(json);
        }
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }

    private int number(String value) {
        try {
            return Integer.parseInt(clean(value));
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private String escape(String value) {
        return clean(value)
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", " ")
                .replace("\n", " ");
    }
}
