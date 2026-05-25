<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="datos.DBConnection"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    String usuarioLogin = (String) session.getAttribute("nombreUsuarioLogin");
    String correoUsuario = (String) session.getAttribute("correoUsuario");
    String nombres = (String) session.getAttribute("nombres");
    String apellidos = (String) session.getAttribute("apellidos");
    String fechaNacimiento = (String) session.getAttribute("fechaNacimiento");
    String fotoPerfil = (String) session.getAttribute("fotoPerfil");

    String sitioWeb = (String) session.getAttribute("sitioWeb");
    String biografia = (String) session.getAttribute("biografia");
    String talentos = (String) session.getAttribute("talentos");
    String genero = (String) session.getAttribute("genero");
    String intereses = (String) session.getAttribute("intereses");
    String usuarioKey = (String) session.getAttribute("nombreUsuarioLogin");

    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) nombreUsuario = "Estudiante";
    if (usuarioLogin == null || usuarioLogin.trim().isEmpty()) usuarioLogin = "relax.user";
    if (correoUsuario == null || correoUsuario.trim().isEmpty()) correoUsuario = "correo@relaxzone.com";
    if (nombres == null || nombres.trim().isEmpty()) nombres = nombreUsuario;
    if (apellidos == null) apellidos = "";
    if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty()) fechaNacimiento = "Sin registrar";
    if (fotoPerfil == null) fotoPerfil = "";

    if (sitioWeb == null || sitioWeb.trim().isEmpty()) sitioWeb = "Sin registrar";
    if (biografia == null || biografia.trim().isEmpty()) biografia = "Creciendo con prop&oacute;sito, bienestar y creatividad.";
    if (talentos == null || talentos.trim().isEmpty()) talentos = "Sin registrar";
    if (genero == null || genero.trim().isEmpty()) genero = "Prefiero no decirlo";
    if (intereses == null || intereses.trim().isEmpty()) intereses = "Sin registrar";
    if (usuarioKey == null || usuarioKey.trim().isEmpty()) usuarioKey = nombreUsuario;
    usuarioKey = usuarioKey.replaceAll("[^A-Za-z0-9_.-]", "_");

    boolean tieneFoto = !fotoPerfil.trim().isEmpty();
    boolean tieneSitio = !sitioWeb.equals("Sin registrar");
    Integer usuarioId = (Integer) session.getAttribute("usuarioId");
    int cursosEnProgreso = 0;
    int cursosCompletados = 0;
    int actividades = 0;

    // Contadores del perfil: se calculan desde la base por usuario.
    if (usuarioId != null) {
        try (Connection con = DBConnection.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) total, SUM(CASE WHEN porcentaje >= 100 THEN 1 ELSE 0 END) completos FROM usuario_cursos WHERE usuario_id = ?")) {
                ps.setInt(1, usuarioId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cursosEnProgreso = rs.getInt("total");
                        cursosCompletados = rs.getInt("completos");
                    }
                }
            }
            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) total FROM usuario_actividad WHERE usuario_id = ?")) {
                ps.setInt(1, usuarioId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) actividades = rs.getInt("total");
                }
            }
        } catch (Exception ex) {
            cursosEnProgreso = 0;
            cursosCompletados = 0;
            actividades = 0;
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
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
            grid-template-columns: auto minmax(0, 1fr) minmax(280px, 340px);
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
            grid-template-columns: repeat(3, minmax(0, 1fr));
            justify-self: center;
            width: min(100%, 340px);
            gap: 0.65rem;
        }

        .profile-stat {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.14);
            border-radius: 10px;
            padding: 0.85rem 0.55rem;
            min-width: 0;
            text-align: center;
        }

        .profile-stat strong {
            display: block;
            color: var(--color-primario);
            font-size: 1.7rem;
            line-height: 1;
        }

        .profile-stat span {
            display: block;
            overflow-wrap: anywhere;
            font-size: 0.9rem;
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

        .info-row strong,
        .info-row a {
            color: var(--color-texto);
            overflow-wrap: anywhere;
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

        .post-tag {
            display: inline-block;
            margin-left: 0.5rem;
            background: #edfafe;
            color: var(--color-texto);
            border-radius: 999px;
            padding: 0.25rem 0.65rem;
            font-size: 0.75rem;
            font-weight: 800;
        }

        .post-tag.is-done {
            background: rgba(42, 201, 230, 0.18);
            border: 1px solid rgba(42, 201, 230, 0.45);
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

        @media (max-width: 1120px) {
            .profile-hero {
                grid-template-columns: auto minmax(0, 1fr);
            }

            .profile-stats {
                grid-column: 1 / -1;
                width: min(100%, 460px);
            }
        }

        @media (max-width: 940px) {
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

            .profile-hero {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .profile-avatar,
            .profile-actions {
                justify-self: center;
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
                <a href="LogoutServlet" class="link-secundario">Cerrar sesi&oacute;n</a>
            </div>
        </div>
    </nav>

    <main class="profile-page">
        <section class="profile-hero">
            <div class="profile-avatar">
                <img
                    id="profilePhoto"
                    src="<%= fotoPerfil %>"
                    alt="Foto de perfil"
                    onerror="this.style.display='none'; document.getElementById('profileInitial').style.display='block';"
                    style="<%= tieneFoto ? "display:block;" : "display:none;" %>"
                >
                <span
                    id="profileInitial"
                    style="<%= tieneFoto ? "display:none;" : "display:block;" %>"
                >
                    <%= nombreUsuario.substring(0, 1).toUpperCase() %>
                </span>
            </div>

            <div class="profile-title">
                <h1 id="displayName"><%= nombres %> <%= apellidos %></h1>
                <p>
                    @<span id="displayUser"><%= usuarioLogin %></span> &middot;
                    <span id="displayBio"><%= biografia %></span>
                </p>
                <div class="profile-actions">
                    <a href="editarPerfil.jsp" class="btn-primario">Editar perfil</a>
                    <a href="dashboard.jsp" class="btn-soft">Volver a mis cursos</a>
                </div>
            </div>

            <div class="profile-stats">
                <div class="profile-stat"><strong id="profileCourseCount"><%= cursosEnProgreso %></strong><span>cursos agregados</span></div>
                <div class="profile-stat"><strong id="profileCompletedCount"><%= cursosCompletados %></strong><span>completados</span></div>
                <div class="profile-stat"><strong><%= actividades %></strong><span>actividades</span></div>
            </div>
        </section>

        <section class="profile-grid">
            <div class="profile-panel">
                <h2>Informaci&oacute;n personal</h2>

                <div class="info-row">
                    <span>Nombre</span>
                    <strong id="infoName"><%= nombres %> <%= apellidos %></strong>
                </div>

                <div class="info-row">
                    <span>Correo</span>
                    <strong id="infoEmail"><%= correoUsuario %></strong>
                </div>

                <div class="info-row">
                    <span>Fecha de nacimiento</span>
                    <strong id="infoBirth"><%= fechaNacimiento %></strong>
                </div>

                <div class="info-row">
                    <span>G&eacute;nero</span>
                    <strong><%= genero %></strong>
                </div>

                <div class="info-row">
                    <span>Sitio web</span>
                    <strong>
                        <% if (tieneSitio) { %>
                            <a href="<%= sitioWeb %>" target="_blank" rel="noopener noreferrer"><%= sitioWeb %></a>
                        <% } else { %>
                            Sin registrar
                        <% } %>
                    </strong>
                </div>

                <div class="info-row">
                    <span>Intereses</span>
                    <strong id="infoInterests"><%= intereses %></strong>
                </div>

                <div class="info-row">
                    <span>Biograf&iacute;a</span>
                    <strong><%= biografia %></strong>
                </div>
            </div>

            <div class="profile-panel">
                <h2>Mis cursos y progreso</h2>
                <div class="course-progress" id="profileCourseProgress">
                    <%
                        boolean hayCursos = false;
                        if (usuarioId != null) {
                            String sqlCursos = "SELECT titulo, porcentaje FROM usuario_cursos WHERE usuario_id = ? ORDER BY fecha_actualizacion DESC LIMIT 8";
                            try (Connection con = DBConnection.getConnection();
                                 PreparedStatement ps = con.prepareStatement(sqlCursos)) {
                                ps.setInt(1, usuarioId);
                                try (ResultSet rs = ps.executeQuery()) {
                                    while (rs.next()) {
                                        hayCursos = true;
                    %>
                                        <div class="progress-item">
                                            <strong><%= rs.getString("titulo") %></strong>
                                            <% if (rs.getInt("porcentaje") >= 100) { %>
                                                <span class="post-tag is-done">Curso finalizado</span>
                                            <% } else { %>
                                                <span class="post-tag">En curso - <%= rs.getInt("porcentaje") %>%</span>
                                            <% } %>
                                            <div class="progress-bar"><span style="width:<%= rs.getInt("porcentaje") %>%"></span></div>
                                        </div>
                    <%
                                    }
                                }
                            } catch (Exception ex) {
                    %>
                                <div class="progress-item"><strong>No se pudieron cargar tus cursos.</strong></div>
                    <%
                            }
                        }

                        if (!hayCursos) {
                    %>
                            <div class="progress-item"><strong>A&uacute;n no has agregado cursos a tu ruta.</strong></div>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="profile-panel">
                <h2>Talentos</h2>
                <div class="badge-list" id="talentList">
                    <%
                        if (!talentos.equals("Sin registrar")) {
                            String[] listaTalentos = talentos.split(",");
                            for (String talento : listaTalentos) {
                                if (!talento.trim().isEmpty()) {
                    %>
                                    <span><%= talento.trim() %></span>
                    <%
                                }
                            }
                        } else {
                    %>
                            <span>Sin registrar</span>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="profile-panel">
                <h2>Actividad reciente</h2>
                <%
                    boolean hayActividad = false;
                    if (usuarioId != null) {
                        String sqlActividad = "SELECT tipo, descripcion FROM usuario_actividad WHERE usuario_id = ? ORDER BY fecha_creacion DESC LIMIT 5";
                        try (Connection con = DBConnection.getConnection();
                             PreparedStatement ps = con.prepareStatement(sqlActividad)) {
                            ps.setInt(1, usuarioId);
                            try (ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                    hayActividad = true;
                %>
                                    <div class="info-row"><span><%= rs.getString("tipo") %></span><strong><%= rs.getString("descripcion") %></strong></div>
                <%
                                }
                            }
                        } catch (Exception ex) {
                %>
                            <div class="info-row"><span>Error</span><strong>No se pudo cargar la actividad.</strong></div>
                <%
                        }
                    }

                    if (!hayActividad) {
                %>
                        <div class="info-row"><span>Para empezar</span><strong>Agrega cursos o completa m&oacute;dulos para ver tu actividad reciente.</strong></div>
                <%
                    }
                %>
            </div>
        </section>
    </main>
    <script>
        window.RelaxZoneUser = "<%= usuarioKey %>";
    </script>
    <script src="js/courses-data.js?v=3"></script>
    <script>
        (function () {
            const container = document.getElementById("profileCourseProgress");
            if (!container || !window.RelaxZoneCourses) return;
            if (!container.textContent.includes("A\u00fan no has agregado") && !container.textContent.includes("No se pudieron")) return;

            let store = {};
            try {
                store = JSON.parse(localStorage.getItem("relaxzone.courseProgress.v2." + window.RelaxZoneUser)) || {};
            } catch (error) {
                store = {};
            }

            const added = window.RelaxZoneCourses.filter(function (course) {
                return store[course.id] && store[course.id].enrolled;
            });

            if (!added.length) return;

            container.innerHTML = "";
            let completed = 0;

            added.forEach(function (course) {
                const saved = store[course.id] || {};
                const modules = Array.isArray(saved.completedModules) ? saved.completedModules : [];
                const unique = modules.filter(function (value, index, array) {
                    return array.indexOf(value) === index && value >= 0 && value < course.modules.length;
                });
                const percent = course.modules.length ? Math.round((unique.length / course.modules.length) * 100) : 0;
                if (percent >= 100) completed += 1;

                const item = document.createElement("div");
                item.className = "progress-item";
                item.innerHTML = "<strong></strong> <span class=\"post-tag " + (percent >= 100 ? "is-done" : "") + "\"></span><div class=\"progress-bar\"><span></span></div>";
                item.querySelector("strong").textContent = course.title;
                item.querySelector(".post-tag").textContent = percent >= 100 ? "Curso finalizado" : "En curso - " + percent + "%";
                item.querySelector(".progress-bar span").style.width = percent + "%";
                container.appendChild(item);
            });

            document.getElementById("profileCourseCount").textContent = added.length;
            document.getElementById("profileCompletedCount").textContent = completed;
        })();
    </script>
</body>
</html>
