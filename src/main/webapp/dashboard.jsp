<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) {
        nombreUsuario = "Estudiante";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
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
            align-items: stretch;
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
            padding: 2rem;
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
            font-size: clamp(2rem, 5vw, 3.6rem);
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
            margin-top: 1.5rem;
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
            padding: 1.4rem;
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
            grid-template-columns: 38px 1fr;
            gap: 0.8rem;
            align-items: center;
            padding: 0.85rem 0;
            border-top: 1px solid rgba(255, 255, 255, 0.12);
        }

        .route-number {
            width: 38px;
            height: 38px;
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
            font-size: 0.95rem;
        }

        .route-step span {
            color: var(--color-texto-suave);
            font-size: 0.82rem;
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
            grid-template-columns: repeat(4, minmax(0, 1fr));
        }

        .course-card {
            border-radius: 10px;
            overflow: hidden;
            text-decoration: none;
            transition: transform 0.25s ease, border-color 0.25s ease;
        }

        .course-thumb {
            height: 160px;
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
            font-size: 1.02rem;
            line-height: 1.28;
            margin-bottom: 0.5rem;
        }

        .course-body p {
            color: var(--color-texto-suave);
            font-size: 0.88rem;
            min-height: 58px;
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

            .contenedor-nav {
                flex-wrap: wrap;
            }

            .busqueda-nav {
                order: 3;
                width: 100%;
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
                <input type="text" id="courseSearch" placeholder="¿Qué quieres aprender hoy?">
            </div>
            <div class="nav-links">
                <span style="color:#ffffff; font-weight:600;">Hola, <%= nombreUsuario %></span>
                <a href="categorias.jsp" class="link-secundario">Catálogo</a>
                <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                <a href="perfil.jsp" class="link-secundario">Perfil</a>
                <a href="LogoutServlet" class="link-secundario">Cerrar sesión</a>
            </div>
        </div>
    </nav>

    <main class="dashboard-shell">
        <section class="dashboard-top">
            <div class="welcome-panel">
                <div>
                    <p class="eyebrow">Creados con propósito</p>
                    <h1><%= nombreUsuario %>, continúa aprendiendo</h1>
                    <p>Un espacio para conocerte, sanar, crear y caminar con propósito. Elige una ruta y avanza con lecturas, ejercicios y referencias en video.</p>
                    <div class="welcome-actions">
                        <a href="#recomendados" class="btn-primario">Explorar cursos</a>
                        <a href="#mi-ruta" class="btn-light">Ver mi ruta</a>
                    </div>
                </div>
                <div class="hero-stack">
                    <div class="mini-stat">
                        <strong>12</strong>
                        <span>cursos recomendados</span>
                    </div>
                    <div class="mini-stat">
                        <strong>3</strong>
                        <span>pilares: bienestar, espiritualidad y creatividad</span>
                    </div>
                    <div class="mini-stat">
                        <strong>0$</strong>
                        <span>contenido pensado para aprender sin cobros</span>
                    </div>
                </div>
            </div>

            <aside class="route-panel" id="mi-ruta">
                <h2>Mi ruta sugerida</h2>
                <p>Empieza por entenderte, luego fortalece tu propósito y termina creando algo real.</p>
                <div class="route-step">
                    <span class="route-number">1</span>
                    <div>
                        <strong>Gestión emocional</strong>
                        <span>Identificar lo que sientes y expresarlo mejor.</span>
                    </div>
                </div>
                <div class="route-step">
                    <span class="route-number">2</span>
                    <div>
                        <strong>Propósito e identidad</strong>
                        <span>Ordenar tus valores, dones y dirección.</span>
                    </div>
                </div>
                <div class="route-step">
                    <span class="route-number">3</span>
                    <div>
                        <strong>Crear en comunidad</strong>
                        <span>Convertir tus ideas en proyectos compartidos.</span>
                    </div>
                </div>
            </aside>
        </section>

        <section aria-labelledby="progreso-title">
            <div class="section-header">
                <div>
                    <h2 class="section-title" id="progreso-title">Continúa aprendiendo</h2>
                    <p>Retoma los cursos que ayudan a construir tu base personal.</p>
                </div>
            </div>
            <div class="progress-grid">
                <a class="progress-card" href="curso_detalle1.jsp?id=1">
                    <div class="progress-ring" style="--value: 45%;"><span>45%</span></div>
                    <div>
                        <h3>Gestión de emociones desde cero</h3>
                        <p>Vas en el módulo de expresión emocional.</p>
                    </div>
                </a>
                <a class="progress-card" href="curso_detalle1.jsp?id=4">
                    <div class="progress-ring" style="--value: 25%;"><span>25%</span></div>
                    <div>
                        <h3>Descubriendo mi propósito</h3>
                        <p>Siguiente: mapa de valores personales.</p>
                    </div>
                </a>
                <a class="progress-card" href="curso_detalle1.jsp?id=7">
                    <div class="progress-ring" style="--value: 15%;"><span>15%</span></div>
                    <div>
                        <h3>Descubre tu talento</h3>
                        <p>Prueba ejercicios de exploración creativa.</p>
                    </div>
                </a>
            </div>
        </section>

        <section aria-labelledby="descubre-title">
            <div class="section-header">
                <div>
                    <h2 class="section-title" id="descubre-title">Descubre lo que puedes aprender</h2>
                    <p>Inspirado en la estructura de plataformas de cursos, pero enfocado en teoría práctica, reflexión, comunidad y recursos externos.</p>
                </div>
            </div>

            <div class="featured-grid">
                <div class="featured-copy">
                    <h2>Aprende habilidades esenciales para tu vida interior y creativa</h2>
                    <p>Elige un curso recomendado y entra al desglose con objetivos, temas, actividades, lecturas y videos sugeridos.</p>
                </div>
                <a class="featured-card" href="curso_detalle1.jsp?id=3">
                    <img src="img/seis.jpg" alt="Curso de ansiedad y sobrepensamiento">
                    <div>Ansiedad y sobrepensamiento <span>&rarr;</span></div>
                </a>
                <a class="featured-card" href="curso_detalle1.jsp?id=10">
                    <img src="img/imagen2.png" alt="Curso crea con propósito">
                    <div>Crea con propósito <span>&rarr;</span></div>
                </a>
                <a class="featured-card" href="curso_detalle1.jsp?id=8">
                    <img src="img/ocho.jpg" alt="Curso crecer en redes siendo creativo">
                    <div>Crecer en redes <span>&rarr;</span></div>
                </a>
            </div>
        </section>

        <section aria-labelledby="recomendados-title" id="recomendados">
            <div class="section-header">
                <div>
                    <h2 class="section-title" id="recomendados-title">Cursos recomendados para ti</h2>
                    <p>Filtra desde la barra de búsqueda por nombre, categoría o tema.</p>
                </div>
            </div>

            <div class="course-grid" id="courseGrid">
                <a class="course-card" href="curso_detalle1.jsp?id=1" data-course="gestion emociones bienestar identificar expresar">
                    <div class="course-thumb"><img src="img/diez.jpg" alt="Gestión de emociones"><span class="course-badge">Bienestar</span></div>
                    <div class="course-body"><h3>Gestión de emociones desde cero</h3><p>Identifica, regula y expresa lo que sientes de forma saludable.</p><div class="course-meta"><span>4 módulos</span><span>Lectura + práctica</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=2" data-course="autoestima bienestar seguridad comparacion amor propio">
                    <div class="course-thumb"><img src="img/uno.jpg" alt="Sanando mi autoestima"><span class="course-badge">Bienestar</span></div>
                    <div class="course-body"><h3>Sanando mi autoestima</h3><p>Reconstruye tu valor personal y deja de vivir desde la comparación.</p><div class="course-meta"><span>4 módulos</span><span>Ejercicios guiados</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=3" data-course="ansiedad sobrepensamiento bienestar calma mente presente">
                    <div class="course-thumb"><img src="img/seis.jpg" alt="Ansiedad y sobrepensamiento"><span class="course-badge">Bienestar</span></div>
                    <div class="course-body"><h3>Ansiedad y sobrepensamiento</h3><p>Aprende técnicas para calmar la mente y volver al presente.</p><div class="course-meta"><span>5 módulos</span><span>Herramientas</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=4" data-course="proposito espiritual identidad sentido vida conexion">
                    <div class="course-thumb"><img src="img/dos.jpg" alt="Descubriendo mi propósito"><span class="course-badge">Espiritual</span></div>
                    <div class="course-body"><h3>Descubriendo mi propósito</h3><p>Explora identidad, sentido de vida y conexión espiritual.</p><div class="course-meta"><span>4 módulos</span><span>Reflexión</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=5" data-course="fe espiritual tiempos dificiles confianza resiliencia procesos">
                    <div class="course-thumb"><img src="img/siete.jpg" alt="Fe en tiempos difíciles"><span class="course-badge">Espiritual</span></div>
                    <div class="course-body"><h3>Fe en tiempos difíciles</h3><p>Fortalece tu confianza y resiliencia cuando todo parece incierto.</p><div class="course-meta"><span>4 módulos</span><span>Devocional</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=6" data-course="sanidad interior espiritual perdon heridas pasado soltar">
                    <div class="course-thumb"><img src="img/tres.jpg" alt="Sanidad interior"><span class="course-badge">Espiritual</span></div>
                    <div class="course-body"><h3>Sanidad interior</h3><p>Trabaja heridas emocionales, perdón y procesos para soltar el pasado.</p><div class="course-meta"><span>5 módulos</span><span>Diario personal</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=7" data-course="talento creatividad dones habilidades miedo crear">
                    <div class="course-thumb"><img src="img/cinco.jpg" alt="Descubre tu talento"><span class="course-badge">Creatividad</span></div>
                    <div class="course-body"><h3>Descubre tu talento</h3><p>Identifica habilidades, prueba áreas creativas y pierde el miedo.</p><div class="course-meta"><span>4 módulos</span><span>Reto creativo</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=8" data-course="redes creatividad contenido marca personal mostrarse">
                    <div class="course-thumb"><img src="img/ocho.jpg" alt="Crecer en redes siendo creativo"><span class="course-badge">Creatividad</span></div>
                    <div class="course-body"><h3>Crecer en redes siendo creativo</h3><p>Ordena ideas, contenido y marca personal sin perder autenticidad.</p><div class="course-meta"><span>5 módulos</span><span>Plantillas</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=9" data-course="comunidad creatividad colaborar networking proyectos equipo">
                    <div class="course-thumb"><img src="img/cuatro.jpg" alt="Colaborar y crear en comunidad"><span class="course-badge">Creatividad</span></div>
                    <div class="course-body"><h3>Colaborar y crear en comunidad</h3><p>Aprende a trabajar con otros y convertir ideas en proyectos.</p><div class="course-meta"><span>4 módulos</span><span>Proyecto grupal</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=10" data-course="crea proposito hibrido talento espiritualidad impacto ayudar">
                    <div class="course-thumb"><img src="img/imagen2.png" alt="Crea con propósito"><span class="course-badge">Híbrido</span></div>
                    <div class="course-body"><h3>Crea con propósito</h3><p>Une talento y propósito para crear algo que ayude a otras personas.</p><div class="course-meta"><span>5 módulos</span><span>Proyecto final</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=11" data-course="talento ingreso hibrido dinero mentalidad clientes">
                    <div class="course-thumb"><img src="img/nueve.jpg" alt="De talento a ingreso"><span class="course-badge">Híbrido</span></div>
                    <div class="course-body"><h3>De talento a ingreso</h3><p>Convierte lo que sabes en una primera oferta sencilla y honesta.</p><div class="course-meta"><span>4 módulos</span><span>Oferta inicial</span></div></div>
                </a>
                <a class="course-card" href="curso_detalle1.jsp?id=12" data-course="vida sentido hibrido habitos direccion proposito">
                    <div class="course-thumb"><img src="img/imagen1.png" alt="Construyendo una vida con sentido"><span class="course-badge">Híbrido</span></div>
                    <div class="course-body"><h3>Construyendo una vida con sentido</h3><p>Diseña hábitos, prioridades y dirección para una vida más intencional.</p><div class="course-meta"><span>5 módulos</span><span>Plan personal</span></div></div>
                </a>
            </div>
        </section>

        <section class="community-panel">
            <div>
                <h2>Comunidad Relax Zone</h2>
                <p>Comparte avances, pide retroalimentación y encuentra personas para crear contigo.</p>
            </div>
            <a href="perfil.jsp" class="btn-primario">Ver mi perfil</a>
        </section>
    </main>

    <script>
        const searchInput = document.getElementById("courseSearch");
        const courseCards = document.querySelectorAll("#courseGrid .course-card");

        searchInput.addEventListener("input", function () {
            const term = this.value.toLowerCase().trim();

            courseCards.forEach(function (card) {
                const text = (card.textContent + " " + card.dataset.course).toLowerCase();
                card.style.display = text.includes(term) ? "" : "none";
            });
        });
    </script>
</body>
</html>
