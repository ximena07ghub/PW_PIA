<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesi&oacute;n - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
</head>
<body class="body-auth">

    <nav class="navbar navbar-auth">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo">RELAX ZONE</a>
        </div>
    </nav>

    <main class="auth-wrapper">
        <div class="auth-container login-layout">

            <!-- Lado izquierdo con flor (como en tu imagen) -->
            <div class="auth-visual">
                <img src="img/flor.jpg" alt="Bienvenido">
                <h2>Bienvenido de vuelta.</h2>
                <p>Tu comunidad creativa te espera.</p>
            </div>

            <!-- Lado derecho - Formulario -->
            <div class="auth-form-side">
                <form id="formLogin" action="LoginServlet" method="post">
                    <h3>Iniciar Sesi&oacute;n</h3>

                    <% if ("1".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Usuario/correo o contrase&ntilde;a incorrectos.
                        </p>
                    <% } else if ("db".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            No se pudo conectar con la base de datos. Revisa que MySQL est&eacute; encendido y que exista la base relaxzone.
                        </p>
                    <% } else if ("driver".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Falta el conector de MySQL. Haz Clean and Build en NetBeans para descargar mysql-connector-j.
                        </p>
                    <% } else if ("credenciales".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            MySQL rechaz&oacute; el usuario o contrase&ntilde;a. Revisa que root use la contrase&ntilde;a admin123.
                        </p>
                    <% } else if ("base".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            No existe la base relaxzone. Ejecuta el script database.sql en MySQL Workbench.
                        </p>
                    <% } else if ("conexion".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            No se pudo conectar con MySQL. Verifica que el servidor est&eacute; encendido en el puerto 3306.
                        </p>
                    <% } else if ("ok".equals(request.getParameter("registro"))) { %>
                        <p style="background:rgba(42,201,230,0.14); border:1px solid rgba(42,201,230,0.45); color:#9ff3ff; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Registro exitoso. Ahora inicia sesi&oacute;n con tu correo o nombre de usuario.
                        </p>
                    <% } %>

                    <div class="input-grupo">
                        <label for="login">Correo electr&oacute;nico o nombre de usuario</label>
                        <input type="text" id="login" name="login" placeholder="correo@ejemplo.com o tu usuario" required>
                    </div>

                    <div class="input-grupo">
                        <label for="password">Contrase&ntilde;a</label>
                        <input type="password" id="password" name="password" placeholder="M&iacute;nimo 8 caracteres" required>
                    </div>

                    <a href="#" class="olvido-password">&iquest;Olvidaste tu contrase&ntilde;a?</a>

                    <button type="submit" class="btn-auth">ENTRAR</button>

                    <p class="auth-switch">&iquest;No tienes cuenta? <a href="registro.jsp">Reg&iacute;strate aqu&iacute;</a></p>
                </form>
            </div>
        </div>
    </main>

    <script src="js/login.js"></script>
</body>
</html>
