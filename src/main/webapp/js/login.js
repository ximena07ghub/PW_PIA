document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formLogin");
    const login = document.getElementById("login");
    const password = document.getElementById("password");

    if (!form || !login || !password) return;

    form.addEventListener("submit", function (event) {
        if (login.value.trim() === "") {
            event.preventDefault();
            alert("Escribe tu correo o nombre de usuario.");
            login.focus();
            return;
        }

        if (password.value.trim() === "") {
            event.preventDefault();
            alert("Escribe tu contraseña.");
            password.focus();
        }
    });
});
