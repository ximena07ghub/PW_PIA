<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Regístrate - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="body-auth">

    <nav class="navbar navbar-auth">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo">RELAX ZONE</a>
            <div class="nav-links">
                <a href="login.jsp" class="link-secundario">Entrar</a>
            </div>
        </div>
    </nav>

    <main class="auth-wrapper">
        <div class="auth-container registro-layout">
            
            <!-- Panel izquierdo (igual que antes) -->
            <div class="auth-info-side">
                <h3>Únete a la Comunidad</h3>
                <p class="mision-text">Un espacio donde se conectan talentos, se crean proyectos y se recibe guía creativa y espiritual.</p>
                
                <div class="beneficios-lista">
                    <p>✓ Apoyo emocional + creativo</p>
                    <p>✓ Crecimiento integral (TÚ eres el diferencial)</p>
                    <p>✓ Red de apoyo real</p>
                </div>

                <div class="redes-sociales">
                    <span>Síguenos en nuestras redes:</span>
                    <div class="iconos-redes">
                        <a href="#" title="Instagram">IG</a>
                        <a href="#" title="Facebook">FB</a>
                        <a href="#" title="TikTok">TT</a>
                    </div>
                </div>
            </div>

            <!-- Panel derecho - Título arriba con más espacio -->
            <div class="auth-form-side">
                <h3 style="margin-bottom: 2.8rem;">Crea tu cuenta</h3>
                
                <form id="formRegistro" action="RegistroServlet" method="post" enctype="multipart/form-data">
                    <div class="form-grid">
                        <div class="input-grupo">
                            <label>Nombre(s)</label>
                            <input type="text" name="nombres" placeholder="Ej. Daniela Ximena" required>
                            <span class="error-text" id="errorNombres"></span>
                        </div>
                        <div class="input-grupo">
                            <label>Apellidos</label>
                            <input type="text" name="apellidos" placeholder="Ej. Orozco Ramírez" required>
                            <span class="error-text" id="errorApellidos"></span>
                        </div>
                        <div class="input-grupo">
                            <label>Fecha de Nacimiento</label>
                            <input type="date" name="fechaNacimiento" required>
                            <span class="error-text" id="errorFecha"></span>
                        </div>
                        <div class="input-grupo">
                            <label>Correo Electrónico</label>
                            <input type="email" name="correo" placeholder="ejemplo@correo.com" required>
                            <span class="error-text" id="errorCorreo"></span>
                        </div>
                        <div class="input-grupo">
                            <label>Nombre de Usuario</label>
                            <input type="text" name="nombreUsuario" placeholder="Ej. ximena_orz" required>
                            <span class="error-text" id="errorNombreUsuario"></span>
                        </div>
                        <div class="input-grupo">
                            <label>Contraseña</label>
                            <input type="password" name="password" placeholder="Mín. 8 caracteres" required>
                            <span class="error-text" id="errorPassword"></span>
                            <small style="color:#666;">Mayúscula • Minúscula • Número • Signo</small>
                        </div>
                        <div class="input-grupo">
                            <label>Confirmar Contraseña</label>
                            <input type="password" name="confirmPassword" placeholder="Repite tu contraseña" required>
                            <span class="error-text" id="errorConfirmPassword"></span>
                        </div>
                        <div class="input-grupo foto-grupo full-width">
                            <label>Foto de Perfil (PNG o JPG)</label>
                            <input type="file" name="fotoPerfil" accept=".png,.jpg,.jpeg">
                        </div>
                    </div>

                    <button type="submit" class="btn-auth">Registrarme</button>
                </form>
            </div>
        </div>
    </main>

    <script src="js/registro.js"></script>
</body>
</html>