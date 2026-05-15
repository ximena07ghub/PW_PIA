<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Cursos - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    
    <style>
        
        /* Estilos específicos para el Dashboard y Modal (puedes pasarlos a tu CSS global luego) */
        
        .dashboard-header { padding: 3rem 2rem 2rem; max-width: 1200px; margin: 0 auto; }
        .dashboard-header h1 { font-size: 2.2rem; color: #ffffff; }
        .dashboard-header p { color: var(--color-texto-suave); font-size: 1.1rem; }
        
        .progreso-barra-bg { width: 100%; background-color: #1a3a3a; height: 8px; margin: 10px 0; }
        .progreso-barra-fill { background-color: var(--color-primario); height: 100%; transition: width 1s ease; }
        
        .nav-perfil { display: flex; align-items: center; gap: 1rem; cursor: pointer; padding: 0.5rem; border-radius: 8px; transition: background 0.3s; }
        .nav-perfil:hover { background-color: rgba(255,255,255,0.05); }
        .avatar-img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid var(--color-primario); }
        
        /* Modal de Foto */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); display: flex; justify-content: center; align-items: center; z-index: 2000; opacity: 0; pointer-events: none; transition: opacity 0.3s; }
        .modal-overlay.activo { opacity: 1; pointer-events: all; }
        .modal-caja { background: var(--color-fondo-nav); padding: 2rem; border: 1px solid var(--color-borde); text-align: center; width: 90%; max-width: 350px; }
        .preview-foto { width: 150px; height: 150px; border-radius: 50%; object-fit: cover; margin: 1rem auto; border: 2px dashed var(--color-primario); padding: 5px; }
        
    </style>
    
</head>
<body>

    <nav class="navbar">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo"> RELAX ZONE</a>
            
            <div class="busqueda-nav">
                <span class="icono-lupa">?</span>
                <input type="text" placeholder="Buscar nuevas clases...">
            </div>

            <div class="nav-perfil" id="btnPerfil">
                <span id="txtNombreUsuario" style="color: white; font-weight: 500;">Cargando...</span>
                <img id="imgAvatarNav" class="avatar-img" src="" alt="Perfil">
            </div>
        </div>
    </nav>

    <main style="min-height: 80vh;">
        <div class="dashboard-header">
            <h1>Mis Rutas de Aprendizaje</h1>
            <p>Continúa donde te quedaste. El bienestar es un proceso diario.</p>
        </div>

        <section class="grid-temario" style="max-width: 1200px; margin: 0 auto; padding: 0 2rem;">
            
            <article class="curso-item" style="border-radius: 0; display: flex; flex-direction: column;">
                <div style="background: url('https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&w=600&q=80') center/cover; height: 140px; margin: -1.5rem -1.5rem 1rem -1.5rem;"></div>
                <h3 style="color: white; font-size: 1.2rem;">Terapia Cognitiva: Básicos</h3>
                <p style="color: var(--color-texto-suave); font-size: 0.9rem; margin-bottom: auto;">Módulo 2: Identificando distorsiones.</p>
                
                <div class="progreso-barra-bg">
                    <div class="progreso-barra-fill" style="width: 45%;"></div>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
                    <span style="color: var(--color-primario); font-size: 0.85rem; font-weight: bold;">45% Completado</span>
                    <button class="btn-primario" style="border-radius: 0; padding: 0.4rem 1rem;">Continuar</button>
                </div>
            </article>

            <article class="curso-item" style="border-radius: 0; display: flex; flex-direction: column;">
                <div style="background: url('https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=600&q=80') center/cover; height: 140px; margin: -1.5rem -1.5rem 1rem -1.5rem;"></div>
                <h3 style="color: white; font-size: 1.2rem;">Mindfulness para Creativos</h3>
                <p style="color: var(--color-texto-suave); font-size: 0.9rem; margin-bottom: auto;">Módulo 1: Respiración consciente.</p>
                
                <div class="progreso-barra-bg">
                    <div class="progreso-barra-fill" style="width: 15%;"></div>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
                    <span style="color: var(--color-primario); font-size: 0.85rem; font-weight: bold;">15% Completado</span>
                    <button class="btn-primario" style="border-radius: 0; padding: 0.4rem 1rem;">Continuar</button>
                </div>
            </article>
            
        </section>
    </main>

    <div id="modalFoto" class="modal-overlay">
        <div class="modal-caja">
            <h3 style="color: white; margin-bottom: 10px;">Actualizar Perfil</h3>
            <p style="color: var(--color-texto-suave); font-size: 0.85rem;">Sube una nueva foto para tu cuenta.</p>
            
            <img id="previewModal" class="preview-foto" src="" alt="Preview">
            
            <input type="file" id="inputFile" accept="image/*" style="display: none;">
            
            <button id="btnElegir" class="btn-secundario" style="width: 100%; margin-bottom: 10px; border-radius: 0;">Explorar Archivos</button>
            <button id="btnGuardarFoto" class="btn-primario" style="width: 100%; border-radius: 0;">Guardar Cambios</button>
            <button id="btnCerrarModal" style="background: transparent; border: none; color: #ff5252; margin-top: 15px; cursor: pointer; text-decoration: underline;">Cancelar</button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // 1. Proteger la ruta (Si no hay sesión, regresarlo al login)
            if (localStorage.getItem('relaxzone_sesion') !== 'activa') {
                window.location.href = "login.jsp"; 
                return;
            }

            // 2. Cargar datos en el Navbar
            const usuario = JSON.parse(localStorage.getItem('relaxzone_usuario'));
            const imgAvatarNav = document.getElementById('imgAvatarNav');
            const previewModal = document.getElementById('previewModal');
            
            if(usuario) {
                document.getElementById('txtNombreUsuario').textContent = usuario.nombre;
                imgAvatarNav.src = usuario.foto;
                previewModal.src = usuario.foto;
            }

            // 3. Lógica del Modal
            const modal = document.getElementById('modalFoto');
            
            // Abrir
            document.getElementById('btnPerfil').addEventListener('click', () => {
                modal.classList.add('activo');
            });
            // Cerrar
            document.getElementById('btnCerrarModal').addEventListener('click', () => {
                modal.classList.remove('activo');
            });

            // Seleccionar foto (Abre explorador de archivos)
            const inputFile = document.getElementById('inputFile');
            document.getElementById('btnElegir').addEventListener('click', () => inputFile.click());

            // Previsualizar la foto elegida
            inputFile.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        previewModal.src = e.target.result;
                    };
                    reader.readAsDataURL(this.files[0]);
                }
            });

            // Guardar nueva foto
            document.getElementById('btnGuardarFoto').addEventListener('click', () => {
                const nuevaImgUrl = previewModal.src;
                imgAvatarNav.src = nuevaImgUrl; // Actualiza el nav
                
                usuario.foto = nuevaImgUrl;
                localStorage.setItem('relaxzone_usuario', JSON.stringify(usuario)); // Guarda en "BD"
                
                modal.classList.remove('activo');
                alert("Foto actualizada correctamente.");
                
                
                
            });
        });
    </script>
</body>
</html>
