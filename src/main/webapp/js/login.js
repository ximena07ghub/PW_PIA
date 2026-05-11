document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('formLogin');

    form.addEventListener('submit', (e) => {
        e.preventDefault();

        limpiarErrores();

        const correo = document.getElementById('correo').value.trim();
        const password = document.getElementById('password').value;

        let esValido = true;

        if (correo === "") { mostrarError('correo', 'El correo es requerido.'); esValido = false; }
        else if (!validarEmail(correo)) { mostrarError('correo', 'Ingresa un correo válido.'); esValido = false; }

        if (password === "") { mostrarError('password', 'La contraseña es requerida.'); esValido = false; }
        else if (password.length < 8) { mostrarError('password', 'Mínimo 8 caracteres.'); esValido = false; }

        if (esValido) {
            form.submit();   // ← Envía al Servlet
        }
    });

    function mostrarError(idInput, mensaje) {
        const errorText = document.getElementById(`error${idInput.charAt(0).toUpperCase() + idInput.slice(1)}`);
        const input = document.getElementById(idInput);
        input.classList.add('input-error');
        errorText.textContent = mensaje;
        errorText.style.display = 'block';
    }

    function limpiarErrores() {
        const errores = document.querySelectorAll('.error-text');
        const inputs = document.querySelectorAll('input');
        errores.forEach(e => e.style.display = 'none');
        inputs.forEach(i => i.classList.remove('input-error'));
    }

    function validarEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }
});