<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    String usuarioLogin = (String) session.getAttribute("nombreUsuarioLogin");
    String correoUsuario = (String) session.getAttribute("correoUsuario");
    String nombres = (String) session.getAttribute("nombres");
    String apellidos = (String) session.getAttribute("apellidos");
    String fechaNacimiento = (String) session.getAttribute("fechaNacimiento");

    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) nombreUsuario = "Estudiante";
    if (usuarioLogin == null || usuarioLogin.trim().isEmpty()) usuarioLogin = "relax.user";
    if (correoUsuario == null || correoUsuario.trim().isEmpty()) correoUsuario = "correo@relaxzone.com";
    if (nombres == null || nombres.trim().isEmpty()) nombres = nombreUsuario;
    if (apellidos == null) apellidos = "";
    if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty()) fechaNacimiento = "Sin registrar";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .profile-page {
            max-width: 1180px;
            margin: 0 auto;
            padding: 2rem;
        }

        .profile-hero {
            background: var(--color-fondo-card);
            color: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            display: grid;
            grid-template-columns: auto minmax(0, 1fr) 320px;
            gap: 1.5rem;
            align-items: center;
            border: 1px solid var(--color-borde);
            box-shadow: 0 18px 40px rgba(2, 61, 85, 0.12);
        }

        .profile-avatar {
            width: 132px;
            height: 132px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--color-primario), #0a52a3);
            display: grid;
            place-items: center;
            color: #ffffff;
            font-size: 3rem;
            font-weight: 800;
            overflow: hidden;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .profile-title h1 {
            color: #ffffff;
            font-size: clamp(2rem, 5vw, 3.4rem);
            line-height: 1;
            margin-bottom: 0.5rem;
            letter-spacing: 0;
        }

        .profile-title p,
        .profile-stat span {
            color: var(--color-texto-suave);
        }

        .profile-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }

        .profile-actions a {
            text-decoration: none;
        }

        .btn-soft {
            border: 1px solid rgba(255, 255, 255, 0.35);
            color: #ffffff;
            padding: 0.6rem 1.1rem;
            border-radius: 8px;
            font-weight: 700;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.75rem;
        }

        .profile-stat {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.14);
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
        }

        .profile-stat strong {
            display: block;
            color: var(--color-primario);
            font-size: 1.7rem;
            line-height: 1;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .profile-panel {
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 12px;
            padding: 1.5rem;
        }

        .profile-panel h2 {
            color: var(--color-texto);
            font-size: 1.35rem;
            margin-bottom: 1rem;
        }

        .info-row {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 1rem;
            padding: 0.8rem 0;
            border-top: 1px solid #e6eef2;
        }

        .info-row:first-of-type {
            border-top: none;
        }

        .info-row span {
            color: #52657d;
            font-weight: 700;
        }

        .info-row strong {
            color: var(--color-texto);
        }

        .course-progress {
            display: grid;
            gap: 0.85rem;
        }

        .progress-item {
            background: #f8fcfd;
            border-radius: 10px;
            padding: 1rem;
        }

        .progress-item strong {
            color: var(--color-texto);
        }

        .progress-bar {
            height: 8px;
            border-radius: 999px;
            background: #d8e5ec;
            margin-top: 0.7rem;
            overflow: hidden;
        }

        .progress-bar span {
            display: block;
            height: 100%;
            background: var(--color-primario);
        }

        .badge-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.65rem;
        }

        .badge-list span {
            background: #edfafe;
            color: var(--color-texto);
            border-radius: 999px;
            padding: 0.45rem 0.75rem;
            font-weight: 700;
            font-size: 0.88rem;
        }

        @media (max-width: 940px) {
            .profile-hero,
            .profile-grid {
                grid-template-columns: 1fr;
            }

            .profile-stats {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        @media (max-width: 640px) {
            .profile-page {
                padding: 1rem;
            }

            .profile-stats,
            .info-row {
                grid-template-columns: 1fr;
            }

            .contenedor-nav {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo"><span class="logo-icon"></span> RELAX ZONE</a>
            <div class="nav-links">
                <a href="dashboard.jsp" class="link-secundario">Mis cursos</a>
                <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                <a href="LogoutServlet" class="link-secundario">Cerrar sesión</a>
            </div>
        </div>
    </nav>

    <main class="profile-page">
        <section class="profile-hero">
            <div class="profile-avatar">
                <img id="profilePhoto" src="" alt="Foto de perfil">
                <span id="profileInitial"><%= nombreUsuario.substring(0, 1).toUpperCase() %></span>
            </div>
            <div class="profile-title">
                <h1 id="displayName"><%= nombreUsuario %></h1>
                <p>@<span id="displayUser"><%= usuarioLogin %></span> · <span id="displayBio">Creciendo con propósito, bienestar y creatividad.</span></p>
                <div class="profile-actions">
                    <a href="editarPerfil.jsp" class="btn-primario">Editar perfil</a>
                    <a href="dashboard.jsp" class="btn-soft">Volver a mis cursos</a>
                </div>
            </div>
            <div class="profile-stats">
                <div class="profile-stat"><strong>3</strong><span>en progreso</span></div>
                <div class="profile-stat"><strong>12</strong><span>recomendados</span></div>
                <div class="profile-stat"><strong>4</strong><span>retos</span></div>
            </div>
        </section>

        <section class="profile-grid">
            <div class="profile-panel">
                <h2>Información personal</h2>
                <div class="info-row"><span>Nombre</span><strong id="infoName"><%= nombres %> <%= apellidos %></strong></div>
                <div class="info-row"><span>Correo</span><strong id="infoEmail"><%= correoUsuario %></strong></div>
                <div class="info-row"><span>Fecha de nacimiento</span><strong id="infoBirth"><%= fechaNacimiento %></strong></div>
                <div class="info-row"><span>Intereses</span><strong id="infoInterests">Bienestar emocional, propósito, creatividad</strong></div>
            </div>

            <div class="profile-panel">
                <h2>Mis cursos y progreso</h2>
                <div class="course-progress">
                    <div class="progress-item">
                        <strong>Gestión de emociones desde cero</strong>
                        <div class="progress-bar"><span style="width:45%"></span></div>
                    </div>
                    <div class="progress-item">
                        <strong>Descubriendo mi propósito</strong>
                        <div class="progress-bar"><span style="width:25%"></span></div>
                    </div>
                    <div class="progress-item">
                        <strong>Descubre tu talento</strong>
                        <div class="progress-bar"><span style="width:15%"></span></div>
                    </div>
                </div>
            </div>

            <div class="profile-panel">
                <h2>Talentos</h2>
                <div class="badge-list" id="talentList">
                    <span>Escritura</span>
                    <span>Diseño</span>
                    <span>Escucha activa</span>
                    <span>Contenido creativo</span>
                </div>
            </div>

            <div class="profile-panel">
                <h2>Actividad reciente</h2>
                <div class="info-row"><span>Último avance</span><strong>Completó una reflexión emocional</strong></div>
                <div class="info-row"><span>Comunidad</span><strong>Busca colaborar en un reto creativo</strong></div>
                <div class="info-row"><span>Próximo paso</span><strong>Elegir un recurso de lectura</strong></div>
            </div>
        </section>
    </main>

    <script>
        const savedProfile = JSON.parse(localStorage.getItem("relaxzonePerfil") || "{}");

        if (savedProfile.nombre) {
            document.getElementById("displayName").textContent = savedProfile.nombre + (savedProfile.apellidos ? " " + savedProfile.apellidos : "");
            document.getElementById("infoName").textContent = document.getElementById("displayName").textContent;
            document.getElementById("profileInitial").textContent = savedProfile.nombre.charAt(0).toUpperCase();
        }

        if (savedProfile.usuario) {
            document.getElementById("displayUser").textContent = savedProfile.usuario;
        }

        if (savedProfile.correo) {
            document.getElementById("infoEmail").textContent = savedProfile.correo;
        }

        if (savedProfile.fechaNacimiento) {
            document.getElementById("infoBirth").textContent = savedProfile.fechaNacimiento;
        }

        if (savedProfile.bio) {
            document.getElementById("displayBio").textContent = savedProfile.bio;
        }

        if (savedProfile.intereses) {
            document.getElementById("infoInterests").textContent = savedProfile.intereses;
        }

        if (savedProfile.talentos) {
            document.getElementById("talentList").innerHTML = savedProfile.talentos
                .split(",")
                .map(function (talento) { return "<span>" + talento.trim() + "</span>"; })
                .join("");
        }

        if (savedProfile.foto) {
            const photo = document.getElementById("profilePhoto");
            photo.src = savedProfile.foto;
            photo.style.display = "block";
            document.getElementById("profileInitial").style.display = "none";
        }
    </script>
</body>
</html>
