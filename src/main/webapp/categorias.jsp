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
    <title>Categorías - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
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
        }

        .catalog-chip.activo {
            background: var(--color-primario);
            color: #062230;
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
            transition: transform 0.25s ease;
        }

        .catalog-card:hover {
            transform: translateY(-6px);
        }

        .catalog-image {
            height: 190px;
            position: relative;
        }

        .catalog-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .catalog-card-body {
            padding: 1.15rem;
        }

        .catalog-card-body span {
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
            font-size: 1.18rem;
            line-height: 1.25;
            margin-bottom: 0.5rem;
        }

        .catalog-card-body p {
            color: var(--color-texto-suave);
            font-size: 0.9rem;
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
                    <a href="registro.jsp" class="btn-primario">Regístrate</a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="catalog-shell">
        <section class="catalog-hero">
            <div>
                <h1>Explora por categorías</h1>
                <p>Encuentra cursos según lo que hoy necesitas trabajar: bienestar emocional, propósito, creatividad o rutas híbridas para transformar talento en impacto.</p>
            </div>
            <div class="catalog-summary">
                <div class="summary-card"><strong>12</strong><span>cursos listos</span></div>
                <div class="summary-card"><strong>4</strong><span>categorías principales</span></div>
                <div class="summary-card"><strong>0$</strong><span>acceso gratuito</span></div>
            </div>
        </section>

        <section class="catalog-tools">
            <div class="catalog-search">
                <input id="catalogSearch" type="text" placeholder="Busca por autoestima, ansiedad, propósito, redes, talento...">
            </div>
            <div class="catalog-filters">
                <button class="catalog-chip activo" type="button" data-filter="todas">Todas</button>
                <button class="catalog-chip" type="button" data-filter="bienestar">Bienestar</button>
                <button class="catalog-chip" type="button" data-filter="espiritualidad">Propósito</button>
                <button class="catalog-chip" type="button" data-filter="creatividad">Creatividad</button>
                <button class="catalog-chip" type="button" data-filter="hibrido">Híbridos</button>
            </div>
        </section>

        <section class="catalog-grid" id="catalogGrid">
            <a class="catalog-card" href="curso_detalle1.jsp?id=1" data-category="bienestar" data-keywords="emociones bienestar expresar regular">
                <div class="catalog-image"><img src="img/diez.jpg" alt="Gestión de emociones"></div>
                <div class="catalog-card-body"><span>Bienestar</span><h2>Gestión de emociones desde cero</h2><p>Aprende a identificar y expresar emociones sin reprimirlas.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=2" data-category="bienestar" data-keywords="autoestima seguridad comparacion amor propio">
                <div class="catalog-image"><img src="img/uno.jpg" alt="Sanando mi autoestima"></div>
                <div class="catalog-card-body"><span>Bienestar</span><h2>Sanando mi autoestima</h2><p>Reconstruye seguridad y valor personal con ejercicios guiados.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=3" data-category="bienestar" data-keywords="ansiedad sobrepensamiento calma mente">
                <div class="catalog-image"><img src="img/seis.jpg" alt="Ansiedad y sobrepensamiento"></div>
                <div class="catalog-card-body"><span>Bienestar</span><h2>Ansiedad y sobrepensamiento</h2><p>Herramientas para calmar la mente y volver al presente.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=4" data-category="espiritualidad" data-keywords="proposito identidad sentido vida">
                <div class="catalog-image"><img src="img/dos.jpg" alt="Descubriendo mi propósito"></div>
                <div class="catalog-card-body"><span>Propósito</span><h2>Descubriendo mi propósito</h2><p>Conecta tus valores, dones y dirección personal.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=5" data-category="espiritualidad" data-keywords="fe confianza resiliencia esperanza">
                <div class="catalog-image"><img src="img/siete.jpg" alt="Fe en tiempos difíciles"></div>
                <div class="catalog-card-body"><span>Propósito</span><h2>Fe en tiempos difíciles</h2><p>Reflexiones y prácticas para sostener confianza.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=6" data-category="espiritualidad" data-keywords="sanidad interior perdon heridas pasado">
                <div class="catalog-image"><img src="img/tres.jpg" alt="Sanidad interior"></div>
                <div class="catalog-card-body"><span>Propósito</span><h2>Sanidad interior</h2><p>Procesos de perdón, límites y cuidado interno.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=7" data-category="creatividad" data-keywords="talento creatividad dones habilidades">
                <div class="catalog-image"><img src="img/cinco.jpg" alt="Descubre tu talento"></div>
                <div class="catalog-card-body"><span>Creatividad</span><h2>Descubre tu talento</h2><p>Explora habilidades y crea sin esperar perfección.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=8" data-category="creatividad" data-keywords="redes contenido marca personal">
                <div class="catalog-image"><img src="img/ocho.jpg" alt="Crecer en redes"></div>
                <div class="catalog-card-body"><span>Creatividad</span><h2>Crecer en redes siendo creativo</h2><p>Contenido, marca personal y presencia auténtica.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=9" data-category="creatividad" data-keywords="comunidad colaborar networking proyectos">
                <div class="catalog-image"><img src="img/cuatro.jpg" alt="Colaborar en comunidad"></div>
                <div class="catalog-card-body"><span>Creatividad</span><h2>Colaborar y crear en comunidad</h2><p>Aprende a trabajar en equipo y conectar talentos.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=10" data-category="hibrido" data-keywords="crea proposito talento impacto">
                <div class="catalog-image"><img src="img/imagen2.png" alt="Crea con propósito"></div>
                <div class="catalog-card-body"><span>Híbrido</span><h2>Crea con propósito</h2><p>Une talento, espiritualidad e impacto personal.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=11" data-category="hibrido" data-keywords="talento ingreso oferta clientes">
                <div class="catalog-image"><img src="img/nueve.jpg" alt="De talento a ingreso"></div>
                <div class="catalog-card-body"><span>Híbrido</span><h2>De talento a ingreso</h2><p>Diseña una primera oferta honesta y útil.</p></div>
            </a>
            <a class="catalog-card" href="curso_detalle1.jsp?id=12" data-category="hibrido" data-keywords="vida sentido habitos direccion">
                <div class="catalog-image"><img src="img/imagen1.png" alt="Vida con sentido"></div>
                <div class="catalog-card-body"><span>Híbrido</span><h2>Construyendo una vida con sentido</h2><p>Hábitos, prioridades y plan personal de 90 días.</p></div>
            </a>
        </section>
        <p class="empty-message" id="catalogEmpty">No encontramos cursos con esos filtros.</p>
    </main>

    <script>
        const catalogSearch = document.getElementById("catalogSearch");
        const catalogCards = document.querySelectorAll(".catalog-card");
        const chips = document.querySelectorAll(".catalog-chip");
        const empty = document.getElementById("catalogEmpty");
        let active = "todas";

        function normalize(text) {
            return text.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
        }

        function filterCatalog() {
            const term = normalize(catalogSearch.value.trim());
            let count = 0;

            catalogCards.forEach(function (card) {
                const categoryMatch = active === "todas" || card.dataset.category === active;
                const textMatch = term === "" || normalize(card.textContent + " " + card.dataset.keywords).includes(term);
                const show = categoryMatch && textMatch;
                card.style.display = show ? "" : "none";
                if (show) count += 1;
            });

            empty.style.display = count === 0 ? "block" : "none";
        }

        catalogSearch.addEventListener("input", filterCatalog);
        chips.forEach(function (chip) {
            chip.addEventListener("click", function () {
                chips.forEach(function (item) { item.classList.remove("activo"); });
                chip.classList.add("activo");
                active = chip.dataset.filter;
                filterCatalog();
            });
        });
    </script>
</body>
</html>
