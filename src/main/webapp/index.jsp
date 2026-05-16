<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    boolean sesionActiva = nombreUsuario != null && !nombreUsuario.trim().isEmpty();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        .home-page {
            --ancho-tarjeta: 330px;
            --gap-tarjeta: 18px;
            --numero-tarjetas-unicas: 12;
            --ancho-bloque: calc((var(--ancho-tarjeta) + var(--gap-tarjeta)) * var(--numero-tarjetas-unicas));
        }

        .logo {
            text-decoration: none;
        }

        .home-shell {
            max-width: 1220px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .hero-split {
            min-height: calc(100vh - 86px);
            padding: 4rem 0 3rem;
        }

        .hero-texto h1 {
            font-size: clamp(2.8rem, 7vw, 5.8rem);
            letter-spacing: 0;
            max-width: 760px;
        }

        .hero-texto p {
            max-width: 650px;
        }

        .hero-botones a {
            text-decoration: none;
        }

        .btn-quiet {
            color: var(--color-texto);
            background: rgba(255, 255, 255, 0.58);
            border: 1px solid rgba(20, 51, 109, 0.18);
            border-radius: 8px;
            padding: 0.6rem 1.2rem;
            font-weight: 700;
        }

        .hero-imagen img {
            max-width: 620px;
            filter: drop-shadow(0 24px 35px rgba(2, 61, 85, 0.14));
        }

        .filter-group {
            display: grid;
            gap: 0.75rem;
        }

        .filter-group label {
            color: #ffffff;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .filter-options {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .filter-chip {
            border: 1px solid var(--color-borde);
            background: rgba(255,255,255,0.06);
            color: #ffffff;
            border-radius: 999px;
            padding: 0.45rem 0.7rem;
            cursor: pointer;
            font-family: var(--fuente-principal);
            font-weight: 700;
        }

        .filter-chip.activo {
            background: var(--color-primario);
            color: #062230;
            border-color: var(--color-primario);
        }

        .section-intro {
            max-width: 760px;
            margin: 0 auto 1.5rem;
            text-align: center;
        }

        .section-intro h2 {
            color: var(--color-texto);
            font-size: clamp(2rem, 4vw, 3.3rem);
            line-height: 1.05;
            margin-bottom: 0.8rem;
            letter-spacing: 0;
        }

        .section-intro p {
            color: #344a6b;
            font-size: 1rem;
        }

        .carrusel-container {
            padding: 1.6rem 0 2.4rem;
        }

        .carrusel-track {
            align-items: stretch;
            gap: var(--gap-tarjeta);
        }

        .home-course-card {
            flex: 0 0 var(--ancho-tarjeta);
            min-height: 430px;
            border: none;
            border-radius: 10px;
            overflow: hidden;
            color: #ffffff;
            text-decoration: none;
            background: var(--color-fondo-card);
            box-shadow: 0 18px 38px rgba(2, 61, 85, 0.18);
            position: relative;
            display: flex;
            flex-direction: column;
            transition: transform 0.28s ease, flex-basis 0.28s ease, box-shadow 0.28s ease;
        }

        .home-course-card:hover,
        .home-course-card.is-active {
            flex-basis: 390px;
            transform: translateY(-10px);
            box-shadow: 0 26px 54px rgba(2, 61, 85, 0.28);
        }

        .home-course-card .card-img-container {
            height: 245px;
            position: relative;
        }

        .home-course-card .card-img-container::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, rgba(2,61,85,0.02), rgba(2,61,85,0.72));
        }

        .home-course-card .card-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .home-course-card .card-contenido {
            padding: 1.25rem;
            gap: 0.6rem;
        }

        .home-course-card h3 {
            color: #ffffff;
            font-size: 1.25rem;
            line-height: 1.2;
        }

        .home-course-card p {
            color: var(--color-texto-suave);
            font-size: 0.92rem;
        }

        .tag {
            background: rgba(42, 201, 230, 0.16);
            color: var(--color-primario);
            border: 1px solid rgba(42, 201, 230, 0.26);
            border-radius: 999px;
            font-weight: 800;
        }

        .card-meta {
            display: flex;
            justify-content: space-between;
            gap: 0.8rem;
            color: var(--color-primario);
            font-size: 0.78rem;
            font-weight: 800;
            margin-top: auto;
            width: 100%;
        }

        .carrusel-container.filtrado {
            overflow: visible;
        }

        .carrusel-container.filtrado .carrusel-track {
            animation: none;
            width: 100%;
            flex-wrap: wrap;
            justify-content: center;
        }

        .carrusel-container.filtrado .home-course-card.duplicate {
            display: none !important;
        }

        .no-results {
            display: none;
            text-align: center;
            color: #344a6b;
            font-weight: 700;
            margin: 1rem 0 2rem;
        }

        .pillars-strip {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 1rem;
            margin: 1rem 0 3rem;
        }

        .pillar-card {
            background: #ffffff;
            border-radius: 10px;
            padding: 1.4rem;
            box-shadow: 0 14px 34px rgba(2, 61, 85, 0.1);
        }

        .pillar-card strong {
            color: var(--color-texto);
            display: block;
            font-size: 1.08rem;
            margin-bottom: 0.35rem;
        }

        .pillar-card p {
            color: #52657d;
            font-size: 0.9rem;
        }

        .home-cta {
            background: var(--color-fondo-card);
            color: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            margin: 3rem 0;
            display: grid;
            grid-template-columns: 1fr auto;
            align-items: center;
            gap: 1rem;
        }

        .home-cta h2 {
            color: #ffffff;
            font-size: clamp(1.7rem, 3vw, 2.5rem);
            line-height: 1.1;
        }

        .home-cta p {
            color: var(--color-texto-suave);
            margin-top: 0.5rem;
        }

        .home-cta a {
            text-decoration: none;
        }

        .about-zone {
            margin: 3rem 0;
            display: grid;
            grid-template-columns: minmax(0, 1.15fr) minmax(320px, 0.85fr);
            gap: 1rem;
            align-items: stretch;
        }

        .about-main,
        .mission-card,
        .vision-card,
        .faq-panel,
        .join-panel {
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 12px;
            box-shadow: 0 14px 34px rgba(2, 61, 85, 0.1);
        }

        .about-main {
            padding: 2rem;
        }

        .about-main h2,
        .faq-panel h2 {
            color: var(--color-texto);
            font-size: clamp(2rem, 4vw, 3rem);
            line-height: 1.05;
            margin-bottom: 1rem;
            letter-spacing: 0;
        }

        .about-main h3 {
            color: var(--color-primario);
            font-size: 1.05rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.7rem;
        }

        .about-main p,
        .faq-item p,
        .mission-card p,
        .vision-card p {
            color: #344a6b;
            font-size: 0.96rem;
        }

        .mission-stack {
            display: grid;
            gap: 1rem;
        }

        .mission-card,
        .vision-card {
            padding: 1.5rem;
        }

        .mission-card h3,
        .vision-card h3 {
            color: var(--color-texto);
            font-size: 1.35rem;
            margin-bottom: 0.7rem;
        }

        .faq-join-zone {
            margin: 3rem 0;
            display: grid;
            grid-template-columns: minmax(0, 1.6fr) minmax(300px, 0.7fr);
            gap: 1rem;
            align-items: stretch;
        }

        .faq-panel {
            padding: 2rem;
        }

        .faq-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1.3rem;
        }

        .faq-item h3 {
            color: var(--color-texto);
            font-size: 1rem;
            margin-bottom: 0.45rem;
        }

        .join-panel {
            background: var(--color-primario);
            color: #062230;
            padding: 2rem;
            border: none;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .join-panel h2 {
            color: #062230;
            font-size: 1.6rem;
            line-height: 1.15;
            margin-bottom: 1rem;
        }

        .join-panel p {
            color: #062230;
            font-size: 0.95rem;
        }

        .join-form {
            display: grid;
            gap: 0.75rem;
            margin-top: 1.2rem;
        }

        .join-form input {
            border: none;
            padding: 1rem;
            font-family: var(--fuente-principal);
            outline: none;
            border-radius: 6px;
        }

        .join-form button {
            border: none;
            background: #062230;
            color: var(--color-primario);
            padding: 0.9rem;
            border-radius: 6px;
            font-family: var(--fuente-principal);
            font-weight: 800;
            letter-spacing: 1px;
            cursor: pointer;
            text-transform: uppercase;
        }

        .join-banner {
            background: var(--color-fondo-card);
            color: #ffffff;
            text-align: center;
            padding: 4rem 2rem;
            border-top: 1px solid var(--color-borde);
            border-bottom: 1px solid var(--color-borde);
        }

        .join-banner h2 {
            color: #ffffff;
            max-width: 760px;
            margin: 0 auto 1.3rem;
            font-size: clamp(1.8rem, 4vw, 3rem);
            line-height: 1.15;
            letter-spacing: 0;
        }

        .join-banner a {
            display: inline-block;
            text-decoration: none;
        }

        @media (max-width: 900px) {
            .pillars-strip,
            .home-cta,
            .about-zone,
            .faq-join-zone {
                grid-template-columns: 1fr;
            }

            .home-course-card:hover,
            .home-course-card.is-active {
                flex-basis: var(--ancho-tarjeta);
            }
        }

        @media (max-width: 700px) {
            .home-shell {
                padding: 0 1rem;
            }

            .contenedor-nav {
                flex-wrap: wrap;
            }

            .busqueda-nav {
                order: 3;
                width: 100%;
            }

            .faq-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="home-page">
    <nav class="navbar">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo"><span class="logo-icon"></span> RELAX ZONE</a>

            <div class="busqueda-nav">
                <span class="icono-lupa"></span>
                <input type="text" id="searchInput" placeholder="Busca por emoción, talento, propósito...">
                <button id="btnToggleFiltros" class="btn-filtros-nav">Filtros</button>

                <div id="panelFiltros" class="panel-filtros-flotante oculto">
                    <div class="filter-group">
                        <label>Categoría</label>
                        <div class="filter-options">
                            <button class="filter-chip activo" type="button" data-filter="todas">Todas</button>
                            <button class="filter-chip" type="button" data-filter="bienestar">Bienestar</button>
                            <button class="filter-chip" type="button" data-filter="espiritualidad">Propósito</button>
                            <button class="filter-chip" type="button" data-filter="creatividad">Creatividad</button>
                            <button class="filter-chip" type="button" data-filter="hibrido">Híbridos</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="nav-links">
                <% if (sesionActiva) { %>
                    <span style="color:#ffffff; font-weight:600;">Bienvenido, <%= nombreUsuario %></span>
                    <a href="dashboard.jsp" class="link-secundario">Mis cursos</a>
                    <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                    <a href="perfil.jsp" class="link-secundario">Perfil</a>
                    <a href="LogoutServlet" class="link-secundario">Cerrar sesión</a>
                <% } else { %>
                    <a href="login.jsp" class="link-secundario">Entrar</a>
                    <a href="registro.jsp" class="btn-primario">Regístrate</a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="home-shell">
        <header class="hero-split">
            <div class="hero-texto">
                <h1>Encuentra tu centro, <br><span>potencia tu talento.</span></h1>
                <p>Una plataforma para aprender a conocerte, sanar, crear y vivir con propósito. Cursos gratuitos con lecturas, ejercicios y referencias que puedes aplicar a tu ritmo.</p>

                <div class="hero-botones">
                    <a href="categorias.jsp" class="btn-primario">Explorar cursos</a>
                    <a href="comunidad.jsp" class="btn-quiet">Crear comunidad</a>
                    <% if (sesionActiva) { %>
                        <a href="dashboard.jsp" class="btn-secundario">Continuar aprendiendo</a>
                    <% } else { %>
                        <a href="login.jsp" class="btn-secundario">Guardar mi avance</a>
                    <% } %>
                </div>
            </div>

            <div class="hero-imagen">
                <img src="img/imagen2.png" alt="Comunidad Relax Zone">
            </div>
        </header>

        <section class="pillars-strip" aria-label="Pilares de Relax Zone">
            <article class="pillar-card">
                <strong>Bienestar emocional</strong>
                <p>Aprende a identificar emociones, regular la mente y cuidar tu autoestima.</p>
            </article>
            <article class="pillar-card">
                <strong>Espiritualidad y propósito</strong>
                <p>Explora identidad, fe, sentido de vida y procesos de sanidad interior.</p>
            </article>
            <article class="pillar-card">
                <strong>Talento y creatividad</strong>
                <p>Descubre tus dones, crea contenido y conecta con personas para colaborar.</p>
            </article>
        </section>

        <section id="cursos">
            <div class="section-intro">
                <h2>Cursos disponibles</h2>
                <p>Selecciona una tarjeta para verla más grande o entra al curso para revisar módulos, recursos y actividades.</p>
            </div>

            <div class="carrusel-container" id="coursesCarousel">
                <div class="carrusel-track" id="coursesTrack">
                    <a class="home-course-card is-active" href="curso_detalle1.jsp?id=1" data-category="bienestar" data-keywords="gestion emociones bienestar identificar expresar reaccion comunicacion">
                        <div class="card-img-container"><img src="img/diez.jpg" alt="Gestión de emociones"></div>
                        <div class="card-contenido"><span class="tag">Bienestar</span><h3>Gestión de emociones</h3><p>Identifica, regula y expresa lo que sientes de forma saludable.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=2" data-category="bienestar" data-keywords="autoestima seguridad comparacion valor personal amor propio">
                        <div class="card-img-container"><img src="img/uno.jpg" alt="Sanando mi autoestima"></div>
                        <div class="card-contenido"><span class="tag">Bienestar</span><h3>Sanando mi autoestima</h3><p>Reconstruye tu valor personal y deja de vivir desde la comparación.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=3" data-category="bienestar" data-keywords="ansiedad sobrepensamiento calma mente presente respiracion">
                        <div class="card-img-container"><img src="img/seis.jpg" alt="Ansiedad y sobrepensamiento"></div>
                        <div class="card-contenido"><span class="tag">Bienestar</span><h3>Ansiedad y sobrepensamiento</h3><p>Técnicas prácticas para calmar la mente y volver al presente.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=4" data-category="espiritualidad" data-keywords="proposito identidad sentido vida espiritualidad valores">
                        <div class="card-img-container"><img src="img/dos.jpg" alt="Descubriendo mi propósito"></div>
                        <div class="card-contenido"><span class="tag">Propósito</span><h3>Descubriendo mi propósito</h3><p>Conecta identidad, dones y dirección para tu vida.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=5" data-category="espiritualidad" data-keywords="fe tiempos dificiles confianza proceso resiliencia esperanza">
                        <div class="card-img-container"><img src="img/siete.jpg" alt="Fe en tiempos difíciles"></div>
                        <div class="card-contenido"><span class="tag">Propósito</span><h3>Fe en tiempos difíciles</h3><p>Fortalece tu confianza cuando la vida se siente incierta.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=6" data-category="espiritualidad" data-keywords="sanidad interior heridas perdon pasado soltar">
                        <div class="card-img-container"><img src="img/tres.jpg" alt="Sanidad interior"></div>
                        <div class="card-contenido"><span class="tag">Propósito</span><h3>Sanidad interior</h3><p>Trabaja heridas emocionales, perdón y procesos para soltar.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=7" data-category="creatividad" data-keywords="talento creatividad dones habilidades miedo crear">
                        <div class="card-img-container"><img src="img/cinco.jpg" alt="Descubre tu talento"></div>
                        <div class="card-contenido"><span class="tag">Creatividad</span><h3>Descubre tu talento</h3><p>Explora habilidades y crea un primer mini proyecto.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=8" data-category="creatividad" data-keywords="redes contenido marca personal creatividad mostrarse">
                        <div class="card-img-container"><img src="img/ocho.jpg" alt="Crecer en redes"></div>
                        <div class="card-contenido"><span class="tag">Creatividad</span><h3>Crecer en redes</h3><p>Construye una presencia creativa sin perder autenticidad.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=9" data-category="creatividad" data-keywords="comunidad colaborar networking proyectos equipo">
                        <div class="card-img-container"><img src="img/cuatro.jpg" alt="Crear en comunidad"></div>
                        <div class="card-contenido"><span class="tag">Creatividad</span><h3>Crear en comunidad</h3><p>Conecta con otras personas para convertir ideas en proyectos.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=10" data-category="hibrido" data-keywords="crea proposito talento espiritualidad impacto ayudar">
                        <div class="card-img-container"><img src="img/imagen2.png" alt="Crea con propósito"></div>
                        <div class="card-contenido"><span class="tag">Híbrido</span><h3>Crea con propósito</h3><p>Une tu talento con impacto para ayudar a otras personas.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=11" data-category="hibrido" data-keywords="talento ingreso dinero oferta clientes mentalidad">
                        <div class="card-img-container"><img src="img/nueve.jpg" alt="De talento a ingreso"></div>
                        <div class="card-contenido"><span class="tag">Híbrido</span><h3>De talento a ingreso</h3><p>Convierte lo que sabes en una primera oferta honesta y útil.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card" href="curso_detalle1.jsp?id=12" data-category="hibrido" data-keywords="vida sentido habitos direccion proposito plan">
                        <div class="card-img-container"><img src="img/imagen1.png" alt="Vida con sentido"></div>
                        <div class="card-contenido"><span class="tag">Híbrido</span><h3>Vida con sentido</h3><p>Diseña hábitos, prioridades y dirección con intención.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>

                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=1" data-category="bienestar" data-keywords="gestion emociones bienestar identificar expresar reaccion comunicacion">
                        <div class="card-img-container"><img src="img/diez.jpg" alt="Gestión de emociones"></div>
                        <div class="card-contenido"><span class="tag">Bienestar</span><h3>Gestión de emociones</h3><p>Identifica, regula y expresa lo que sientes de forma saludable.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=2" data-category="bienestar" data-keywords="autoestima seguridad comparacion valor personal amor propio">
                        <div class="card-img-container"><img src="img/uno.jpg" alt="Sanando mi autoestima"></div>
                        <div class="card-contenido"><span class="tag">Bienestar</span><h3>Sanando mi autoestima</h3><p>Reconstruye tu valor personal y deja de vivir desde la comparación.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=3" data-category="bienestar" data-keywords="ansiedad sobrepensamiento calma mente presente respiracion">
                        <div class="card-img-container"><img src="img/seis.jpg" alt="Ansiedad y sobrepensamiento"></div>
                        <div class="card-contenido"><span class="tag">Bienestar</span><h3>Ansiedad y sobrepensamiento</h3><p>Técnicas prácticas para calmar la mente y volver al presente.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=4" data-category="espiritualidad" data-keywords="proposito identidad sentido vida espiritualidad valores">
                        <div class="card-img-container"><img src="img/dos.jpg" alt="Descubriendo mi propósito"></div>
                        <div class="card-contenido"><span class="tag">Propósito</span><h3>Descubriendo mi propósito</h3><p>Conecta identidad, dones y dirección para tu vida.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=5" data-category="espiritualidad" data-keywords="fe tiempos dificiles confianza proceso resiliencia esperanza">
                        <div class="card-img-container"><img src="img/siete.jpg" alt="Fe en tiempos difíciles"></div>
                        <div class="card-contenido"><span class="tag">Propósito</span><h3>Fe en tiempos difíciles</h3><p>Fortalece tu confianza cuando la vida se siente incierta.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=6" data-category="espiritualidad" data-keywords="sanidad interior heridas perdon pasado soltar">
                        <div class="card-img-container"><img src="img/tres.jpg" alt="Sanidad interior"></div>
                        <div class="card-contenido"><span class="tag">Propósito</span><h3>Sanidad interior</h3><p>Trabaja heridas emocionales, perdón y procesos para soltar.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=7" data-category="creatividad" data-keywords="talento creatividad dones habilidades miedo crear">
                        <div class="card-img-container"><img src="img/cinco.jpg" alt="Descubre tu talento"></div>
                        <div class="card-contenido"><span class="tag">Creatividad</span><h3>Descubre tu talento</h3><p>Explora habilidades y crea un primer mini proyecto.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=8" data-category="creatividad" data-keywords="redes contenido marca personal creatividad mostrarse">
                        <div class="card-img-container"><img src="img/ocho.jpg" alt="Crecer en redes"></div>
                        <div class="card-contenido"><span class="tag">Creatividad</span><h3>Crecer en redes</h3><p>Construye una presencia creativa sin perder autenticidad.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=9" data-category="creatividad" data-keywords="comunidad colaborar networking proyectos equipo">
                        <div class="card-img-container"><img src="img/cuatro.jpg" alt="Crear en comunidad"></div>
                        <div class="card-contenido"><span class="tag">Creatividad</span><h3>Crear en comunidad</h3><p>Conecta con otras personas para convertir ideas en proyectos.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=10" data-category="hibrido" data-keywords="crea proposito talento espiritualidad impacto ayudar">
                        <div class="card-img-container"><img src="img/imagen2.png" alt="Crea con propósito"></div>
                        <div class="card-contenido"><span class="tag">Híbrido</span><h3>Crea con propósito</h3><p>Une tu talento con impacto para ayudar a otras personas.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=11" data-category="hibrido" data-keywords="talento ingreso dinero oferta clientes mentalidad">
                        <div class="card-img-container"><img src="img/nueve.jpg" alt="De talento a ingreso"></div>
                        <div class="card-contenido"><span class="tag">Híbrido</span><h3>De talento a ingreso</h3><p>Convierte lo que sabes en una primera oferta honesta y útil.</p><div class="card-meta"><span>4 módulos</span><span>Ver curso</span></div></div>
                    </a>
                    <a class="home-course-card duplicate" href="curso_detalle1.jsp?id=12" data-category="hibrido" data-keywords="vida sentido habitos direccion proposito plan">
                        <div class="card-img-container"><img src="img/imagen1.png" alt="Vida con sentido"></div>
                        <div class="card-contenido"><span class="tag">Híbrido</span><h3>Vida con sentido</h3><p>Diseña hábitos, prioridades y dirección con intención.</p><div class="card-meta"><span>5 módulos</span><span>Ver curso</span></div></div>
                    </a>
                </div>
            </div>
            <p class="no-results" id="noResults">No encontramos cursos con esos filtros. Prueba con otra palabra.</p>
        </section>

        <section class="home-cta">
            <div>
                <h2>Talento, bienestar y propósito se construyen mejor acompañados.</h2>
                <p>Entra al espacio social para compartir procesos, encontrar colaboradores y participar en retos creativos.</p>
            </div>
            <a href="comunidad.jsp" class="btn-primario">Crear comunidad</a>
        </section>

        <section class="about-zone" id="sobre-nosotros">
            <div class="about-main">
                <h3>Sobre Nosotros</h3>
                <h2>¿Quiénes somos?</h2>
                <p>Relax Zone es una comunidad y plataforma enfocada en el crecimiento personal, creativo y espiritual de jóvenes con talentos, ideas y deseo de impactar positivamente a otros.</p>
                <br>
                <p>Nace con la intención de crear un espacio donde las personas puedan descubrir su valor, desarrollar sus habilidades y conectar con otros que compartan el deseo de crecer y vivir con propósito.</p>
                <br>
                <p>Creemos que cada persona tiene algo especial que aportar al mundo, y que el talento, acompañado de apoyo, comunidad y dirección, puede convertirse en una herramienta para transformar vidas.</p>
            </div>
            <div class="mission-stack">
                <article class="mission-card">
                    <h3>Misión</h3>
                    <p>Brindar un espacio de crecimiento personal, creativo y espiritual donde las personas puedan desarrollar sus talentos, fortalecer su bienestar emocional y conectar con una comunidad que inspire apoyo, propósito e impacto positivo.</p>
                </article>
                <article class="vision-card">
                    <h3>Visión</h3>
                    <p>Ser una comunidad reconocida por impulsar talentos y transformar vidas mediante la creatividad, el acompañamiento y el crecimiento integral, creando oportunidades donde las personas puedan sentirse valoradas, escuchadas y capaces de generar un cambio positivo en su entorno.</p>
                </article>
            </div>
        </section>

        <section class="faq-join-zone">
            <div class="faq-panel">
                <h2>Preguntas frecuentes</h2>
                <div class="faq-grid">
                    <article class="faq-item">
                        <h3>¿Tienen algún costo los cursos?</h3>
                        <p>La idea principal es ofrecer contenido gratuito y accesible. Algunas colaboraciones o talleres especiales pueden ayudar a sostener el proyecto.</p>
                    </article>
                    <article class="faq-item">
                        <h3>¿Cómo puedo colaborar?</h3>
                        <p>Puedes sumar ideas, creatividad, apoyo, talleres, donaciones o proyectos que ayuden a más personas a crecer y conectar.</p>
                    </article>
                    <article class="faq-item">
                        <h3>¿Necesito experiencia previa?</h3>
                        <p>No. Los cursos están pensados para empezar desde cero, con ejercicios sencillos y rutas claras.</p>
                    </article>
                    <article class="faq-item">
                        <h3>¿Es un grupo religioso?</h3>
                        <p>No es un grupo religioso. Integramos espiritualidad, propósito y valores desde una mirada abierta, respetuosa y enfocada en crecimiento personal.</p>
                    </article>
                </div>
            </div>

            <aside class="join-panel">
                <h2>¿Quieres sumar tu talento?</h2>
                <p>En Relax Zone creemos que cada persona puede aportar algo valioso. Ya sea compartiendo ideas, creatividad, apoyo o colaborando con nosotros, cada pequeña contribución ayuda a seguir construyendo espacios donde más personas puedan crecer, conectar y descubrir su propósito.</p>
                <form class="join-form">
                    <input type="email" placeholder="Tu correo electrónico">
                    <button type="button">Quiero colaborar</button>
                </form>
            </aside>
        </section>
    </main>

    <section class="join-banner">
        <h2>Un espacio donde se conectan talentos y se crean proyectos juntos.</h2>
        <a href="login.jsp" class="btn-primario">Únete hoy</a>
    </section>

    <footer class="footer-pro">
        <div class="footer-grid">
            <div class="footer-col">
                <span class="logo-icon"></span> <strong>RELAX ZONE</strong>
                <p>Apoyo emocional, creativo y espiritual para impulsar talentos con propósito.</p>
            </div>
            <div class="footer-col">
                <h4>Comunidad</h4>
                <a href="#sobre-nosotros">Sobre nosotros</a>
                <a href="#sobre-nosotros">Nuestra misión</a>
                <a href="comunidad.jsp">Espacio social</a>
            </div>
            <div class="footer-col">
                <h4>Aprende</h4>
                <a href="categorias.jsp">Categorías</a>
                <a href="dashboard.jsp">Mis cursos</a>
                <a href="registro.jsp">Registro</a>
            </div>
            <div class="footer-col">
                <h4>Contacto</h4>
                <p>hola@relaxzone.com</p>
                <p>Monterrey, México</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 Ximena & Kevin | FCFM Programación Web I</p>
        </div>
    </footer>

    <script src="js/index.js"></script>
</body>
</html>
