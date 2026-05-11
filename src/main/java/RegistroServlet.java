import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
@MultipartConfig
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String correo = request.getParameter("correo");
        String nombreUsuario = request.getParameter("nombreUsuario");

        String nombreCompleto = nombres + " " + apellidos;

        HttpSession sesion = request.getSession();
        sesion.setAttribute("nombres", nombres);
        sesion.setAttribute("apellidos", apellidos);
        sesion.setAttribute("nombreUsuario", nombreCompleto);
        sesion.setAttribute("nombreUsuarioLogin", nombreUsuario);  // para login
        sesion.setAttribute("correoUsuario", correo);
        sesion.setAttribute("fechaNacimiento", fechaNacimiento);
        sesion.setAttribute("fechaCreacion", LocalDateTime.now().toString());

        response.sendRedirect("login.jsp");
    }
}