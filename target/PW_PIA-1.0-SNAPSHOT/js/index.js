// js/index.js

// Esperamos a que el HTML cargue completamente
document.addEventListener('DOMContentLoaded', function() {
    
    const btnToggleFiltros = document.getElementById('btnToggleFiltros');
    const panelFiltros = document.getElementById('panelFiltros');

    // Cuando le damos clic al botón...
    btnToggleFiltros.addEventListener('click', function() {
        // Quitamos o ponemos la clase 'oculto' que creamos en el CSS
        panelFiltros.classList.toggle('oculto');
    });

});