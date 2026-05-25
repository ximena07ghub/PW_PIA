<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) nombreUsuario = "Estudiante";
    if (usuarioLogin == null || usuarioLogin.trim().isEmpty()) usuarioLogin = "relax.user";
    if (correoUsuario == null || correoUsuario.trim().isEmpty()) correoUsuario = "correo@relaxzone.com";
    if (nombres == null || nombres.trim().isEmpty()) nombres = nombreUsuario;
    if (apellidos == null) apellidos = "";
    if (fechaNacimiento == null) fechaNacimiento = "";
    if (fotoPerfil == null) fotoPerfil = "";
    if (sitioWeb == null) sitioWeb = "";
    if (biografia == null || biografia.trim().isEmpty()) biografia = "Creciendo con prop&oacute;sito, bienestar y creatividad.";
    if (talentos == null || talentos.trim().isEmpty()) talentos = "";
    if (genero == null) genero = "";
    if (intereses == null || intereses.trim().isEmpty()) intereses = "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar perfil - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
    <style>
        .edit-page {
            max-width: 1180px;
            margin: 0 auto;
            padding: 2rem;
            display: grid;
            grid-template-columns: 340px minmax(0, 1fr);
            gap: 1.5rem;
            align-items: start;
        }

        .edit-side,
        .edit-form-card {
            background: var(--color-fondo-card);
            border: 1px solid var(--color-borde);
            border-radius: 12px;
            color: #ffffff;
            box-shadow: 0 18px 40px rgba(2, 61, 85, 0.12);
        }

        .edit-side {
            padding: 1.5rem;
            position: sticky;
            top: 92px;
        }

        .photo-drop {
            border: 2px dashed var(--color-primario);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            background: rgba(255,255,255,0.05);
        }

        .photo-preview {
            width: 138px;
            height: 138px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            background: linear-gradient(135deg, var(--color-primario), #0a52a3);
            display: grid;
            place-items: center;
            color: #ffffff;
            font-size: 3rem;
            font-weight: 800;
            overflow: hidden;
        }

        .photo-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .photo-drop input {
            display: none;
        }

        .photo-drop label {
            color: var(--color-primario);
            font-weight: 800;
            cursor: pointer;
        }

        .edit-form-card {
            padding: 2rem;
        }

        .edit-form-card h1 {
            color: #ffffff;
            font-size: clamp(2rem, 5vw, 3.2rem);
            line-height: 1;
            margin-bottom: 1.5rem;
            letter-spacing: 0;
        }

        .edit-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .edit-field {
            display: grid;
            gap: 0.45rem;
        }

        .edit-field.full {
            grid-column: 1 / -1;
        }

        .edit-field label {
            color: var(--color-texto-suave);
            font-weight: 700;
            font-size: 0.9rem;
        }

        .edit-field input,
        .edit-field select,
        .edit-field textarea {
            width: 100%;
            border: 1px solid var(--color-borde);
            background: rgba(255,255,255,0.06);
            color: #ffffff;
            border-radius: 8px;
            padding: 0.85rem;
            font-family: var(--fuente-principal);
            outline: none;
        }

        .edit-field textarea {
            min-height: 135px;
            resize: vertical;
        }

        .edit-field select {
            appearance: none;
            color-scheme: dark;
            cursor: pointer;
            padding-right: 2.6rem;
            background-color: rgba(255,255,255,0.08);
            background-image:
                linear-gradient(45deg, transparent 50%, var(--color-primario) 50%),
                linear-gradient(135deg, var(--color-primario) 50%, transparent 50%);
            background-position:
                calc(100% - 20px) 50%,
                calc(100% - 14px) 50%;
            background-size: 6px 6px, 6px 6px;
            background-repeat: no-repeat;
        }

        .edit-field select option {
            background: var(--color-fondo-card);
            color: #ffffff;
        }

        .edit-field input:focus,
        .edit-field select:focus,
        .edit-field textarea:focus {
            border-color: var(--color-primario);
        }

        .edit-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
            margin-top: 1.5rem;
        }

        .edit-actions button,
        .edit-actions a {
            border: none;
            text-decoration: none;
            cursor: pointer;
            font-family: var(--fuente-principal);
        }

        .btn-return {
            border: 1px solid rgba(255,255,255,0.35) !important;
            color: #ffffff;
            background: transparent;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 700;
        }

        @media (max-width: 900px) {
            .edit-page,
            .edit-grid {
                grid-template-columns: 1fr;
            }

            .edit-side {
                position: static;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo"><span class="logo-icon"></span> RELAX ZONE</a>
            <div class="nav-links">
                <a href="perfil.jsp" class="link-secundario">Mi perfil</a>
                <a href="dashboard.jsp" class="link-secundario">Mis cursos</a>
            </div>
        </div>
    </nav>

    <main class="edit-page">
        <aside class="edit-side">
            <div class="photo-drop">
                <div class="photo-preview">
                    <img
                        id="photoPreview"
                        src="<%= fotoPerfil %>"
                        alt="Vista previa"
                        onerror="this.style.display='none'; document.getElementById('photoInitial').style.display='block';"
                        style="<%= fotoPerfil.trim().isEmpty() ? "display:none;" : "display:block;" %>"
                    >
                    <span
                        id="photoInitial"
                        style="<%= fotoPerfil.trim().isEmpty() ? "display:block;" : "display:none;" %>"
                    >
                        <%= nombreUsuario.substring(0, 1).toUpperCase() %>
                    </span>
                </div>

                <p>Arrastra tu imagen de perfil o <label for="foto">sube una foto</label></p>

                <input
                    type="file"
                    id="foto"
                    name="foto"
                    accept="image/*"
                    form="profileForm"
                >
            </div>

            <div style="margin-top:1.2rem;">
                <h2 style="color:#ffffff; font-size:1.25rem; margin-bottom:.5rem;">Tu espacio</h2>
                <p style="color:var(--color-texto-suave);">Actualiza lo que haces, lo que buscas y c&oacute;mo quieres conectar con la comunidad.</p>
            </div>
        </aside>

        <section class="edit-form-card">
            <h1>Tus datos</h1>

            <form id="profileForm" action="ActualizarPerfilServlet" method="post" enctype="multipart/form-data">
                <div class="edit-grid">
                    <div class="edit-field">
                        <label for="nombres">Nombres</label>
                        <input type="text" id="nombres" name="nombres" value="<%= nombres %>" required>
                    </div>

                    <div class="edit-field">
                        <label for="apellidos">Apellidos</label>
                        <input type="text" id="apellidos" name="apellidos" value="<%= apellidos %>">
                    </div>

                    <div class="edit-field">
                        <label for="usuario">Usuario</label>
                        <input type="text" id="usuario" name="usuario" value="<%= usuarioLogin %>" required>
                    </div>

                    <div class="edit-field">
                        <label for="correo">Email</label>
                        <input type="email" id="correo" name="correo" value="<%= correoUsuario %>" required>
                    </div>

                    <div class="edit-field full">
                        <label for="sitio">Sitio web personal</label>
                        <input type="url" id="sitio" name="sitio" value="<%= sitioWeb %>" placeholder="https://miportafolio.com">
                    </div>

                    <div class="edit-field full">
                        <label for="bio">Biograf&iacute;a</label>
                        <textarea id="bio" name="bio" placeholder="Cu&eacute;ntanos qu&eacute; est&aacute;s creando, qu&eacute; est&aacute;s aprendiendo o qu&eacute; buscas en la comunidad."><%= biografia %></textarea>
                    </div>

                    <div class="edit-field full">
                        <label for="talentos">Talentos</label>
                        <input type="text" id="talentos" name="talentos" value="<%= talentos %>" placeholder="Escritura, Dise&ntilde;o, Escucha activa, Contenido creativo">
                    </div>

                    <div class="edit-field">
                        <label for="genero">G&eacute;nero</label>
                        <select id="genero" name="genero">
                            <option value="" <%= genero.equals("") ? "selected" : "" %>>Prefiero no decirlo</option>
                            <option value="Femenino" <%= genero.equals("Femenino") ? "selected" : "" %>>Femenino</option>
                            <option value="Masculino" <%= genero.equals("Masculino") ? "selected" : "" %>>Masculino</option>
                            <option value="Otro" <%= genero.equals("Otro") ? "selected" : "" %>>Otro</option>
                        </select>
                    </div>

                    <div class="edit-field">
                        <label for="fechaNacimiento">Cumplea&ntilde;os</label>
                        <input type="date" id="fechaNacimiento" name="fechaNacimiento" value="<%= fechaNacimiento %>" readonly>
                    </div>

                    <div class="edit-field full">
                        <label for="intereses">Intereses</label>
                        <input type="text" id="intereses" name="intereses" value="<%= intereses %>" placeholder="Bienestar emocional, prop&oacute;sito, creatividad">
                    </div>

                </div>

                <div class="edit-actions">
                    <button type="submit" class="btn-primario">Guardar cambios</button>
                    <a href="perfil.jsp" class="btn-return">Regresar al perfil</a>
                </div>
            </form>
        </section>
    </main>

    <script>
        const foto = document.getElementById("foto");
        const photoPreview = document.getElementById("photoPreview");
        const photoInitial = document.getElementById("photoInitial");

        foto.addEventListener("change", function () {
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();

            reader.onload = function (event) {
                photoPreview.src = event.target.result;
                photoPreview.style.display = "block";
                photoInitial.style.display = "none";
            };

            reader.readAsDataURL(file);
        });
    </script>
</body>
</html>
