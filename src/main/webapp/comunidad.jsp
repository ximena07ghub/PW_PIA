<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    boolean sesionActiva = nombreUsuario != null && !nombreUsuario.trim().isEmpty();
    if (!sesionActiva) nombreUsuario = "Invitado";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comunidad - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .community-shell {
            max-width: 1220px;
            margin: 0 auto;
            padding: 2rem;
        }

        .community-hero {
            background: var(--color-fondo-card);
            color: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            display: grid;
            grid-template-columns: minmax(0, 1fr) 360px;
            gap: 1.5rem;
            align-items: stretch;
            border: 1px solid var(--color-borde);
            box-shadow: 0 18px 40px rgba(2, 61, 85, 0.12);
        }

        .community-hero h1 {
            color: #ffffff;
            font-size: clamp(2.4rem, 6vw, 4.8rem);
            line-height: 1;
            letter-spacing: 0;
            margin-bottom: 1rem;
        }

        .community-hero p {
            color: var(--color-texto-suave);
            max-width: 720px;
        }

        .reflection-card {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.16);
            border-radius: 12px;
            padding: 1.4rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .reflection-card span {
            color: var(--color-primario);
            font-weight: 800;
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 1px;
        }

        .reflection-card strong {
            display: block;
            color: #ffffff;
            font-size: 1.55rem;
            line-height: 1.2;
            margin-top: 0.7rem;
        }

        .community-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.25fr) minmax(320px, 0.75fr);
            gap: 1rem;
            margin-top: 1.5rem;
            align-items: start;
        }

        .community-panel {
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 12px;
            padding: 1.5rem;
        }

        .community-panel.dark {
            background: var(--color-fondo-card);
            color: #ffffff;
            border-color: var(--color-borde);
        }

        .community-panel h2 {
            color: var(--color-texto);
            font-size: 1.45rem;
            margin-bottom: 1rem;
        }

        .community-panel.dark h2 {
            color: #ffffff;
        }

        .post-form {
            display: grid;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .post-form textarea,
        .post-form select,
        .post-form input {
            width: 100%;
            border: 1px solid #d8e5ec;
            border-radius: 8px;
            padding: 0.85rem;
            font-family: var(--fuente-principal);
            outline: none;
        }

        .post-form textarea {
            min-height: 110px;
            resize: vertical;
        }

        .post-form-row {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 0.75rem;
        }

        .post-card {
            border-top: 1px solid #e6eef2;
            padding: 1rem 0;
        }

        .post-card strong {
            color: var(--color-texto);
            display: block;
            margin-bottom: 0.25rem;
        }

        .post-card p {
            color: #344a6b;
        }

        .post-tag {
            display: inline-block;
            margin-top: 0.7rem;
            background: #edfafe;
            color: var(--color-texto);
            border-radius: 999px;
            padding: 0.25rem 0.65rem;
            font-size: 0.78rem;
            font-weight: 800;
        }

        .talent-table {
            width: 100%;
            border-collapse: collapse;
        }

        .talent-table th,
        .talent-table td {
            text-align: left;
            padding: 0.8rem;
            border-top: 1px solid #e6eef2;
            color: #263955;
        }

        .talent-table th {
            color: var(--color-texto);
        }

        .safe-list,
        .event-list {
            display: grid;
            gap: 0.75rem;
        }

        .safe-list div,
        .event-list div {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.14);
            border-radius: 10px;
            padding: 1rem;
        }

        .safe-list strong,
        .event-list strong {
            color: var(--color-primario);
            display: block;
            margin-bottom: 0.25rem;
        }

        .safe-list p,
        .event-list p {
            color: var(--color-texto-suave);
        }

        .split-panels {
            display: grid;
            gap: 1rem;
        }

        .community-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            margin-top: 1.3rem;
        }

        .community-actions a {
            text-decoration: none;
        }

        .btn-light {
            border: 1px solid rgba(255,255,255,0.35);
            color: #ffffff;
            padding: 0.6rem 1.1rem;
            border-radius: 8px;
            font-weight: 700;
        }

        @media (max-width: 960px) {
            .community-hero,
            .community-grid,
            .post-form-row {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 680px) {
            .community-shell {
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
                    <a href="perfil.jsp" class="link-secundario">Perfil</a>
                    <a href="LogoutServlet" class="link-secundario">Cerrar sesión</a>
                <% } else { %>
                    <a href="login.jsp" class="link-secundario">Entrar</a>
                    <a href="registro.jsp" class="btn-primario">Unirme</a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="community-shell">
        <section class="community-hero">
            <div>
                <h1>Comunidad para crear y crecer</h1>
                <p>Comparte procesos, encuentra personas con talentos distintos al tuyo y participa en espacios de bienestar emocional sin llamarlo terapia. Este es un lugar para acompañarnos con respeto.</p>
                <div class="community-actions">
                    <a href="#foro" class="btn-primario">Publicar algo</a>
                    <a href="#talentos" class="btn-light">Ver talentos</a>
                </div>
            </div>
            <aside class="reflection-card">
                <span>Reflexión del día</span>
                <strong>Tu talento también puede ser una forma de ayudar a otros.</strong>
            </aside>
        </section>

        <section class="community-grid">
            <div class="split-panels">
                <div class="community-panel" id="foro">
                    <h2>Foro y espacio social</h2>
                    <form class="post-form" id="postForm">
                        <textarea id="postText" placeholder="Comparte un avance, una pregunta o algo que estés procesando..."></textarea>
                        <div class="post-form-row">
                            <select id="postType">
                                <option>Proceso creativo</option>
                                <option>Bienestar emocional</option>
                                <option>Busco colaborar</option>
                                <option>Reflexión personal</option>
                            </select>
                            <button type="submit" class="btn-primario">Publicar</button>
                        </div>
                    </form>

                    <div id="postList">
                        <article class="post-card">
                            <strong>Ana</strong>
                            <p>Hoy terminé una serie de fotos sobre calma. Busco a alguien que quiera escribir textos breves para acompañarlas.</p>
                            <span class="post-tag">Busco colaborar</span>
                        </article>
                        <article class="post-card">
                            <strong>Luis</strong>
                            <p>Me sentía bloqueado con una canción, pero el reto semanal me ayudó a terminar un primer borrador.</p>
                            <span class="post-tag">Proceso creativo</span>
                        </article>
                        <article class="post-card">
                            <strong>Sofía</strong>
                            <p>Estoy practicando hablar con más claridad sobre lo que siento. A veces un paso pequeño sí cuenta.</p>
                            <span class="post-tag">Bienestar emocional</span>
                        </article>
                    </div>
                </div>

                <div class="community-panel" id="talentos">
                    <h2>Talentos de la comunidad</h2>
                    <table class="talent-table">
                        <thead>
                            <tr>
                                <th>Usuario</th>
                                <th>Talento</th>
                                <th>Busca</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>Ana</td><td>Fotografía</td><td>Colaborar</td></tr>
                            <tr><td>Luis</td><td>Música</td><td>Editor de video</td></tr>
                            <tr><td>Sofía</td><td>Ilustración</td><td>Difusión</td></tr>
                            <tr><td>Mateo</td><td>Escritura</td><td>Diseñador</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <aside class="split-panels">
                <div class="community-panel dark">
                    <h2>Espacio seguro</h2>
                    <div class="safe-list">
                        <div><strong>Bienestar</strong><p>Comparte experiencias con respeto, sin juicios y sin presionar a nadie a contar más de lo que quiere.</p></div>
                        <div><strong>Apoyo emocional</strong><p>Acompañamos desde la escucha y el crecimiento personal. No sustituye ayuda profesional.</p></div>
                        <div><strong>Cuidado de comunidad</strong><p>Usa lenguaje amable, pide permiso para aconsejar y protege lo que otros comparten.</p></div>
                    </div>
                </div>

                <div class="community-panel dark">
                    <h2>Eventos y retos</h2>
                    <div class="event-list">
                        <div><strong>Reto creativo semanal</strong><p>Crea una pieza breve inspirada en la palabra “renacer”.</p></div>
                        <div><strong>Sesión de reflexión</strong><p>Jueves 7:00 PM: propósito, identidad y próximos pasos.</p></div>
                        <div><strong>Dinámica grupal</strong><p>Forma equipos para crear una publicación colaborativa.</p></div>
                    </div>
                </div>
            </aside>
        </section>
    </main>

    <script>
        const postForm = document.getElementById("postForm");
        const postList = document.getElementById("postList");

        postForm.addEventListener("submit", function (event) {
            event.preventDefault();

            const text = document.getElementById("postText").value.trim();
            const type = document.getElementById("postType").value;

            if (!text) return;

            const article = document.createElement("article");
            article.className = "post-card";
            article.innerHTML = "<strong><%= nombreUsuario %></strong><p>" + text + "</p><span class='post-tag'>" + type + "</span>";
            postList.prepend(article);
            postForm.reset();
        });
    </script>
</body>
</html>
