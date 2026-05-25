<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="datos.DBConnection"%>
<%!
    private String safe(String value) {
        if (value == null || value.trim().isEmpty()) return "Sin registrar";
        return value.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
    }
%>
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
    <link rel="stylesheet" href="css/styles.css?v=4">
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

        .post-author {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            border: none;
            background: transparent;
            padding: 0;
            font-family: var(--fuente-principal);
            cursor: pointer;
            text-align: left;
        }

        .community-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            overflow: hidden;
            background: linear-gradient(135deg, var(--color-primario), #0a52a3);
            color: #ffffff;
            font-weight: 900;
            flex: 0 0 auto;
        }

        .community-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
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

        .event-list div {
            position: relative;
            min-height: 112px;
            padding: 1.15rem 1.15rem 1.15rem 1.35rem;
            background: linear-gradient(135deg, rgba(42, 201, 230, 0.16), rgba(255, 255, 255, 0.07));
            border-color: rgba(42, 201, 230, 0.35);
            box-shadow: 0 14px 28px rgba(0, 17, 31, 0.12);
            overflow: hidden;
        }

        .event-list div::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background: var(--color-primario);
        }

        .safe-list strong,
        .event-list strong {
            color: var(--color-primario);
            display: block;
            margin-bottom: 0.25rem;
        }

        .event-list strong {
            font-size: 1.02rem;
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

        .profile-modal {
            position: fixed;
            inset: 0;
            background: rgba(0, 17, 31, 0.58);
            display: none;
            place-items: center;
            padding: 1rem;
            z-index: 2000;
        }

        .profile-modal.is-open {
            display: grid;
        }

        .profile-modal-card {
            width: min(520px, 100%);
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 24px 60px rgba(0, 17, 31, 0.26);
        }

        .profile-modal-head {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            align-items: start;
            margin-bottom: 1rem;
        }

        .profile-modal-card h3 {
            color: var(--color-texto);
            font-size: 1.45rem;
        }

        .profile-modal-card p {
            color: #344a6b;
            margin-top: 0.6rem;
        }

        .modal-close {
            border: none;
            background: var(--color-primario);
            color: #062230;
            border-radius: 8px;
            padding: 0.45rem 0.7rem;
            font-family: var(--fuente-principal);
            font-weight: 900;
            cursor: pointer;
        }

        .post-tools {
            margin: 1rem 0;
        }

        .post-tools input {
            width: 100%;
            border: 1px solid #d8e5ec;
            border-radius: 8px;
            padding: 0.85rem;
            font-family: var(--fuente-principal);
            outline: none;
        }

        .post-empty-message {
            background: #f5fbfd;
            color: var(--color-texto);
            border-radius: 8px;
            padding: 0.9rem;
            font-weight: 800;
        }

        .pagination-controls {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 0.65rem;
            margin-top: 1rem;
        }

        .pagination-controls button {
            border: 1px solid var(--color-borde);
            background: var(--color-fondo-card);
            color: #ffffff;
            border-radius: 8px;
            padding: 0.55rem 0.85rem;
            font-family: var(--fuente-principal);
            font-weight: 900;
            cursor: pointer;
        }

        .pagination-controls button:disabled {
            opacity: 0.45;
            cursor: default;
        }

        .pagination-controls span {
            color: var(--color-texto);
            font-weight: 900;
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
                    <a href="LogoutServlet" class="link-secundario">Cerrar sesi&oacute;n</a>
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
                <p>Comparte procesos, encuentra personas con talentos distintos al tuyo y participa en espacios de bienestar emocional sin llamarlo terapia. Este es un lugar para acompa&ntilde;arnos con respeto.</p>
                <div class="community-actions">
                    <a href="#foro" class="btn-primario">Publicar algo</a>
                    <a href="#talentos" class="btn-light">Ver talentos</a>
                </div>
            </div>
            <aside class="reflection-card">
                <span>Reflexi&oacute;n del d&iacute;a</span>
                <strong>Tu talento tambi&eacute;n puede ser una forma de ayudar a otros.</strong>
            </aside>
        </section>

        <section class="community-grid">
            <div class="split-panels">
                <div class="community-panel" id="foro">
                    <h2>Foro y espacio social</h2>

                    <% if (sesionActiva) { %>
                        <form class="post-form" id="postForm" action="PublicarComunidadServlet" method="post">
                            <textarea
                                id="postText"
                                name="contenido"
                                placeholder="Comparte un avance, una pregunta o algo que est&eacute;s procesando..."
                                required
                            ></textarea>

                            <div class="post-form-row">
                                <select id="postType" name="tipo" required>
                                    <option value="Proceso creativo">Proceso creativo</option>
                                    <option value="Bienestar emocional">Bienestar emocional</option>
                                    <option value="Busco colaborar">Busco colaborar</option>
                                    <option value="Reflexi&oacute;n personal">Reflexi&oacute;n personal</option>
                                </select>

                                <button type="submit" class="btn-primario">Publicar</button>
                            </div>
                        </form>
                    <% } else { %>
                        <p>Inicia sesi&oacute;n para publicar en la comunidad.</p>
                    <% } %>

                    <%-- Busqueda y paginacion local de publicaciones --%>
                    <div class="post-tools">
                        <input type="search" id="postSearch" placeholder="Buscar publicaciones por autor, tema o palabra clave">
                    </div>
                    <p class="post-empty-message" id="postEmptyMessage" hidden>No encontramos publicaciones con esa b&uacute;squeda.</p>

                    <div id="postList">
                        <%
                            String sqlPublicaciones = "SELECT p.contenido, p.tipo, u.nombres, u.apellidos, "
                                    + "u.foto_perfil, u.biografia, u.talentos, u.intereses, u.sitio_web "
                                    + "FROM comunidad_publicaciones p "
                                    + "INNER JOIN usuarios u ON p.usuario_id = u.id "
                                    + "ORDER BY p.fecha_creacion DESC";

                            try (Connection con = DBConnection.getConnection();
                                 PreparedStatement ps = con.prepareStatement(sqlPublicaciones);
                                 ResultSet rs = ps.executeQuery()) {

                                boolean hayPublicaciones = false;

                                while (rs.next()) {
                                    hayPublicaciones = true;
                                    String autor = rs.getString("nombres") + " " + rs.getString("apellidos");
                                    String foto = rs.getString("foto_perfil");
                                    boolean tieneFoto = foto != null && !foto.trim().isEmpty();
                                    String inicial = autor.trim().isEmpty() ? "U" : autor.substring(0, 1).toUpperCase();
                        %>
                                    <article class="post-card">
                                        <%-- Autor con ventana informativa dentro de la misma pagina --%>
                                        <button
                                            type="button"
                                            class="post-author"
                                            data-name="<%= safe(autor) %>"
                                            data-bio="<%= safe(rs.getString("biografia")) %>"
                                            data-talents="<%= safe(rs.getString("talentos")) %>"
                                            data-looking="<%= safe(rs.getString("intereses")) %>"
                                            data-site="<%= safe(rs.getString("sitio_web")) %>"
                                        >
                                            <span class="community-avatar">
                                                <% if (tieneFoto) { %>
                                                    <img src="<%= safe(foto) %>" alt="Foto de <%= safe(autor) %>" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                                    <span style="display:none;"><%= inicial %></span>
                                                <% } else { %>
                                                    <span><%= inicial %></span>
                                                <% } %>
                                            </span>
                                            <strong><%= autor %></strong>
                                        </button>
                                        <p><%= rs.getString("contenido") %></p>
                                        <span class="post-tag"><%= rs.getString("tipo") %></span>
                                    </article>
                        <%
                                }

                                if (!hayPublicaciones) {
                        %>
                                    <article class="post-card">
                                        <strong>Comunidad Relax Zone</strong>
                                        <p>A&uacute;n no hay publicaciones. S&eacute; la primera persona en compartir algo.</p>
                                        <span class="post-tag">Bienestar emocional</span>
                                    </article>
                        <%
                                }

                            } catch (Exception e) {
                        %>
                                <article class="post-card">
                                    <strong>Error</strong>
                                    <p>No se pudieron cargar las publicaciones.</p>
                                    <span class="post-tag"><%= e.getMessage() %></span>
                                </article>
                        <%
                            }
                        %>
                    </div>
                    <div class="pagination-controls" id="postPagination">
                        <button type="button" id="postPrev">Anterior</button>
                        <span id="postPageInfo">P&aacute;gina 1</span>
                        <button type="button" id="postNext">Siguiente</button>
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
                            <%
                                String sqlTalentos = "SELECT u.nombres, u.apellidos, u.foto_perfil, u.biografia, u.sitio_web, t.talento, t.busca "
                                        + "FROM comunidad_talentos t "
                                        + "INNER JOIN usuarios u ON t.usuario_id = u.id "
                                        + "ORDER BY t.fecha_creacion DESC";

                                try (Connection con = DBConnection.getConnection();
                                     PreparedStatement ps = con.prepareStatement(sqlTalentos);
                                     ResultSet rs = ps.executeQuery()) {

                                    boolean hayTalentos = false;

                                    while (rs.next()) {
                                        hayTalentos = true;
                                        String autor = rs.getString("nombres") + " " + rs.getString("apellidos");
                                        String talento = rs.getString("talento");
                                        String busca = rs.getString("busca");
                                        String foto = rs.getString("foto_perfil");
                                        boolean tieneFoto = foto != null && !foto.trim().isEmpty();
                                        String inicial = autor.trim().isEmpty() ? "U" : autor.substring(0, 1).toUpperCase();

                                        if (talento == null || talento.trim().isEmpty()) talento = "Sin registrar";
                                        if (busca == null || busca.trim().isEmpty()) busca = "Sin registrar";
                            %>
                                        <tr>
                                            <td>
                                                <button
                                                    type="button"
                                                    class="post-author"
                                                    data-name="<%= safe(autor) %>"
                                                    data-bio="<%= safe(rs.getString("biografia")) %>"
                                                    data-talents="<%= safe(talento) %>"
                                                    data-looking="<%= safe(busca) %>"
                                                    data-site="<%= safe(rs.getString("sitio_web")) %>"
                                                >
                                                    <span class="community-avatar">
                                                        <% if (tieneFoto) { %>
                                                            <img src="<%= safe(foto) %>" alt="Foto de <%= safe(autor) %>" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                                            <span style="display:none;"><%= inicial %></span>
                                                        <% } else { %>
                                                            <span><%= inicial %></span>
                                                        <% } %>
                                                    </span>
                                                    <strong><%= autor %></strong>
                                                </button>
                                            </td>
                                            <td><%= talento %></td>
                                            <td><%= busca %></td>
                                        </tr>
                            <%
                                    }

                                    if (!hayTalentos) {
                            %>
                                        <tr>
                                            <td colspan="3">A&uacute;n no hay talentos registrados.</td>
                                        </tr>
                            <%
                                    }

                                } catch (Exception e) {
                            %>
                                    <tr>
                                        <td colspan="3">No se pudieron cargar los talentos.</td>
                                    </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <aside class="split-panels">
                <div class="community-panel dark">
                    <h2>Espacio seguro</h2>
                    <div class="safe-list">
                        <div><strong>Bienestar</strong><p>Comparte experiencias con respeto, sin juicios y sin presionar a nadie a contar m&aacute;s de lo que quiere.</p></div>
                        <div><strong>Apoyo emocional</strong><p>Acompa&ntilde;amos desde la escucha y el crecimiento personal. No sustituye ayuda profesional.</p></div>
                        <div><strong>Cuidado de comunidad</strong><p>Usa lenguaje amable, pide permiso para aconsejar y protege lo que otros comparten.</p></div>
                    </div>
                </div>

                <div class="community-panel dark">
                    <h2>Eventos y retos</h2>
                    <div class="event-list">
                        <div><strong>Reto creativo semanal</strong><p>Crea una pieza breve inspirada en la palabra &ldquo;renacer&rdquo;.</p></div>
                        <div><strong>Sesi&oacute;n de reflexi&oacute;n</strong><p>Jueves 7:00 PM: prop&oacute;sito, identidad y pr&oacute;ximos pasos.</p></div>
                        <div><strong>Din&aacute;mica grupal</strong><p>Forma equipos para crear una publicaci&oacute;n colaborativa.</p></div>
                    </div>
                </div>
            </aside>
        </section>
    </main>
    <div class="profile-modal" id="profileModal" aria-hidden="true">
        <div class="profile-modal-card" role="dialog" aria-modal="true" aria-labelledby="modalName">
            <div class="profile-modal-head">
                <h3 id="modalName">Perfil</h3>
                <button type="button" class="modal-close" id="modalClose">Cerrar</button>
            </div>
            <p><strong>Biograf&iacute;a:</strong> <span id="modalBio"></span></p>
            <p><strong>Talentos:</strong> <span id="modalTalents"></span></p>
            <p><strong>Busca:</strong> <span id="modalLooking"></span></p>
            <p><strong>Sitio web:</strong> <span id="modalSite"></span></p>
        </div>
    </div>
    <script>
        const modal = document.getElementById("profileModal");
        const closeModal = document.getElementById("modalClose");

        document.querySelectorAll(".post-author").forEach(function (button) {
            button.addEventListener("click", function () {
                document.getElementById("modalName").textContent = button.dataset.name || "Perfil";
                document.getElementById("modalBio").textContent = button.dataset.bio || "Sin registrar";
                document.getElementById("modalTalents").textContent = button.dataset.talents || "Sin registrar";
                document.getElementById("modalLooking").textContent = button.dataset.looking || "Sin registrar";
                document.getElementById("modalSite").textContent = button.dataset.site || "Sin registrar";
                modal.classList.add("is-open");
                modal.setAttribute("aria-hidden", "false");
            });
        });

        closeModal.addEventListener("click", function () {
            modal.classList.remove("is-open");
            modal.setAttribute("aria-hidden", "true");
        });

        // Filtro y paginacion de publicaciones sin recargar la pagina.
        const postSearch = document.getElementById("postSearch");
        const postCards = Array.from(document.querySelectorAll("#postList .post-card"));
        const postEmptyMessage = document.getElementById("postEmptyMessage");
        const postPagination = document.getElementById("postPagination");
        const postPrev = document.getElementById("postPrev");
        const postNext = document.getElementById("postNext");
        const postPageInfo = document.getElementById("postPageInfo");
        const postsPerPage = 4;
        let currentPostPage = 1;

        function normalizePostText(value) {
            return String(value || "")
                .toLowerCase()
                .normalize("NFD")
                .replace(/[\u0300-\u036f]/g, "");
        }

        function renderPostPage() {
            const query = normalizePostText(postSearch ? postSearch.value : "");
            const filtered = postCards.filter(function (card) {
                return !query || normalizePostText(card.textContent).indexOf(query) >= 0;
            });
            const totalPages = Math.max(1, Math.ceil(filtered.length / postsPerPage));

            if (currentPostPage > totalPages) currentPostPage = totalPages;

            postCards.forEach(function (card) {
                card.style.display = "none";
            });

            filtered
                .slice((currentPostPage - 1) * postsPerPage, currentPostPage * postsPerPage)
                .forEach(function (card) {
                    card.style.display = "";
                });

            if (postEmptyMessage) postEmptyMessage.hidden = filtered.length > 0;
            if (postPagination) postPagination.style.display = filtered.length > postsPerPage ? "flex" : "none";
            if (postPageInfo) postPageInfo.textContent = "P\u00e1gina " + currentPostPage + " de " + totalPages;
            if (postPrev) postPrev.disabled = currentPostPage <= 1;
            if (postNext) postNext.disabled = currentPostPage >= totalPages;
        }

        if (postSearch) {
            postSearch.addEventListener("input", function () {
                currentPostPage = 1;
                renderPostPage();
            });
        }

        if (postPrev) {
            postPrev.addEventListener("click", function () {
                currentPostPage -= 1;
                renderPostPage();
            });
        }

        if (postNext) {
            postNext.addEventListener("click", function () {
                currentPostPage += 1;
                renderPostPage();
            });
        }

        renderPostPage();
    </script>
</body>
</html>
