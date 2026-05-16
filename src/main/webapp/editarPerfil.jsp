<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    String usuarioLogin = (String) session.getAttribute("nombreUsuarioLogin");
    String correoUsuario = (String) session.getAttribute("correoUsuario");
    String nombres = (String) session.getAttribute("nombres");
    String apellidos = (String) session.getAttribute("apellidos");
    String fechaNacimiento = (String) session.getAttribute("fechaNacimiento");

    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) nombreUsuario = "Estudiante";
    if (usuarioLogin == null || usuarioLogin.trim().isEmpty()) usuarioLogin = "relax.user";
    if (correoUsuario == null || correoUsuario.trim().isEmpty()) correoUsuario = "correo@relaxzone.com";
    if (nombres == null || nombres.trim().isEmpty()) nombres = nombreUsuario;
    if (apellidos == null) apellidos = "";
    if (fechaNacimiento == null) fechaNacimiento = "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar perfil - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
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

        .save-message {
            display: none;
            margin-top: 1rem;
            background: rgba(42, 201, 230, 0.14);
            color: var(--color-primario);
            border: 1px solid rgba(42, 201, 230, 0.35);
            border-radius: 8px;
            padding: 0.85rem;
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
                    <img id="photoPreview" src="" alt="Vista previa">
                    <span id="photoInitial"><%= nombreUsuario.substring(0, 1).toUpperCase() %></span>
                </div>
                <p>Arrastra tu imagen de perfil o <label for="foto">sube una foto</label></p>
                <input type="file" id="foto" accept="image/*">
            </div>
            <div style="margin-top:1.2rem;">
                <h2 style="color:#ffffff; font-size:1.25rem; margin-bottom:.5rem;">Tu espacio</h2>
                <p style="color:var(--color-texto-suave);">Actualiza lo que haces, lo que buscas y cómo quieres conectar con la comunidad.</p>
            </div>
        </aside>

        <section class="edit-form-card">
            <h1>Tus datos</h1>
            <form id="profileForm">
                <div class="edit-grid">
                    <div class="edit-field">
                        <label for="nombres">Nombres</label>
                        <input type="text" id="nombres" value="<%= nombres %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="apellidos">Apellidos</label>
                        <input type="text" id="apellidos" value="<%= apellidos %>">
                    </div>
                    <div class="edit-field">
                        <label for="usuario">Usuario</label>
                        <input type="text" id="usuario" value="<%= usuarioLogin %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="correo">Email</label>
                        <input type="email" id="correo" value="<%= correoUsuario %>">
                    </div>
                    <div class="edit-field full">
                        <label for="sitio">Sitio web personal</label>
                        <input type="url" id="sitio" placeholder="https://miportafolio.com">
                    </div>
                    <div class="edit-field full">
                        <label for="bio">Biografía</label>
                        <textarea id="bio" placeholder="Cuéntanos qué estás creando, qué estás aprendiendo o qué buscas en la comunidad.">Creciendo con propósito, bienestar y creatividad.</textarea>
                    </div>
                    <div class="edit-field full">
                        <label for="talentos">Talentos</label>
                        <input type="text" id="talentos" value="Escritura, Diseño, Escucha activa, Contenido creativo">
                    </div>
                    <div class="edit-field">
                        <label for="genero">Género</label>
                        <select id="genero">
                            <option value="">Prefiero no decirlo</option>
                            <option>Femenino</option>
                            <option>Masculino</option>
                            <option>Otro</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="fechaNacimiento">Cumpleaños</label>
                        <input type="date" id="fechaNacimiento" value="<%= fechaNacimiento %>">
                    </div>
                    <div class="edit-field full">
                        <label for="intereses">Intereses</label>
                        <input type="text" id="intereses" value="Bienestar emocional, propósito, creatividad">
                    </div>
                </div>

                <div class="edit-actions">
                    <button type="submit" class="btn-primario">Guardar cambios</button>
                    <a href="perfil.jsp" class="btn-return">Regresar al perfil</a>
                </div>
                <div class="save-message" id="saveMessage">Cambios guardados. Puedes regresar al perfil para verlos.</div>
            </form>
        </section>
    </main>

    <script>
        const form = document.getElementById("profileForm");
        const foto = document.getElementById("foto");
        const photoPreview = document.getElementById("photoPreview");
        const photoInitial = document.getElementById("photoInitial");
        const saved = JSON.parse(localStorage.getItem("relaxzonePerfil") || "{}");
        let photoData = saved.foto || "";

        function setValue(id, value) {
            if (value) document.getElementById(id).value = value;
        }

        setValue("nombres", saved.nombre);
        setValue("apellidos", saved.apellidos);
        setValue("usuario", saved.usuario);
        setValue("correo", saved.correo);
        setValue("sitio", saved.sitio);
        setValue("bio", saved.bio);
        setValue("talentos", saved.talentos);
        setValue("genero", saved.genero);
        setValue("fechaNacimiento", saved.fechaNacimiento);
        setValue("intereses", saved.intereses);

        if (photoData) {
            photoPreview.src = photoData;
            photoPreview.style.display = "block";
            photoInitial.style.display = "none";
        }

        foto.addEventListener("change", function () {
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (event) {
                photoData = event.target.result;
                photoPreview.src = photoData;
                photoPreview.style.display = "block";
                photoInitial.style.display = "none";
            };
            reader.readAsDataURL(file);
        });

        form.addEventListener("submit", function (event) {
            event.preventDefault();

            const profile = {
                nombre: document.getElementById("nombres").value.trim(),
                apellidos: document.getElementById("apellidos").value.trim(),
                usuario: document.getElementById("usuario").value.trim(),
                correo: document.getElementById("correo").value.trim(),
                sitio: document.getElementById("sitio").value.trim(),
                bio: document.getElementById("bio").value.trim(),
                talentos: document.getElementById("talentos").value.trim(),
                genero: document.getElementById("genero").value,
                fechaNacimiento: document.getElementById("fechaNacimiento").value,
                intereses: document.getElementById("intereses").value.trim(),
                foto: photoData
            };

            localStorage.setItem("relaxzonePerfil", JSON.stringify(profile));
            document.getElementById("saveMessage").style.display = "block";
        });
    </script>
</body>
</html>
