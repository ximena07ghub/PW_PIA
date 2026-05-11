document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('formRegistro');

    form.addEventListener('submit', (e) => {
        e.preventDefault();
        limpiarErrores();

        let valido = true;

        const nombres = document.querySelector('[name="nombres"]').value.trim();
        const apellidos = document.querySelector('[name="apellidos"]').value.trim();
        const fechaNac = document.querySelector('[name="fechaNacimiento"]').value;
        const correo = document.querySelector('[name="correo"]').value.trim();
        const nombreUsuario = document.querySelector('[name="nombreUsuario"]').value.trim();
        const password = document.querySelector('[name="password"]').value;
        const confirmPassword = document.querySelector('[name="confirmPassword"]').value;

        // Validaciones
        if (nombres === "") { mostrarError('nombres', 'El nombre es obligatorio'); valido = false; }
        if (apellidos === "") { mostrarError('apellidos', 'Los apellidos son obligatorios'); valido = false; }
        if (fechaNac === "") { mostrarError('fechaNacimiento', 'La fecha de nacimiento es obligatoria'); valido = false; }
        if (correo === "" || !validarEmail(correo)) { mostrarError('correo', 'Correo inválido'); valido = false; }
        if (nombreUsuario === "") { mostrarError('nombreUsuario', 'El nombre de usuario es obligatorio'); valido = false; }
        if (password.length < 8) { mostrarError('password', 'Mínimo 8 caracteres'); valido = false; }
        if (!/[A-Z]/.test(password)) { mostrarError('password', 'Debe tener una mayúscula'); valido = false; }
        if (!/[a-z]/.test(password)) { mostrarError('password', 'Debe tener una minúscula'); valido = false; }
        if (!/[0-9]/.test(password)) { mostrarError('password', 'Debe tener un número'); valido = false; }
        if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) { mostrarError('password', 'Debe tener un signo de puntuación'); valido = false; }
        if (password !== confirmPassword) { mostrarError('confirmPassword', 'Las contraseñas no coinciden'); valido = false; }

        if (valido) {
            form.submit();   // Envía al Servlet
        }
    });

    function mostrarError(campo, mensaje) {
        const span = document.getElementById('error' + campo.charAt(0).toUpperCase() + campo.slice(1));
        if (span) {
            span.textContent = mensaje;
            span.style.display = 'block';
        }
    }

    function limpiarErrores() {
        document.querySelectorAll('.error-text').forEach(el => el.style.display = 'none');
    }

    function validarEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }
});