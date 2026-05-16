document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formRegistro");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");

    if (!form || !password || !confirmPassword) return;

    form.addEventListener("submit", function (event) {
        if (password.value.length < 8) {
            event.preventDefault();
            alert("La contraseña debe tener al menos 8 caracteres.");
            password.focus();
            return;
        }

        if (password.value !== confirmPassword.value) {
            event.preventDefault();
            alert("Las contraseñas no coinciden.");
            confirmPassword.focus();
        }
    });
});
