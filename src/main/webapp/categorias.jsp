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
    <title>Categor&iacute;as - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
    <style>
        .catalog-shell {
            max-width: 1220px;
            margin: 0 auto;
            padding: 2rem;
        }

        .catalog-hero {
            background: var(--color-fondo-card);
            color: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            display: grid;
            grid-template-columns: minmax(0, 1fr) 320px;
            gap: 1.5rem;
            align-items: center;
            border: 1px solid var(--color-borde);
        }

        .catalog-hero h1 {
            color: #ffffff;
            font-size: clamp(2.4rem, 6vw, 4.8rem);
            line-height: 1;
            letter-spacing: 0;
            margin-bottom: 1rem;
        }

        .catalog-hero p {
            color: var(--color-texto-suave);
            max-width: 700px;
        }

        .catalog-summary {
            display: grid;
            gap: 0.75rem;
        }

        .summary-card {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.16);
            border-radius: 10px;
            padding: 1rem;
        }

        .summary-card strong {
            color: var(--color-primario);
            display: block;
            font-size: 1.6rem;
            line-height: 1;
        }

        .catalog-tools {
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 1rem;
            align-items: center;
            margin: 1.5rem 0;
        }

        .catalog-search {
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 10px;
            padding: 0.85rem 1rem;
        }

        .catalog-search input {
            width: 100%;
            border: none;
            outline: none;
            font-family: var(--fuente-principal);
            color: var(--color-texto);
            font-size: 1rem;
        }

        .catalog-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 0.55rem;
        }

        .catalog-chip {
            border: none;
            background: #ffffff;
            color: var(--color-texto);
            border-radius: 999px;
            padding: 0.65rem 0.85rem;
            font-family: var(--fuente-principal);
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 22px rgba(2, 61, 85, 0.08);
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
        }

        .catalog-chip.activo {
            background: var(--color-primario);
            color: #062230;
        }

        .catalog-chip span {
            min-width: 24px;
            height: 24px;
            border-radius: 999px;
            display: inline-grid;
            place-items: center;
            background: rgba(2, 61, 85, 0.1);
            font-size: 0.76rem;
        }

        .catalog-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 1rem;
        }

        .catalog-card {
            background: var(--color-fondo-card);
            border-radius: 10px;
            overflow: hidden;
            text-decoration: none;
            color: #ffffff;
            box-shadow: 0 18px 38px rgba(2, 61, 85, 0.16);
            border: 1px solid rgba(112, 149, 170, 0.65);
            transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
        }

        .catalog-card:hover {
            transform: translateY(-6px);
            border-color: var(--color-primario);
            box-shadow: 0 24px 52px rgba(2, 61, 85, 0.22);
        }

        .catalog-image {
            height: 250px;
            position: relative;
            background: #023d55;
        }

        .catalog-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .catalog-card-body {
            padding: 1.15rem;
        }

        .catalog-card-body > span {
            display: inline-block;
            color: var(--color-primario);
            background: rgba(42, 201, 230, 0.12);
            border-radius: 999px;
            padding: 0.3rem 0.65rem;
            font-weight: 800;
            font-size: 0.78rem;
            margin-bottom: 0.7rem;
        }

        .catalog-card-body h2 {
            color: #ffffff;
            font-size: 1.32rem;
            line-height: 1.25;
            margin-bottom: 0.5rem;
        }

        .catalog-card-body p {
            color: var(--color-texto-suave);
            font-size: 0.95rem;
        }

        .catalog-card-body .course-meta {
            display: flex;
            justify-content: space-between;
            gap: 0.8rem;
            font-size: 0.78rem;
            font-weight: 800;
            margin-top: 1rem;
        }

        .catalog-card-body .course-meta span {
            color: #062230;
            background: rgba(42, 201, 230, 0.9);
            border-radius: 999px;
            padding: 0.25rem 0.55rem;
        }

        .empty-message {
            display: none;
            text-align: center;
            color: #344a6b;
            font-weight: 800;
            margin: 2rem 0;
        }

        @media (max-width: 980px) {
            .catalog-hero,
            .catalog-tools,
            .catalog-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 680px) {
            .catalog-shell {
                padding: 1rem;
            }

            .catalog-hero {
                padding: 1.35rem;
            }

            .catalog-filters {
                flex-wrap: nowrap;
                overflow-x: auto;
                padding-bottom: 0.25rem;
            }

            .catalog-chip {
                white-space: nowrap;
            }

            .catalog-image {
                height: 215px;
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
                <% if (sesionActiva) { %>
                    <a href="dashboard.jsp" class="link-secundario">Mis cursos</a>
                    <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                    <a href="perfil.jsp" class="link-secundario">Perfil</a>
                <% } else { %>
                    <a href="login.jsp" class="link-secundario">Entrar</a>
                    <a href="registro.jsp" class="btn-primario">Reg&iacute;strate</a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="catalog-shell">
        <section class="catalog-hero">
            <div>
                <h1>Explora por categor&iacute;as</h1>
                <p>Encuentra cursos seg&uacute;n lo que hoy necesitas trabajar: bienestar emocional, prop&oacute;sito, creatividad o rutas h&iacute;bridas para transformar talento en impacto.</p>
            </div>
            <div class="catalog-summary">
                <div class="summary-card"><strong>12</strong><span>cursos listos</span></div>
                <div class="summary-card"><strong>4</strong><span>categor&iacute;as principales</span></div>
                <div class="summary-card"><strong>0$</strong><span>acceso gratuito</span></div>
            </div>
        </section>

        <section class="catalog-tools">
            <div class="catalog-search">
                <input id="catalogSearch" type="text" placeholder="Busca por autoestima, ansiedad, prop&oacute;sito, redes, talento...">
            </div>
            <div class="catalog-filters">
                <button class="catalog-chip activo" type="button" data-filter="todas">Todas</button>
                <button class="catalog-chip" type="button" data-filter="bienestar">Bienestar</button>
                <button class="catalog-chip" type="button" data-filter="espiritualidad">Prop&oacute;sito</button>
                <button class="catalog-chip" type="button" data-filter="creatividad">Creatividad</button>
                <button class="catalog-chip" type="button" data-filter="hibrido">H&iacute;bridos</button>
            </div>
        </section>

        <section class="catalog-grid" id="catalogGrid"></section>
        <p class="empty-message" id="catalogEmpty">No encontramos cursos con esos filtros.</p>
    </main>

    <script src="js/courses-data.js?v=2"></script>
    <script src="js/courses-pages.js?v=4"></script>
    <script>window.RelaxZoneLoggedIn = <%= sesionActiva ? "true" : "false" %>;</script>
    <script>
        RelaxZoneCoursesPages.initCatalog();
    </script>
</body>
</html>
