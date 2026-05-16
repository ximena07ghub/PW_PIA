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

    function applyFilters() {
        if (!cards.length) return;

        const term = normalize(searchInput ? searchInput.value.trim() : "");
        const isFiltering = term.length > 0 || activeFilter !== "todas";
        let visibleCount = 0;

        cards.forEach(function (card) {
            const categoryMatch = activeFilter === "todas" || card.dataset.category === activeFilter;
            const text = normalize(card.textContent + " " + (card.dataset.keywords || ""));
            const textMatch = term === "" || text.includes(term);
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
