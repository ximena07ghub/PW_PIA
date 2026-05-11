import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");   // puede ser nombreUsuario o correo
        String password = request.getParameter("password");

        HttpSession sesion = request.getSession();
        sesion.setAttribute("usuarioLogueado", login);
        sesion.setAttribute("nombreUsuario", "Usuario");   // después lo sacamos de BD

        response.sendRedirect("index.jsp");
    }
}