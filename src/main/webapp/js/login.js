<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="body-auth">
    <div class="auth-container login-layout">
        <div class="auth-visual"><img src="img/login_vector.svg" alt="Login"></div>
        <div class="auth-form-side">
            <form id="formLogin">
                <h3>Iniciar Sesión</h3>
                <div class="input-grupo"><label>Correo</label><input type="email" id="lCorreo" required></div>
                <div class="input-grupo"><label>Password</label><input type="password" id="lPass" required></div>
                <button type="submit" class="btn-auth">Entrar</button>
            </form>
        </div>
    </div>
    <script>
        document.getElementById('formLogin').addEventListener('submit', (e) => {
            e.preventDefault();
            const bd = JSON.parse(localStorage.getItem('usuarioBD'));
            if(bd && bd.correo === document.getElementById('lCorreo').value && bd.pass === document.getElementById('lPass').value){
                alert("¡Bienvenido " + bd.nombre + "!");
                localStorage.setItem('sesionActiva', 'true');
                window.location.href = "dashboard.jsp";
            } else {
                alert("Datos incorrectos");
            }
        });
    </script>
</body>
</html>