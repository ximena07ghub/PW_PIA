<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    String usuarioKey = (String) session.getAttribute("nombreUsuarioLogin");
    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) {
        nombreUsuario = "Estudiante";
    }
    if (usuarioKey == null || usuarioKey.trim().isEmpty()) {
        usuarioKey = nombreUsuario;
    }
    usuarioKey = usuarioKey.replaceAll("[^A-Za-z0-9_.-]", "_");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curso - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
    <style>
        .detalle-shell {
            max-width: 1180px;
            margin: 0 auto;
            padding: 2rem;
        }

        .back-link {
            color: var(--color-texto);
            text-decoration: none;
            font-weight: 700;
            display: inline-flex;
            margin-bottom: 1rem;
        }

        .course-hero {
            background: var(--color-fondo-card);
            border: 1px solid var(--color-borde);
            border-radius: 12px;
            color: #ffffff;
            overflow: hidden;
            display: grid;
            grid-template-columns: minmax(0, 1.1fr) 420px;
            min-height: 360px;
            box-shadow: 0 18px 40px rgba(2, 61, 85, 0.12);
        }

        .course-hero-text {
            padding: 2.3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .course-hero-text h1 {
            color: #ffffff;
            font-size: clamp(2rem, 5vw, 3.7rem);
            line-height: 1;
            letter-spacing: 0;
            margin-bottom: 1rem;
        }

        .course-hero-text p {
            color: var(--color-texto-suave);
            font-size: 1.02rem;
            max-width: 680px;
        }

        .course-category {
            color: var(--color-primario);
            text-transform: uppercase;
            font-size: 0.78rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 0.7rem;
        }

        .course-hero-image {
            min-height: 300px;
            position: relative;
            background: #023d55;
        }

        .course-hero-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            inset: 0;
        }

        .course-hero-image::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(90deg, rgba(2,61,85,0.5), rgba(2,61,85,0.08));
        }

        .hero-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
            margin-top: 1.5rem;
        }

        .hero-actions .btn-primario {
            display: inline-block;
            text-decoration: none;
        }

        .btn-outline-light {
            color: #ffffff;
            border: 1px solid rgba(255,255,255,0.45);
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        .detalle-grid {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 330px;
            gap: 1.5rem;
            margin-top: 1.5rem;
            align-items: start;
        }

        .detail-panel,
        .side-panel {
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 12px;
            padding: 1.5rem;
        }

        .detail-panel + .detail-panel {
            margin-top: 1rem;
        }

        .detail-panel h2,
        .side-panel h2 {
            color: var(--color-texto);
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .learn-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 0.8rem 1.3rem;
        }

        .growth-grid,
        .related-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 1rem;
        }

        .dimension-card,
        .course-brief {
            border: 1px solid #d8e5ec;
            border-radius: 10px;
            background: #f8fcfd;
            padding: 1rem;
        }

        .dimension-card h3,
        .course-brief h3 {
            color: var(--color-texto);
            font-size: 1rem;
            margin-bottom: 0.45rem;
        }

        .dimension-card p,
        .course-brief p {
            color: #344a6b;
            font-size: 0.94rem;
        }

        .learn-item {
            display: grid;
            grid-template-columns: 24px 1fr;
            gap: 0.6rem;
            color: #263955;
            font-size: 0.95rem;
        }

        .check {
            color: var(--color-primario);
            font-weight: 900;
        }

        .topic-list,
        .includes-list,
        .resource-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.65rem;
            list-style: none;
        }

        .topic-list li {
            border: 1px solid var(--color-borde);
            border-radius: 8px;
            padding: 0.45rem 0.7rem;
            font-weight: 800;
            color: var(--color-texto);
            background: #f8fcfd;
            font-size: 0.88rem;
        }

        .includes-list {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .includes-list li,
        .resource-list a {
            color: #263955;
            text-decoration: none;
        }

        .includes-list li {
            border: 1px solid #d8e5ec;
            border-radius: 8px;
            background: #f8fcfd;
            padding: 0.7rem 0.8rem;
            font-weight: 800;
        }

        .resource-list {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .resource-list a {
            border: 1px solid #d8e5ec;
            border-radius: 8px;
            padding: 1rem;
            background: #f8fcfd;
            font-weight: 700;
            display: grid;
            gap: 0.25rem;
            transition: transform 0.2s ease, border-color 0.2s ease;
        }

        .resource-list a:hover {
            transform: translateY(-3px);
            border-color: var(--color-primario);
        }

        .resource-type {
            width: fit-content;
            color: #062230;
            background: var(--color-primario);
            border-radius: 999px;
            padding: 0.2rem 0.55rem;
            font-size: 0.72rem;
            font-weight: 900;
        }

        .resource-list small {
            color: #52657d;
            font-weight: 600;
        }

        .module-list {
            display: grid;
            gap: 0.75rem;
        }

        .module-item {
            border: 1px solid #d8e5ec;
            border-radius: 10px;
            overflow: hidden;
            background: #f8fcfd;
        }

        .module-item[open] {
            border-color: rgba(42, 201, 230, 0.55);
            box-shadow: 0 12px 28px rgba(2, 61, 85, 0.08);
        }

        .module-item summary {
            cursor: pointer;
            padding: 1rem;
            font-weight: 800;
            color: var(--color-texto);
        }

        .module-item[open] summary {
            background: #edfafe;
        }

        .module-theory {
            color: #344a6b;
            padding: 0 1rem 0.8rem;
            line-height: 1.65;
        }

        .module-item ul {
            list-style: none;
            padding: 0 1rem 1rem;
            color: #344a6b;
        }

        .module-item li {
            padding: 0.35rem 0;
            border-top: 1px solid #e6eef2;
        }

        .module-practice {
            color: var(--color-texto);
            font-weight: 800;
            background: rgba(42, 201, 230, 0.12);
            border-radius: 8px;
            margin-top: 0.55rem;
            padding: 0.65rem;
        }

        .module-quote {
            margin: 0 1rem 1rem;
            border-left: 4px solid var(--color-primario);
            color: var(--color-texto);
            background: #ffffff;
            border-radius: 8px;
            padding: 0.8rem 1rem;
            font-weight: 800;
        }

        .related-card {
            background: var(--color-fondo-card);
            color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            text-decoration: none;
            border: 1px solid var(--color-borde);
            transition: transform 0.2s ease, border-color 0.2s ease;
        }

        .related-card:hover {
            transform: translateY(-4px);
            border-color: var(--color-primario);
        }

        .related-card .course-thumb {
            height: 180px;
            position: relative;
        }

        .related-card .course-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .related-card .course-body {
            padding: 1rem;
        }

        .related-card .course-body h3 {
            color: #ffffff;
            font-size: 1rem;
            margin-bottom: 0.45rem;
        }

        .related-card .course-body p {
            color: var(--color-texto-suave);
            font-size: 0.88rem;
        }

        .related-card .course-meta,
        .related-card .course-badge {
            display: none;
        }

        .module-complete {
            margin: 0 1rem 1rem;
            border: 1px solid var(--color-borde);
            background: #ffffff;
            color: var(--color-texto);
            border-radius: 8px;
            padding: 0.7rem 0.9rem;
            font-family: var(--fuente-principal);
            font-weight: 800;
            cursor: pointer;
        }

        .module-complete.is-done {
            background: var(--color-primario);
            border-color: var(--color-primario);
            color: #062230;
        }

        .side-panel {
            position: sticky;
            top: 94px;
        }

        .side-panel .btn-primario {
            display: block;
            text-align: center;
            text-decoration: none;
            width: 100%;
            cursor: pointer;
            border: none;
            font-family: var(--fuente-principal);
        }

        .side-note {
            color: #52657d;
            font-size: 0.9rem;
            margin: 1rem 0;
        }

        .course-progress {
            margin: 1rem 0;
        }

        .course-progress-track {
            width: 100%;
            height: 10px;
            background: #e6eef2;
            border-radius: 999px;
            overflow: hidden;
        }

        .course-progress-fill {
            width: 0%;
            height: 100%;
            background: var(--color-primario);
            transition: width 0.25s ease;
        }

        .course-progress-text {
            color: var(--color-texto);
            display: block;
            margin-top: 0.45rem;
            font-weight: 800;
        }

        .facts {
            display: grid;
            gap: 0.75rem;
            margin-top: 1.2rem;
            color: #263955;
        }

        .facts div {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            border-top: 1px solid #e6eef2;
            padding-top: 0.75rem;
        }

        .facts strong {
            color: var(--color-texto);
        }

        .course-completion-modal {
            position: fixed;
            inset: 0;
            display: none;
            place-items: center;
            padding: 1rem;
            background: rgba(0, 17, 31, 0.58);
            z-index: 2200;
        }

        .course-completion-modal.is-open {
            display: grid;
        }

        .completion-card {
            width: min(520px, 100%);
            background: var(--color-fondo-card);
            color: #ffffff;
            border: 1px solid var(--color-borde);
            border-radius: 12px;
            padding: 1.8rem;
            box-shadow: 0 24px 60px rgba(0, 17, 31, 0.3);
            text-align: center;
        }

        .completion-card h2 {
            color: #ffffff;
            font-size: 1.8rem;
            margin-bottom: 0.6rem;
        }

        .completion-card p {
            color: var(--color-texto-suave);
            margin-bottom: 1rem;
        }

        .completion-badge {
            width: 84px;
            height: 84px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            margin: 0 auto 1rem;
            background: var(--color-primario);
            color: #062230;
            font-size: 2rem;
            font-weight: 900;
        }

        .completion-actions {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .completion-actions a,
        .completion-actions button {
            border: 1px solid rgba(255,255,255,0.35);
            border-radius: 8px;
            padding: 0.6rem 1rem;
            font-family: var(--fuente-principal);
            font-weight: 900;
            text-decoration: none;
            cursor: pointer;
        }

        .completion-actions a {
            background: var(--color-primario);
            color: #062230;
            border-color: var(--color-primario);
        }

        .completion-actions button {
            background: transparent;
            color: #ffffff;
        }

        @media (max-width: 950px) {
            .course-hero,
            .detalle-grid {
                grid-template-columns: 1fr;
            }

            .side-panel {
                position: static;
            }
        }

        @media (max-width: 680px) {
            .detalle-shell {
                padding: 1rem;
            }

            .learn-grid,
            .includes-list,
            .growth-grid,
            .resource-list,
            .related-grid {
                grid-template-columns: 1fr;
            }

            .course-hero-text {
                padding: 1.35rem;
            }

            .course-hero-image {
                min-height: 220px;
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
            <div class="busqueda-nav">
                <span class="icono-lupa"></span>
                <input type="text" id="quickSearch" placeholder="Buscar dentro del curso">
            </div>
            <div class="nav-links">
                <span style="color:#ffffff; font-weight:600;">Hola, <%= nombreUsuario %></span>
                <a href="dashboard.jsp" class="link-secundario">Mis cursos</a>
                <a href="categorias.jsp" class="link-secundario">Cat&aacute;logo</a>
                <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                <a href="perfil.jsp" class="link-secundario">Perfil</a>
                <a href="LogoutServlet" class="link-secundario">Cerrar sesi&oacute;n</a>
            </div>
        </div>
    </nav>

    <main class="detalle-shell">
        <a href="dashboard.jsp" class="back-link">&larr; Volver a mis cursos</a>

        <section class="course-hero">
            <div class="course-hero-text">
                <p class="course-category" id="courseCategory">Curso</p>
                <h1 id="courseTitle">Cargando curso...</h1>
                <p id="courseDescription">Estamos preparando el contenido del curso seleccionado.</p>
                <div class="hero-actions">
                    <a href="#contenido" class="btn-primario">Ver contenido</a>
                    <a href="#recursos" class="btn-outline-light">Recursos sugeridos</a>
                </div>
            </div>
            <div class="course-hero-image">
                <img id="courseImage" src="img/imagen2.png" alt="Imagen del curso">
            </div>
        </section>

        <div class="detalle-grid">
            <div>
                <section class="detail-panel">
                    <h2>Lo que aprender&aacute;s</h2>
                    <div class="learn-grid" id="learnList"></div>
                </section>

                <section class="detail-panel">
                    <h2>Ver temas relacionados</h2>
                    <ul class="topic-list" id="topicList"></ul>
                </section>

                <section class="detail-panel">
                    <h2>Este curso incluye</h2>
                    <ul class="includes-list" id="includesList"></ul>
                </section>

                <section class="detail-panel" id="contenido">
                    <h2>Contenido del curso</h2>
                    <div class="module-list" id="moduleList"></div>
                </section>

                <section class="detail-panel" id="recursos">
                    <h2>Lecturas y videos sugeridos</h2>
                    <div class="resource-list" id="resourceList"></div>
                </section>

                <section class="detail-panel">
                    <h2>Tambi&eacute;n te puede interesar</h2>
                    <div class="related-grid" id="relatedCourses"></div>
                </section>
            </div>

            <aside class="side-panel">
                <h2>Empieza gratis</h2>
                <p class="side-note">Este contenido es educativo y no sustituye terapia, consejeria profesional ni acompa&ntilde;amiento pastoral. Si una situacion te rebasa, busca apoyo de una persona profesional o de confianza.</p>
                <div class="course-progress" aria-label="Progreso del curso">
                    <div class="course-progress-track">
                        <div class="course-progress-fill" id="courseProgressBar"></div>
                    </div>
                    <span class="course-progress-text" id="courseProgressText">0% completado</span>
                </div>
                <button type="button" class="btn-primario" id="startCourseButton">Agregar a mis cursos</button>
                <div class="facts">
                    <div><span>Nivel</span><strong id="courseLevel">Inicial</strong></div>
                    <div><span>Duraci&oacute;n</span><strong id="courseDuration">4 semanas</strong></div>
                    <div><span>Formato</span><strong id="courseFormat">Lectura y pr&aacute;ctica</strong></div>
                    <div><span>Acceso</span><strong>Gratuito</strong></div>
                </div>
            </aside>
        </div>
    </main>

    <div class="course-completion-modal" id="courseCompletionModal" aria-hidden="true">
        <div class="completion-card" role="dialog" aria-modal="true" aria-labelledby="completionTitle">
            <div class="completion-badge">100%</div>
            <h2 id="completionTitle">Curso finalizado</h2>
            <p>Felicidades, completaste <strong id="completionCourseTitle">este curso</strong>. Tu logro ya aparece en tu perfil.</p>
            <div class="completion-actions">
                <a href="perfil.jsp">Ver mi perfil</a>
                <button type="button" id="closeCompletionModal">Seguir repasando</button>
            </div>
        </div>
    </div>

    <script>
        window.RelaxZoneUser = "<%= usuarioKey %>";
        window.RelaxZoneLoggedIn = <%= session.getAttribute("usuarioId") == null ? "false" : "true" %>;
    </script>
    <script src="js/courses-data.js?v=3"></script>
    <script src="js/courses-pages.js?v=4"></script>
    <script>
        RelaxZoneCoursesPages.initDetail();
        document.getElementById("closeCompletionModal").addEventListener("click", function () {
            const modal = document.getElementById("courseCompletionModal");
            modal.classList.remove("is-open");
            modal.setAttribute("aria-hidden", "true");
        });
    </script>
</body>
</html>
