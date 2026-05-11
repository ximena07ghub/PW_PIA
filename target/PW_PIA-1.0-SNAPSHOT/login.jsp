<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Entrar - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="body-auth">

    <nav class="navbar navbar-auth">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo"> RELAX ZONE</a>
            <div class="nav-links">
                <a href="registro.jsp" class="btn-primario">Regístrate</a>
            </div>
        </div>
    </nav>

    <main class="auth-wrapper">
        <div class="auth-container login-layout">
            
            <div class="auth-visual">
                <img src="img/flor.jpg" alt="Login Seguro">
                <h2>Bienvenido de vuelta.</h2>
                <p>Tu comunidad creativa te espera.</p>
            </div>

            <div class="auth-form-side">
                <!-- Formulario listo para el Servlet -->
                <form id="formLogin" action="LoginServlet" method="post">
                    <h3>Iniciar Sesión</h3>
                    
                    <div class="input-grupo">
                        <label for="correo">Correo Electrónico</label>
                        <input type="email" id="correo" name="correo" placeholder="correo@ejemplo.com" required>
                        <span class="error-text" id="errorCorreo"></span>
                    </div>

                    <div class="input-grupo">
                        <label for="password">Contraseña</label>
                        <input type="password" id="password" name="password" placeholder="Mínimo 8 caracteres" required>
                        <span class="error-text" id="errorPassword"></span>
                    </div>

                    <a href="#" class="olvido-password">¿Olvidaste tu contraseña?</a>

                    <button type="submit" class="btn-auth">Entrar</button>

                    <p class="auth-switch">¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
                </form>
            </div>
        </div>
    </main>

    <script src="js/login.js"></script>
</body>
</html>