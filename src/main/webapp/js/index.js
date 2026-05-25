document.addEventListener("DOMContentLoaded", function () {
    const btnToggleFiltros = document.getElementById("btnToggleFiltros");
    const panelFiltros = document.getElementById("panelFiltros");
    const searchInput = document.getElementById("searchInput");
    const carousel = document.getElementById("coursesCarousel");
    const cards = document.querySelectorAll(".home-course-card");
    const filterButtons = document.querySelectorAll(".filter-chip");
    const noResults = document.getElementById("noResults");
    let activeFilter = "todas";

    if (btnToggleFiltros && panelFiltros) {
        btnToggleFiltros.addEventListener("click", function () {
            panelFiltros.classList.toggle("oculto");
        });
    }

    function normalize(text) {
        return text
            .toLowerCase()
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "");
    }

    // Une palabras parecidas para que la busqueda no sea literal.
    function relatedTerms(term) {
        const normalized = normalize(term);
        const groups = [
            ["ansiedad", "estres", "calma", "respiracion", "mindfulness", "sobrepensamiento"],
            ["autoestima", "seguridad", "comparacion", "valor", "autocompasion"],
            ["proposito", "sentido", "identidad", "dones", "servicio", "fe", "espiritualidad"],
            ["creatividad", "talento", "arte", "contenido", "redes", "marca", "proyecto"],
            ["comunidad", "colaboracion", "equipo", "feedback", "co-creacion"],
            ["dinero", "monetizacion", "precio", "oferta", "clientes", "emprendimiento"]
        ];
        const terms = normalized.split(/\s+/).filter(Boolean);

        groups.forEach(function (group) {
            if (group.some(function (word) { return terms.indexOf(word) >= 0 || normalized.indexOf(word) >= 0; })) {
                group.forEach(function (word) {
                    if (terms.indexOf(word) < 0) terms.push(word);
                });
            }
        });

        return terms;
    }

    function applyFilters() {
        const currentCards = document.querySelectorAll(".home-course-card");
        if (!currentCards.length) return;

        const terms = relatedTerms(searchInput ? searchInput.value.trim() : "");
        const isFiltering = terms.length > 0 || activeFilter !== "todas";
        let visibleCount = 0;

        currentCards.forEach(function (card) {
            const categoryMatch = activeFilter === "todas" || card.dataset.category === activeFilter;
            const text = normalize(card.textContent + " " + (card.dataset.keywords || ""));
            const textMatch = terms.length === 0 || terms.some(function (term) {
                return text.indexOf(term) >= 0;
            });
            const show = categoryMatch && textMatch;

            card.style.display = show ? "" : "none";
            if (show && !card.classList.contains("duplicate")) {
                visibleCount += 1;
            }
        });

        if (carousel) {
            carousel.classList.toggle("filtrado", isFiltering);
        }

        if (noResults) {
            noResults.style.display = visibleCount === 0 ? "block" : "none";
        }
    }

    if (searchInput) {
        searchInput.addEventListener("input", applyFilters);
    }

    filterButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            filterButtons.forEach(function (item) {
                item.classList.remove("activo");
            });

            button.classList.add("activo");
            activeFilter = button.dataset.filter || "todas";
            applyFilters();
        });
    });

    cards.forEach(function (card) {
        card.addEventListener("mouseenter", function () {
            cards.forEach(function (item) {
                item.classList.remove("is-active");
            });
            card.classList.add("is-active");
        });

        card.addEventListener("focus", function () {
            cards.forEach(function (item) {
                item.classList.remove("is-active");
            });
            card.classList.add("is-active");
        });
    });
});
