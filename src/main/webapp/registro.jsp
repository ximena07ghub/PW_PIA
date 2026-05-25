<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reg&iacute;strate - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css?v=4">
    <style>
        .registro-page {
            min-height: 100vh;
            background: #f0f7f8;
            padding: 90px 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .registro-card {
            width: min(1020px, 100%);
            min-height: 620px;
            display: grid;
            grid-template-columns: 0.9fr 1.1fr;
            background: var(--color-fondo-nav);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--color-borde);
            box-shadow: 0 24px 60px rgba(2, 61, 85, 0.18);
        }

        .registro-info {
            background: linear-gradient(135deg, #0b2238, #123f3e);
            color: #ffffff;
            padding: 3.5rem 3rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .registro-info h1 {
            color: #ffffff;
            font-size: clamp(2rem, 4vw, 3rem);
            line-height: 1.05;
            letter-spacing: 0;
            margin-bottom: 1rem;
        }

        .registro-info p {
            color: var(--color-texto-suave);
            max-width: 360px;
        }

        .registro-beneficios {
            display: grid;
            gap: 0.85rem;
            margin-top: 1.5rem;
        }

        .registro-beneficios span {
            color: var(--color-primario);
            font-weight: 700;
        }

        .registro-redes {
            border-top: 1px solid rgba(255,255,255,0.13);
            padding-top: 1.4rem;
        }

        .registro-redes small {
            color: var(--color-texto-suave);
            display: block;
            margin-bottom: 0.85rem;
        }

        .registro-iconos {
            display: flex;
            gap: 0.8rem;
        }

        .registro-iconos a {
            width: 42px;
            height: 42px;
            display: grid;
            place-items: center;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
            color: #ffffff;
            border: 1px solid rgba(255,255,255,0.12);
            text-decoration: none;
            font-weight: 800;
            font-size: 0.75rem;
        }

        .registro-form-side {
            padding: 3rem;
            display: flex;
            align-items: center;
        }

        .registro-form-side form {
            width: 100%;
        }

        .registro-form-side h2 {
            color: #ffffff;
            text-align: center;
            font-size: 2rem;
            margin-bottom: 1.8rem;
            letter-spacing: 0;
        }

        .registro-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .registro-field {
            display: grid;
            gap: 0.45rem;
        }

        .registro-field.full {
            grid-column: 1 / -1;
        }

        .registro-field label {
            color: #ffffff;
            font-size: 0.84rem;
            font-weight: 700;
        }

        .registro-field input {
            background: rgba(255,255,255,0.06);
            border: 1px solid var(--color-borde);
            border-radius: 8px;
            color: #ffffff;
            padding: 0.85rem;
            font-family: var(--fuente-principal);
            outline: none;
            width: 100%;
            min-height: 46px;
        }

        .registro-field input:focus {
            border-color: var(--color-primario);
        }

        .registro-field input[type="file"] {
            padding: 0.65rem;
            color: var(--color-texto-suave);
        }

        .registro-field input::placeholder {
            color: rgba(226, 238, 243, 0.52);
        }

        .password-help {
            min-height: 2rem;
            color: rgba(226, 238, 243, 0.62);
            font-size: 0.72rem;
            line-height: 1.35;
            transition: color 0.2s ease;
            max-width: 100%;
        }

        .password-help.is-warning {
            color: #ffd6a1;
        }

        .password-help.is-ok {
            color: #9ff3ff;
        }

        .registro-submit {
            width: 100%;
            border: none;
            margin-top: 1.5rem;
            padding: 1rem;
            border-radius: 8px;
            background: var(--color-primario);
            color: #062230;
            font-family: var(--fuente-principal);
            font-weight: 800;
            letter-spacing: 1px;
            cursor: pointer;
            text-transform: uppercase;
        }

        .registro-login {
            text-align: center;
            color: var(--color-texto-suave);
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .registro-login a {
            color: var(--color-primario);
            text-decoration: none;
            font-weight: 800;
        }

        @media (max-width: 860px) {
            .registro-card,
            .registro-grid {
                grid-template-columns: 1fr;
            }

            .registro-info,
            .registro-form-side {
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-auth">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo">RELAX ZONE</a>
            <div class="nav-links">
                <a href="login.jsp" class="link-secundario">Entrar</a>
            </div>
        </div>
    </nav>

    <main class="registro-page">
        <section class="registro-card">
            <aside class="registro-info">
                <div>
                    <h1>&Uacute;nete a la comunidad</h1>
                    <p>Un espacio donde se conectan talentos, se crean proyectos y se recibe gu&iacute;a creativa y espiritual.</p>

                    <div class="registro-beneficios">
                        <span>&#10003; Apoyo emocional + creativo</span>
                        <span>&#10003; Crecimiento integral, t&uacute; eres el diferencial</span>
                        <span>&#10003; Red de apoyo real</span>
                    </div>
                </div>

                <div class="registro-redes">
                    <small>S&iacute;guenos en nuestras redes:</small>
                    <div class="registro-iconos">
                        <a href="#" aria-label="Instagram">IG</a>
                        <a href="#" aria-label="Facebook">FB</a>
                        <a href="#" aria-label="TikTok">TT</a>
                    </div>
                </div>
            </aside>

            <div class="registro-form-side">
                <form id="formRegistro" action="RegistroServlet" method="post" enctype="multipart/form-data">
                    <h2>Crea tu cuenta</h2>

                    <% if ("existe".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Ese correo o nombre de usuario ya est&aacute; registrado.
                        </p>
                    <% } else if ("campos".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Completa los datos obligatorios para crear tu cuenta.
                        </p>
                    <% } else if ("password".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            La contrase&ntilde;a debe tener minimo 8 caracteres, una mayuscula, una minuscula, un numero y un simbolo.
                        </p>
                    <% } else if ("confirmar".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Las contrase&ntilde;as no coinciden.
                        </p>
                    <% } else if ("db".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            No se pudo guardar el registro. Revisa que MySQL est&eacute; encendido y que exista la base relaxzone.
                        </p>
                    <% } else if ("driver".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            Falta el conector de MySQL en el proyecto. Haz Clean and Build en NetBeans para descargar mysql-connector-j.
                        </p>
                    <% } else if ("credenciales".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            MySQL rechaz&oacute; el usuario o contrase&ntilde;a. Revisa que root use la contrase&ntilde;a admin123.
                        </p>
                    <% } else if ("base".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            No existe la base relaxzone. Ejecuta el script database.sql en MySQL Workbench.
                        </p>
                    <% } else if ("conexion".equals(request.getParameter("error"))) { %>
                        <p style="background:rgba(255,82,82,0.12); border:1px solid #ff5252; color:#ffb4b4; padding:.8rem; border-radius:8px; margin-bottom:1rem;">
                            No se pudo conectar con MySQL. Verifica que el servidor est&eacute; encendido en el puerto 3306.
                        </p>
                    <% } %>

                    <div class="registro-grid">
                        <div class="registro-field">
                            <label for="nombres">Nombre(s)</label>
                            <input type="text" id="nombres" name="nombres" required>
                        </div>
                        <div class="registro-field">
                            <label for="apellidos">Apellidos</label>
                            <input type="text" id="apellidos" name="apellidos" required>
                        </div>
                        <div class="registro-field">
                            <label for="fechaNacimiento">Fecha de nacimiento</label>
                            <input type="date" id="fechaNacimiento" name="fechaNacimiento" required>
                        </div>
                        <div class="registro-field">
                            <label for="correo">Correo electr&oacute;nico</label>
                            <input type="email" id="correo" name="correo" placeholder="ej.correo@gmail.com" required>
                        </div>
                        <div class="registro-field">
                            <label for="nombreUsuario">Nombre de usuario</label>
                            <input type="text" id="nombreUsuario" name="nombreUsuario" placeholder="ej. ximena07" required>
                        </div>
                        <div class="registro-field">
                            <label for="password">Contrase&ntilde;a</label>
                            <input type="password" id="password" name="password" placeholder="8+ caracteres" autocomplete="new-password" required>
                            <div id="passwordHelp" class="password-help" aria-live="polite">
                                Usa mayuscula, minuscula, numero y simbolo.
                            </div>
                        </div>
                        <div class="registro-field">
                            <label for="confirmPassword">Confirmar contrase&ntilde;a</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" autocomplete="new-password" required>
                        </div>
                        <div class="registro-field">
                            <label for="fotoPerfil">Foto de perfil</label>
                            <input type="file" id="fotoPerfil" name="fotoPerfil" accept="image/png, image/jpeg">
                        </div>
                    </div>

                    <button type="submit" class="registro-submit">Registrarme</button>
                    <p class="registro-login">&iquest;Ya tienes cuenta? <a href="login.jsp">Inicia sesi&oacute;n</a></p>
                </form>
            </div>
        </section>
    </main>

    <script src="js/registro.js"></script>
</body>
</html>
