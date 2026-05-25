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
    String textoPerfilRuta = String.valueOf(session.getAttribute("intereses")) + " " + String.valueOf(session.getAttribute("talentos"));
    textoPerfilRuta = textoPerfilRuta.replace("\\", "\\\\").replace("\"", "\\\"").replace("\r", " ").replace("\n", " ");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
    <style>
        .dashboard-shell {
            max-width: 1220px;
            margin: 0 auto;
            padding: 2rem;
        }

        .dashboard-top {
            display: grid;
            grid-template-columns: minmax(0, 1.1fr) 320px;
            gap: 1.5rem;
            align-items: start;
            margin-bottom: 2rem;
        }

        .welcome-panel,
        .route-panel,
        .course-card,
        .progress-card,
        .community-panel {
            background: var(--color-fondo-card);
            border: 1px solid var(--color-borde);
            color: #ffffff;
            box-shadow: 0 18px 40px rgba(2, 61, 85, 0.12);
        }

        .welcome-panel {
            border-radius: 12px;
            padding: 1.7rem 2rem;
            display: grid;
            grid-template-columns: minmax(0, 1fr) 260px;
            gap: 1.5rem;
            overflow: hidden;
        }

        .eyebrow {
            color: var(--color-primario);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 1px;
            margin-bottom: 0.65rem;
        }

        .welcome-panel h1 {
            font-size: clamp(2rem, 4.4vw, 3.25rem);
            line-height: 1;
            color: #ffffff;
            margin-bottom: 1rem;
            letter-spacing: 0;
        }

        .welcome-panel p {
            color: var(--color-texto-suave);
            max-width: 620px;
            font-size: 1rem;
        }

        .welcome-actions {
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
            margin-top: 1.2rem;
        }

        .welcome-actions .btn-primario,
        .community-panel .btn-primario {
            display: inline-block;
            text-decoration: none;
        }

        .btn-light {
            border: 1px solid rgba(255, 255, 255, 0.45);
            color: #ffffff;
            padding: 0.6rem 1.1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        .hero-stack {
            display: grid;
            gap: 0.7rem;
            align-content: center;
        }

        .mini-stat {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 10px;
            padding: 1rem;
        }

        .mini-stat strong {
            display: block;
            color: var(--color-primario);
            font-size: 1.6rem;
            line-height: 1;
        }

        .mini-stat span {
            color: var(--color-texto-suave);
            font-size: 0.88rem;
        }

        .route-panel {
            border-radius: 12px;
            padding: 1.25rem 1.4rem;
            max-height: 365px;
            overflow-y: auto;
            scrollbar-width: thin;
        }

        .route-panel h2,
        .section-title {
            font-size: 1.35rem;
            color: var(--color-texto);
            margin-bottom: 0.35rem;
        }

        .route-panel h2 {
            color: #ffffff;
        }

        .route-panel p {
            color: var(--color-texto-suave);
            font-size: 0.92rem;
            margin-bottom: 1.2rem;
        }

        .route-step {
            display: grid;
            grid-template-columns: 34px 1fr;
            gap: 0.7rem;
            align-items: center;
            padding: 0.65rem 0;
            border-top: 1px solid rgba(255, 255, 255, 0.12);
        }

        .route-number {
            width: 34px;
            height: 34px;
            border-radius: 8px;
            background: var(--color-primario);
            color: #062230;
            display: grid;
            place-items: center;
            font-weight: 800;
        }

        .route-step strong {
            display: block;
            color: #ffffff;
            font-size: 0.9rem;
        }

        .route-step span {
            color: var(--color-texto-suave);
            font-size: 0.76rem;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            align-items: end;
            margin: 2.2rem 0 1rem;
        }

        .section-header p {
            color: #344a6b;
            max-width: 620px;
        }

        .progress-grid,
        .featured-grid,
        .course-grid {
            display: grid;
            gap: 1rem;
        }

        .progress-grid {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }

        .progress-card {
            border-radius: 10px;
            padding: 1.1rem;
            display: grid;
            grid-template-columns: 68px 1fr;
            gap: 1rem;
            align-items: center;
            text-decoration: none;
            transition: transform 0.25s ease, border-color 0.25s ease;
        }

        .progress-card:hover,
        .course-card:hover {
            transform: translateY(-5px);
            border-color: var(--color-primario);
        }

        .progress-ring {
            width: 66px;
            height: 66px;
            border-radius: 50%;
            background: conic-gradient(var(--color-primario) var(--value), rgba(255,255,255,0.12) 0);
            display: grid;
            place-items: center;
        }

        .progress-ring span {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: var(--color-fondo-card);
            display: grid;
            place-items: center;
            color: #ffffff;
            font-weight: 800;
            font-size: 0.8rem;
        }

        .progress-card h3 {
            color: #ffffff;
            font-size: 1rem;
            line-height: 1.25;
        }

        .progress-card p {
            color: var(--color-texto-suave);
            font-size: 0.86rem;
        }

        .progress-card.is-complete {
            border-color: rgba(42, 201, 230, 0.85);
        }

        .progress-achievement {
            display: inline-flex;
            width: fit-content;
            margin-top: 0.55rem;
            border-radius: 999px;
            padding: 0.25rem 0.65rem;
            background: rgba(42, 201, 230, 0.18);
            color: #ffffff;
            border: 1px solid rgba(42, 201, 230, 0.55);
            font-size: 0.74rem;
            font-weight: 900;
        }

        .progress-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.75rem;
        }

        .progress-actions a,
        .progress-actions button {
            border: 1px solid rgba(255, 255, 255, 0.38);
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-radius: 8px;
            padding: 0.42rem 0.72rem;
            font-family: var(--fuente-principal);
            font-weight: 900;
            font-size: 0.78rem;
            text-decoration: none;
            cursor: pointer;
        }

        .progress-actions a {
            background: var(--color-primario);
            color: #062230;
            border-color: var(--color-primario);
        }

        .featured-grid {
            grid-template-columns: 1.15fr repeat(3, 1fr);
            align-items: stretch;
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 14px;
            padding: 1.2rem;
        }

        .featured-copy {
            padding: 1rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .featured-copy h2 {
            color: var(--color-texto);
            font-size: 1.85rem;
            line-height: 1.15;
            margin-bottom: 0.8rem;
        }

        .featured-copy p {
            color: #52657d;
        }

        .featured-card {
            min-height: 245px;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            text-decoration: none;
            color: #ffffff;
            background: #023d55;
            display: flex;
            align-items: flex-end;
        }

        .featured-card img,
        .course-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            inset: 0;
        }

        .featured-card::after,
        .course-thumb::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, rgba(2,61,85,0.05), rgba(2,61,85,0.88));
        }

        .featured-card div {
            position: relative;
            z-index: 1;
            width: calc(100% - 1.6rem);
            margin: 0.8rem;
            padding: 0.9rem;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.92);
            color: var(--color-texto);
            font-weight: 800;
            min-height: 74px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.8rem;
        }

        .course-grid {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }

        .course-card {
            border-radius: 10px;
            overflow: hidden;
            text-decoration: none;
            transition: transform 0.25s ease, border-color 0.25s ease;
            min-height: 100%;
        }

        .course-thumb {
            height: 220px;
            position: relative;
            background: #023d55;
        }

        .course-badge {
            position: absolute;
            z-index: 2;
            top: 0.75rem;
            left: 0.75rem;
            background: var(--color-primario);
            color: #062230;
            border-radius: 999px;
            padding: 0.25rem 0.65rem;
            font-size: 0.75rem;
            font-weight: 800;
        }

        .course-body {
            padding: 1.1rem;
        }

        .course-body h3 {
            color: #ffffff;
            font-size: 1.18rem;
            line-height: 1.28;
            margin-bottom: 0.5rem;
        }

        .course-body p {
            color: var(--color-texto-suave);
            font-size: 0.92rem;
            min-height: 72px;
        }

        .empty-progress {
            display: none;
            color: #344a6b;
            font-weight: 800;
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 10px;
            padding: 1rem;
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            gap: 0.8rem;
            color: var(--color-primario);
            font-weight: 700;
            font-size: 0.78rem;
            margin-top: 1rem;
        }

        .community-panel {
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 2.5rem;
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 1rem;
            align-items: center;
        }

        .community-panel h2 {
            color: #ffffff;
            margin-bottom: 0.35rem;
        }

        .community-panel p {
            color: var(--color-texto-suave);
        }

        @media (max-width: 1040px) {
            .dashboard-top,
            .welcome-panel,
            .featured-grid,
            .community-panel {
                grid-template-columns: 1fr;
            }

            .progress-grid,
            .course-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 700px) {
            .dashboard-shell {
                padding: 1rem;
            }

            .welcome-panel {
                padding: 1.35rem;
            }

            .contenedor-nav {
                flex-wrap: wrap;
            }

            .busqueda-nav {
                order: 3;
                width: 100%;
            }

            .featured-card,
            .course-thumb {
                min-height: 210px;
            }

            .progress-grid,
            .course-grid {
                grid-template-columns: 1fr;
            }

            .section-header {
                align-items: flex-start;
                flex-direction: column;
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
                <input type="text" id="courseSearch" placeholder="&iquest;Qu&eacute; quieres aprender hoy?">
            </div>
            <div class="nav-links">
                <span style="color:#ffffff; font-weight:600;">Hola, <%= nombreUsuario %></span>
                <a href="categorias.jsp" class="link-secundario">Cat&aacute;logo</a>
                <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                <a href="perfil.jsp" class="link-secundario">Perfil</a>
                <a href="LogoutServlet" class="link-secundario">Cerrar sesi&oacute;n</a>
            </div>
        </div>
    </nav>

    <main class="dashboard-shell">
        <section class="dashboard-top">
            <div class="welcome-panel">
                <div>
                    <p class="eyebrow">Creados con prop&oacute;sito</p>
                    <h1><%= nombreUsuario %>, contin&uacute;a aprendiendo</h1>
                    <p>Un espacio para conocerte, sanar, crear y caminar con prop&oacute;sito. Elige una ruta y avanza con lecturas, ejercicios y referencias en video.</p>
                    <div class="welcome-actions">
                        <a href="#recomendados" class="btn-primario">Explorar cursos</a>
                        <a href="#mi-ruta" class="btn-light">Ver mi ruta</a>
                    </div>
                </div>
                <div class="hero-stack">
                    <div class="mini-stat">
                        <strong id="totalCourses">12</strong>
                        <span>cursos recomendados</span>
                    </div>
                    <div class="mini-stat">
                        <strong id="activeCourses">0</strong>
                        <span>cursos agregados a tu ruta</span>
                    </div>
                    <div class="mini-stat">
                        <strong>0$</strong>
                        <span>contenido pensado para aprender sin cobros</span>
                    </div>
                </div>
            </div>

            <%-- Ruta sugerida: JS la ordena con cursos agregados e intereses --%>
            <aside class="route-panel" id="mi-ruta">
                <h2>Mi ruta sugerida</h2>
                <p id="routeIntro">Empieza por lo que ya buscas o por el siguiente curso pendiente en tu ruta.</p>
                <div id="routeSteps"></div>
            </aside>
        </section>

        <section aria-labelledby="progreso-title">
            <div class="section-header">
                <div>
                    <h2 class="section-title" id="progreso-title">Contin&uacute;a aprendiendo</h2>
                    <p>Retoma los cursos que ayudan a construir tu base personal.</p>
                </div>
            </div>
            <p class="empty-progress" id="emptyProgress">Agrega cursos o completa m&oacute;dulos para empezar tu ruta.</p>
            <div class="progress-grid" id="progressGrid"></div>
        </section>

        <section aria-labelledby="descubre-title">
            <div class="section-header">
                <div>
                    <h2 class="section-title" id="descubre-title">Descubre lo que puedes aprender</h2>
                    <p>Inspirado en la estructura de plataformas de cursos, pero enfocado en teor&iacute;a pr&aacute;ctica, reflexi&oacute;n, comunidad y recursos externos.</p>
                </div>
            </div>

            <div class="featured-grid" id="featuredGrid"></div>
        </section>

        <section aria-labelledby="recomendados-title" id="recomendados">
            <div class="section-header">
                <div>
                    <h2 class="section-title" id="recomendados-title">Cursos recomendados para ti</h2>
                    <p>Filtra desde la barra de b&uacute;squeda por nombre, categor&iacute;a o tema.</p>
                </div>
            </div>

            <div class="course-grid" id="courseGrid"></div>
        </section>

        <section class="community-panel">
            <div>
                <h2>Comunidad Relax Zone</h2>
                <p>Comparte avances, pide retroalimentaci&oacute;n y encuentra personas para crear contigo.</p>
            </div>
            <a href="perfil.jsp" class="btn-primario">Ver mi perfil</a>
        </section>
    </main>

    <script>
        window.RelaxZoneUser = "<%= usuarioKey %>";
        window.RelaxZoneLoggedIn = true;
        window.RelaxZoneProfileText = "<%= textoPerfilRuta %>";
    </script>
    <script src="js/courses-data.js?v=3"></script>
    <script src="js/courses-pages.js?v=4"></script>
    <script>
        RelaxZoneCoursesPages.initDashboard();
    </script>
</body>
</html>
