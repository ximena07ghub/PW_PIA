<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<nav class="navbar">
        <div class="contenedor-nav">
            <div class="logo">
                <span class="logo-icon"></span> RELAX ZONE
            </div>
            
            <div class="busqueda-nav">
                <span class="icono-lupa"></span>
                <input type="text" id="searchInput" placeholder="¿Listo para tu curso de hoy?">
                <button id="btnToggleFiltros" class="btn-filtros-nav">Filtros</button>
                
                <div id="panelFiltros" class="panel-filtros-flotante oculto">
                    <div class="filtro-grupo">
                        <label>Categoría</label>
                        <select>
                            <option>Todas</option>
                            <option>Mindfulness</option>
                            <option>Psicología</option>
                        </select>
                    </div>
                </div>
            </div>
                <div class="nav-links">
                    <%
                        String nombreUsuario = (String) session.getAttribute("nombreUsuario");
                        if (nombreUsuario != null) {
                    %>
                        <div style="display:flex; align-items:center; gap:12px; color:#fff;">
                            <span style="font-weight:600;">Bienvenido, <%= nombreUsuario %></span>
                            <a href="perfil.jsp" style="color:#fff; text-decoration:none;">Perfil</a>
                            <a href="LogoutServlet" style="color:#fff; text-decoration:none;">Cerrar Sesión</a>
                        </div>
                    <%
                        } else {
                    %>
                        <a href="login.jsp" class="link-secundario">Entrar</a>
                        <a href="registro.jsp" class="btn-primario">Regístrate</a>
                    <%
                        }
                    %>
                </div>
        </div>
    </nav>

    <main class="contenedor-principal">
        
        <!-- HERO BANNER -->
        <header class="hero-split">
            <div class="hero-texto">
                <h1>Encuentra tu centro, <br><span>potencia tu talento.</span></h1>
                <p>Únete a nuestra comunidad creativa y espiritual. Un espacio diseñado para impulsar talentos emergentes, trabajar en tu bienestar emocional y construir oportunidades reales.</p>
                
                <div class="hero-botones">
                    <a href="#cursos" class="btn-primario">Explorar Cursos</a>
                    <a href="registro.jsp" class="btn-secundario">Únete a la comunidad</a>
                </div>
            </div>
            
            <div class="hero-imagen">
                <img src="img/imagen2.png" alt="Comunidad Relax Zone">
            </div>
        </header>

        <h2 class="titulo-cursos">CURSOS DISPONIBLES</h2>

            <p class="intro-cursos">
            Explora contenidos diseñados para ayudarte a comprenderte mejor, 
            manejar tus emociones y desarrollar nuevas habilidades personales.
            </p>

        <section class="carrusel-container">
            <div class="carrusel-track">
                
                <!-- EMOCIONAL -->
                <article class="carrusel-card color-1">
                    <div class="card-img-container">
                        <img src="img/diez.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Gestión de emociones</h3>
                        <p>Aprende a identificar, expresar y regular tus emociones.</p>
                        <span class="tag">Emociones</span>
                    </div>
                </article>

                <article class="carrusel-card color-2">
                    <div class="card-img-container">
                        <img src="img/uno.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Sanando mi autoestima</h3>
                        <p>Fortalece tu seguridad y deja de compararte.</p>
                        <span class="tag">Autoestima</span>
                    </div>
                </article>

                <article class="carrusel-card color-3">
                    <div class="card-img-container">
                        <img src="img/seis.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Ansiedad y sobrepensamiento</h3>
                        <p>Calma tu mente con técnicas prácticas.</p>
                        <span class="tag">Ansiedad</span>
                    </div>
                </article>

                <!-- ESPIRITUAL -->
                <article class="carrusel-card color-1">
                    <div class="card-img-container">
                        <img src="img/dos.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Descubriendo mi propósito</h3>
                        <p>Encuentra sentido y dirección en tu vida.</p>
                        <span class="tag">Propósito</span>
                    </div>
                </article>

                <article class="carrusel-card color-2">
                    <div class="card-img-container">
                        <img src="img/siete.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Fe en tiempos difíciles</h3>
                        <p>Aprende a confiar en los procesos.</p>
                        <span class="tag">Fe</span>
                    </div>
                </article>

                <article class="carrusel-card color-3">
                    <div class="card-img-container">
                        <img src="img/tres.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Sanidad interior</h3>
                        <p>Sana heridas emocionales y suelta el pasado.</p>
                        <span class="tag">Sanación</span>
                    </div>
                </article>

                <!-- CREATIVO -->
                <article class="carrusel-card color-1">
                    <div class="card-img-container">
                        <img src="img/diez.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Descubre tu talento</h3>
                        <p>Explora tus habilidades sin miedo.</p>
                        <span class="tag">Creatividad</span>
                    </div>
                </article>

                <article class="carrusel-card color-2">
                    <div class="card-img-container">
                        <img src="img/ocho.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Crecer en redes</h3>
                        <p>Construye tu marca personal.</p>
                        <span class="tag">Redes</span>
                    </div>
                </article>

                <article class="carrusel-card color-3">
                    <div class="card-img-container">
                        <img src="img/cuatro.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Crear en comunidad</h3>
                        <p>Colabora y crea proyectos con otros.</p>
                        <span class="tag">Comunidad</span>
                    </div>
                </article>

                <!-- REPETICIONES PARA CARRUSEL INFINITO -->
                <article class="carrusel-card color-1">
                    <div class="card-img-container">
                        <img src="img/emociones.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Gestión de emociones</h3>
                        <p>Aprende a identificar, expresar y regular tus emociones.</p>
                        <span class="tag">Emociones</span>
                    </div>
                </article>

                <article class="carrusel-card color-2">
                    <div class="card-img-container">
                        <img src="img/autoestima.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Sanando mi autoestima</h3>
                        <p>Fortalece tu seguridad y deja de compararte.</p>
                        <span class="tag">Autoestima</span>
                    </div>
                </article>

                <article class="carrusel-card color-3">
                    <div class="card-img-container">
                        <img src="img/ansiedad.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Ansiedad y sobrepensamiento</h3>
                        <p>Calma tu mente con técnicas prácticas.</p>
                        <span class="tag">Ansiedad</span>
                    </div>
                </article>

                <article class="carrusel-card color-1">
                    <div class="card-img-container">
                        <img src="img/cinco.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Descubriendo mi propósito</h3>
                        <p>Encuentra sentido y dirección en tu vida.</p>
                        <span class="tag">Propósito</span>
                    </div>
                </article>

                <article class="carrusel-card color-2">
                    <div class="card-img-container">
                        <img src="img/fe.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Fe en tiempos difíciles</h3>
                        <p>Aprende a confiar en los procesos.</p>
                        <span class="tag">Fe</span>
                    </div>
                </article>

                <article class="carrusel-card color-3">
                    <div class="card-img-container">
                        <img src="img/sanidad.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Sanidad interior</h3>
                        <p>Sana heridas emocionales y suelta el pasado.</p>
                        <span class="tag">Sanación</span>
                    </div>
                </article>

                <article class="carrusel-card color-1">
                    <div class="card-img-container">
                        <img src="img/talento.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Descubre tu talento</h3>
                        <p>Explora tus habilidades sin miedo.</p>
                        <span class="tag">Creatividad</span>
                    </div>
                </article>

                <article class="carrusel-card color-2">
                    <div class="card-img-container">
                        <img src="img/redes.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Crecer en redes</h3>
                        <p>Construye tu marca personal.</p>
                        <span class="tag">Redes</span>
                    </div>
                </article>

                <article class="carrusel-card color-3">
                    <div class="card-img-container">
                        <img src="img/comunidad.jpg">
                    </div>
                    <div class="card-contenido">
                        <h3>Crear en comunidad</h3>
                        <p>Colabora y crea proyectos con otros.</p>
                        <span class="tag">Comunidad</span>
                    </div>
                </article>
            </div>
        </section>

    <!-- TEMARIO -->
    <section class="temario-section">
        <div class="encabezado-seccion">
            <h2>Lo que aprenderás con nosotros</h2>
            <p>Nuestra metodología integral dividida en tres pilares fundamentales.</p>
        </div>

        <div class="grid-temario">
            <!-- Pilar 1 -->
            <div class="columna-temario">
                <h3 class="titulo-pilar">1. Bienestar Emocional</h3>
                
                <div class="curso-item">
                    <h4>Gestión de emociones desde cero</h4>
                    <ul>
                        <li>Identificar emociones</li>
                        <li>No explotar o guardarlas</li>
                        <li>Expresarse mejor</li>
                    </ul>
                </div>
                <div class="curso-item">
                    <h4>Sanando mi autoestima</h4>
                    <ul>
                        <li>Valor personal</li>
                        <li>Seguridad</li>
                        <li>Dejar de compararse</li>
                    </ul>
                </div>
                <div class="curso-item">
                    <h4>Ansiedad y sobrepensamiento</h4>
                    <ul>
                        <li>Calmar la mente</li>
                        <li>Dejar de sobrepensar</li>
                        <li>Técnicas prácticas</li>
                    </ul>
                </div>
            </div>

            <!-- Pilar 2 -->
            <div class="columna-temario">
                <h3 class="titulo-pilar">2. Cursos Espirituales</h3>
                
                <div class="curso-item">
                    <h4>Descubriendo mi propósito</h4>
                    <ul>
                        <li>Identidad</li>
                        <li>Sentido de vida</li>
                        <li>Conexión espiritual</li>
                    </ul>
                </div>
                <div class="curso-item">
                    <h4>Fe en tiempos difíciles</h4>
                    <ul>
                        <li>Cómo mantener la fe</li>
                        <li>Confiar en los procesos</li>
                        <li>Resiliencia</li>
                    </ul>
                </div>
                <div class="curso-item">
                    <h4>Sanidad interior</h4>
                    <ul>
                        <li>Heridas emocionales</li>
                        <li>El poder del perdón</li>
                        <li>Soltar el pasado</li>
                    </ul>
                </div>
            </div>

            <!-- Pilar 3 -->
            <div class="columna-temario">
                <h3 class="titulo-pilar">3. Cursos Creativos</h3>
                
                <div class="curso-item">
                    <h4>Descubre tu talento</h4>
                    <ul>
                        <li>Identificar habilidades</li>
                        <li>Probar áreas creativas</li>
                        <li>Perder el miedo</li>
                    </ul>
                </div>
                <div class="curso-item">
                    <h4>Crecer siendo creativo</h4>
                    <ul>
                        <li>Creación de contenido</li>
                        <li>Marca personal</li>
                        <li>Cómo mostrarse al mundo</li>
                    </ul>
                </div>
                <div class="curso-item">
                    <h4>Crear en comunidad</h4>
                    <ul>
                        <li>Trabajar en equipo</li>
                        <li>Networking efectivo</li>
                        <li>Proyectos colaborativos</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQS Y CONTACTO -->
    <section class="soporte-section">
        <div class="faqs-contenedor">
            <h2>Preguntas Frecuentes</h2>
            <div class="grid-faqs">
                <div class="faq-item">
                    <h4>¿Tienen algún costo los cursos?</h4>
                    <p>Nuestra comunidad funciona con un modelo ganar-ganar. Ofrecemos contenido gratuito y talleres premium accesibles para sostener el proyecto.</p>
                </div>
                <div class="faq-item">
                    <h4>¿Cómo puedo colaborar?</h4>
                    <p>Buscamos creadores, diseñadores y mentores. Si tienes un talento, únete a nuestra red y construyamos juntos.</p>
                </div>
                <div class="faq-item">
                    <h4>¿Necesito experiencia previa?</h4>
                    <p>En absoluto. Nuestros cursos están diseñados desde cero para ayudarte a descubrir y pulir tus talentos paso a paso.</p>
                </div>
                <div class="faq-item">
                    <h4>¿Es un grupo religioso?</h4>
                    <p>No, somos una comunidad creativa. Integramos valores espirituales para fortalecer tu identidad y propósito, abierto a todos.</p>
                </div>
            </div>
        </div>

        <div class="caja-contacto">
            <h3>¿Quieres sumar tu talento?</h3>
            <p>Nadie trabaja gratis, todos reciben algo. Si te interesa ofrecer tus servicios creativos o patrocinar el proyecto, escríbenos.</p>
            <form class="form-contacto">
                <input type="email" placeholder="Tu correo electrónico">
                <button type="button" class="btn-primario">Quiero Colaborar</button>
            </form>
        </div>
    </section>

</main>

<!-- CTA BANNER -->
<div class="cta-banner">
    <h2>Un espacio donde se conectan talentos y se crean proyectos juntos.</h2>
    <a href="registro.jsp" class="btn-banner">Únete hoy</a>
</div>

<footer class="footer-pro">
    <div class="footer-grid">
        <div class="footer-col">
            <span class="logo-icon"></span> <strong>RELAX ZONE</strong>
            <p>Apoyo emocional, creativo y espiritual para impulsar a los jóvenes con talentos artísticos.</p>
        </div>
        <div class="footer-col">
            <h4>Comunidad</h4>
            <a href="#">Sobre Nosotros</a>
            <a href="#">Nuestra Misión</a>
            <a href="#">Blog Creativo</a>
        </div>
        <div class="footer-col">
            <h4>Legal</h4>
            <a href="#">Términos y Condiciones</a>
            <a href="#">Política de Privacidad</a>
        </div>
        <div class="footer-col">
            <h4>Contacto</h4>
            <p> hola@relaxzone.com</p>
            <p> +52 (81) 0000-0000</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 Ximena & Kevin | FCFM Programación Web I</p>
    </div>
</footer>

<script src="js/index.js"></script>
</body>
</html>