<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="body-auth">
    <div class="auth-container">
        <div class="auth-info-side">
            <h3>Bienvenido</h3>
            <p>Únete a nuestra comunidad creativa.</p>
        </div>
        <div class="auth-form-side">
            <form id="formRegistro">
                <h3>Crea tu cuenta</h3>
                <div class="form-grid">
                    <div class="input-grupo"><label>Nombre</label><input type="text" id="nombre" required></div>
                    <div class="input-grupo"><label>Correo</label><input type="email" id="correo" required></div>
                    <div class="input-grupo"><label>Password</label><input type="password" id="pass" required></div>
                    <div class="input-grupo"><label>Confirmar</label><input type="password" id="passConfirm" required></div>
                </div>
                <button type="submit" class="btn-auth">Registrarme</button>
            </form>
        </div>
    </div>
    <script>
        document.getElementById('formRegistro').addEventListener('submit', (e) => {
            e.preventDefault();
            const pass = document.getElementById('pass').value;
            if(pass !== document.getElementById('passConfirm').value) return alert("Contraseñas no coinciden");
            
            const usuario = {
                nombre: document.getElementById('nombre').value,
                correo: document.getElementById('correo').value,
                pass: pass,
                foto: "img/avatar_default.png"
            };
            localStorage.setItem('usuarioBD', JSON.stringify(usuario));
            alert("¡Usuario guardado con éxito!");
            window.location.href = "login.jsp";
        });
    </script>
</body>
</html>