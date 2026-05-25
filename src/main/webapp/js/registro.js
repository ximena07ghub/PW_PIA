document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formRegistro");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const passwordHelp = document.getElementById("passwordHelp");

    if (!form || !password || !confirmPassword) return;

    const requirements = [
        { label: "8 caracteres", test: (value) => value.length >= 8 },
        { label: "mayuscula", test: (value) => /[A-Z]/.test(value) },
        { label: "minuscula", test: (value) => /[a-z]/.test(value) },
        { label: "numero", test: (value) => /\d/.test(value) },
        { label: "simbolo", test: (value) => /[^A-Za-z0-9]/.test(value) }
    ];

    function getMissingRequirements(value) {
        return requirements
            .filter((requirement) => !requirement.test(value))
            .map((requirement) => requirement.label);
    }

    function updatePasswordHelp() {
        if (!passwordHelp) return;

        const missing = getMissingRequirements(password.value);
        passwordHelp.classList.remove("is-warning", "is-ok");

        if (!password.value) {
            passwordHelp.textContent = "Usa mayuscula, minuscula, numero y simbolo.";
            return;
        }

        if (missing.length === 0) {
            passwordHelp.textContent = "Contrasena lista.";
            passwordHelp.classList.add("is-ok");
            return;
        }

        passwordHelp.textContent = "Falta: " + missing.join(", ") + ".";
        passwordHelp.classList.add("is-warning");
    }

    function updateConfirmPassword() {
        if (!confirmPassword.value || password.value === confirmPassword.value) {
            confirmPassword.setCustomValidity("");
            return true;
        }

        confirmPassword.setCustomValidity("Las contrasenas no coinciden.");
        return false;
    }

    password.addEventListener("input", function () {
        updatePasswordHelp();
        updateConfirmPassword();
    });

    password.addEventListener("focus", updatePasswordHelp);
    confirmPassword.addEventListener("input", updateConfirmPassword);

    form.addEventListener("submit", function (event) {
        const missing = getMissingRequirements(password.value);

        if (missing.length > 0) {
            event.preventDefault();
            updatePasswordHelp();
            password.setCustomValidity("La contrasena debe incluir: " + missing.join(", ") + ".");
            password.reportValidity();
            password.setCustomValidity("");
            password.focus();
            return;
        }

        if (!updateConfirmPassword()) {
            event.preventDefault();
            confirmPassword.reportValidity();
            confirmPassword.focus();
        }
    });

    updatePasswordHelp();
});
