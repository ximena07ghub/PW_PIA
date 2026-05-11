<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<nav class="navbar">
    <div class="contenedor-nav">
        <div class="logo"><span class="logo-icon"></span> RELAX ZONE</div>
        <div class="nav-links">
            <% String nombre = (String) session.getAttribute("nombreUsuario"); %>
            <% if (nombre != null) { %>
                <span>Bienvenido, <strong><%= nombre %></strong></span>
                <a href="index.jsp">Inicio</a>
                <a href="LogoutServlet">Cerrar Sesión</a>
            <% } %>
        </div>
    </div>
</nav>

<main class="contenedor-principal" style="padding-top: 3rem;">
    <h1 style="text-align:center; color:#1c1917;">Mi Perfil</h1>
    
    <div style="max-width:700px; margin:0 auto; background:#fff; border-radius:15px; box-shadow:0 4px 20px rgba(0,0,0,0.1); padding:2.5rem; color:#1c1917;">
        <div style="text-align:center;">
            <img src="img/default-avatar.png" alt="Foto de perfil" 
                 style="width:140px; height:140px; border-radius:50%; border:6px solid #059669;">
            <h2 style="margin:15px 0 5px 0;"><%= session.getAttribute("nombreUsuario") %></h2>
            <p style="color:#059669;">@<%= session.getAttribute("nombreUsuarioLogin") %></p>
        </div>

        <hr style="margin:25px 0;">

        <h3>Datos personales</h3>
        <p><strong>Nombre(s):</strong> <%= session.getAttribute("nombres") %></p>
        <p><strong>Apellidos:</strong> <%= session.getAttribute("apellidos") %></p>
        <p><strong>Fecha de nacimiento:</strong> <%= session.getAttribute("fechaNacimiento") %></p>
        <p><strong>Nombre de usuario:</strong> <%= session.getAttribute("nombreUsuarioLogin") %></p>
        <p><strong>Correo electrónico:</strong> <%= session.getAttribute("correoUsuario") %></p>

        <div style="margin-top:2.5rem; background:#f8fafc; padding:1.5rem; border-radius:10px; text-align:center;">
            <h4>Mis Cursos</h4>
            <p>Aún no tienes cursos inscritos.</p>
            <a href="index.jsp" class="btn-primario">Explorar Cursos Disponibles</a>
        </div>

        <a href="index.jsp" class="btn-primario" style="display:block; text-align:center; margin-top:2rem;">Volver al Inicio</a>
    </div>
</main>
</body>
</html>