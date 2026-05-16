<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    if (nombreUsuario == null || nombreUsuario.trim().isEmpty()) {
        nombreUsuario = "Estudiante";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curso - Relax Zone</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .detalle-shell {
            max-width: 1180px;
            margin: 0 auto;
            padding: 2rem;
        }

        .back-link {
            color: var(--color-texto);
            text-decoration: none;
            font-weight: 700;
            display: inline-flex;
            margin-bottom: 1rem;
        }

        .course-hero {
            background: var(--color-fondo-card);
            border: 1px solid var(--color-borde);
            border-radius: 12px;
            color: #ffffff;
            overflow: hidden;
            display: grid;
            grid-template-columns: minmax(0, 1.1fr) 420px;
            min-height: 360px;
            box-shadow: 0 18px 40px rgba(2, 61, 85, 0.12);
        }

        .course-hero-text {
            padding: 2.3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .course-hero-text h1 {
            color: #ffffff;
            font-size: clamp(2rem, 5vw, 3.7rem);
            line-height: 1;
            letter-spacing: 0;
            margin-bottom: 1rem;
        }

        .course-hero-text p {
            color: var(--color-texto-suave);
            font-size: 1.02rem;
            max-width: 680px;
        }

        .course-category {
            color: var(--color-primario);
            text-transform: uppercase;
            font-size: 0.78rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 0.7rem;
        }

        .course-hero-image {
            min-height: 300px;
            position: relative;
            background: #023d55;
        }

        .course-hero-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            inset: 0;
        }

        .course-hero-image::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(90deg, rgba(2,61,85,0.5), rgba(2,61,85,0.08));
        }

        .hero-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
            margin-top: 1.5rem;
        }

        .hero-actions .btn-primario {
            display: inline-block;
            text-decoration: none;
        }

        .btn-outline-light {
            color: #ffffff;
            border: 1px solid rgba(255,255,255,0.45);
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        .detalle-grid {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 330px;
            gap: 1.5rem;
            margin-top: 1.5rem;
            align-items: start;
        }

        .detail-panel,
        .side-panel {
            background: #ffffff;
            border: 1px solid #d8e5ec;
            border-radius: 12px;
            padding: 1.5rem;
        }

        .detail-panel + .detail-panel {
            margin-top: 1rem;
        }

        .detail-panel h2,
        .side-panel h2 {
            color: var(--color-texto);
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .learn-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 0.8rem 1.3rem;
        }

        .learn-item {
            display: grid;
            grid-template-columns: 24px 1fr;
            gap: 0.6rem;
            color: #263955;
            font-size: 0.95rem;
        }

        .check {
            color: var(--color-primario);
            font-weight: 900;
        }

        .topic-list,
        .includes-list,
        .resource-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.65rem;
            list-style: none;
        }

        .topic-list li {
            border: 1px solid var(--color-borde);
            border-radius: 8px;
            padding: 0.45rem 0.7rem;
            font-weight: 800;
            color: var(--color-texto);
            background: #f8fcfd;
            font-size: 0.88rem;
        }

        .includes-list {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .includes-list li,
        .resource-list a {
            color: #263955;
            text-decoration: none;
        }

        .resource-list {
            display: grid;
        }

        .resource-list a {
            border: 1px solid #d8e5ec;
            border-radius: 8px;
            padding: 0.85rem;
            background: #f8fcfd;
            font-weight: 700;
        }

        .module-list {
            display: grid;
            gap: 0.75rem;
        }

        .module-item {
            border: 1px solid #d8e5ec;
            border-radius: 10px;
            overflow: hidden;
            background: #f8fcfd;
        }

        .module-item summary {
            cursor: pointer;
            padding: 1rem;
            font-weight: 800;
            color: var(--color-texto);
        }

        .module-item ul {
            list-style: none;
            padding: 0 1rem 1rem;
            color: #344a6b;
        }

        .module-item li {
            padding: 0.35rem 0;
            border-top: 1px solid #e6eef2;
        }

        .side-panel {
            position: sticky;
            top: 94px;
        }

        .side-panel .btn-primario {
            display: block;
            text-align: center;
            text-decoration: none;
            width: 100%;
        }

        .side-note {
            color: #52657d;
            font-size: 0.9rem;
            margin: 1rem 0;
        }

        .facts {
            display: grid;
            gap: 0.75rem;
            margin-top: 1.2rem;
            color: #263955;
        }

        .facts div {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            border-top: 1px solid #e6eef2;
            padding-top: 0.75rem;
        }

        .facts strong {
            color: var(--color-texto);
        }

        @media (max-width: 950px) {
            .course-hero,
            .detalle-grid {
                grid-template-columns: 1fr;
            }

            .side-panel {
                position: static;
            }
        }

        @media (max-width: 680px) {
            .detalle-shell {
                padding: 1rem;
            }

            .learn-grid,
            .includes-list {
                grid-template-columns: 1fr;
            }

            .contenedor-nav {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="contenedor-nav">
            <a href="index.jsp" class="logo"><span class="logo-icon"></span> RELAX ZONE</a>
            <div class="busqueda-nav">
                <span class="icono-lupa"></span>
                <input type="text" id="quickSearch" placeholder="Buscar dentro del curso">
            </div>
            <div class="nav-links">
                <span style="color:#ffffff; font-weight:600;">Hola, <%= nombreUsuario %></span>
                <a href="dashboard.jsp" class="link-secundario">Mis cursos</a>
                <a href="categorias.jsp" class="link-secundario">Catálogo</a>
                <a href="comunidad.jsp" class="link-secundario">Comunidad</a>
                <a href="perfil.jsp" class="link-secundario">Perfil</a>
                <a href="LogoutServlet" class="link-secundario">Cerrar sesión</a>
            </div>
        </div>
    </nav>

    <main class="detalle-shell">
        <a href="dashboard.jsp" class="back-link">&larr; Volver a mis cursos</a>

        <section class="course-hero">
            <div class="course-hero-text">
                <p class="course-category" id="courseCategory">Curso</p>
                <h1 id="courseTitle">Cargando curso...</h1>
                <p id="courseDescription">Estamos preparando el contenido del curso seleccionado.</p>
                <div class="hero-actions">
                    <a href="#contenido" class="btn-primario">Ver contenido</a>
                    <a href="#recursos" class="btn-outline-light">Recursos sugeridos</a>
                </div>
            </div>
            <div class="course-hero-image">
                <img id="courseImage" src="img/imagen2.png" alt="Imagen del curso">
            </div>
        </section>

        <div class="detalle-grid">
            <div>
                <section class="detail-panel">
                    <h2>Lo que aprenderás</h2>
                    <div class="learn-grid" id="learnList"></div>
                </section>

                <section class="detail-panel">
                    <h2>Ver temas relacionados</h2>
                    <ul class="topic-list" id="topicList"></ul>
                </section>

                <section class="detail-panel">
                    <h2>Este curso incluye</h2>
                    <ul class="includes-list" id="includesList"></ul>
                </section>

                <section class="detail-panel" id="contenido">
                    <h2>Contenido del curso</h2>
                    <div class="module-list" id="moduleList"></div>
                </section>

                <section class="detail-panel" id="recursos">
                    <h2>Lecturas y videos sugeridos</h2>
                    <div class="resource-list" id="resourceList"></div>
                </section>
            </div>

            <aside class="side-panel">
                <h2>Empieza gratis</h2>
                <p class="side-note">Este proyecto no cobra por acceder al curso. La idea es aprender con teoría, actividades, reflexión y referencias externas.</p>
                <a href="#contenido" class="btn-primario">Comenzar curso</a>
                <div class="facts">
                    <div><span>Nivel</span><strong id="courseLevel">Inicial</strong></div>
                    <div><span>Duración</span><strong id="courseDuration">4 semanas</strong></div>
                    <div><span>Formato</span><strong>Lectura y práctica</strong></div>
                    <div><span>Acceso</span><strong>Gratuito</strong></div>
                </div>
            </aside>
        </div>
    </main>

    <script>
        const courses = {
            "1": {
                title: "Gestión de emociones desde cero",
                category: "Bienestar emocional",
                image: "img/diez.jpg",
                description: "Aprende a identificar tus emociones, regularlas y expresarlas sin explotar ni guardarlo todo.",
                level: "Inicial",
                duration: "4 semanas",
                learn: ["Nombrar emociones con más claridad", "Diferenciar reacción, emoción y necesidad", "Usar pausas para responder mejor", "Expresar lo que sientes con respeto"],
                topics: ["Emociones", "Comunicación", "Autoconocimiento", "Diario emocional"],
                modules: [
                    ["Reconocer lo que siento", "Rueda de emociones", "Registro diario de estados de ánimo"],
                    ["Regular antes de reaccionar", "Respiración y pausa", "Técnica de semáforo emocional"],
                    ["Expresarme sin herir", "Mensajes en primera persona", "Conversaciones difíciles"],
                    ["Plan personal", "Hábitos de cuidado", "Cierre y reflexión"]
                ],
                resources: ["Video: inteligencia emocional para principiantes", "Lectura: diario emocional semanal", "Actividad: carta a una emoción difícil"]
            },
            "2": {
                title: "Sanando mi autoestima",
                category: "Bienestar emocional",
                image: "img/uno.jpg",
                description: "Reconstruye tu valor personal, trabaja la seguridad y aprende a dejar de compararte.",
                level: "Inicial",
                duration: "4 semanas",
                learn: ["Detectar pensamientos de comparación", "Reconocer fortalezas personales", "Crear límites sanos", "Practicar afirmaciones realistas"],
                topics: ["Autoestima", "Seguridad", "Límites", "Amor propio"],
                modules: [
                    ["Cómo se forma mi autoestima", "Historia personal", "Creencias heredadas"],
                    ["Comparación y redes", "Pensamientos automáticos", "Cuidado del diálogo interno"],
                    ["Valor personal", "Fortalezas", "Logros invisibles"],
                    ["Límites y seguridad", "Decir no", "Plan de autoestima"]
                ],
                resources: ["Video: autoestima y autocompasión", "Lectura: lista de fortalezas", "Actividad: línea de logros"]
            },
            "3": {
                title: "Ansiedad y sobrepensamiento",
                category: "Bienestar emocional",
                image: "img/seis.jpg",
                description: "Conoce herramientas prácticas para calmar la mente, dejar de repetir escenarios y volver al presente.",
                level: "Inicial",
                duration: "5 semanas",
                learn: ["Identificar detonantes de ansiedad", "Separar hechos de pensamientos", "Aplicar técnicas de respiración", "Crear una rutina de calma"],
                topics: ["Ansiedad", "Sobrepensamiento", "Mindfulness", "Hábitos"],
                modules: [
                    ["Qué es la ansiedad", "Señales del cuerpo", "Mapa de detonantes"],
                    ["Sobrepensamiento", "Hechos vs. historias", "Preguntas para ordenar la mente"],
                    ["Técnicas de calma", "Respiración 4-4-6", "Anclaje con los sentidos"],
                    ["Rutinas protectoras", "Sueño", "Pantallas y descanso"],
                    ["Plan de emergencia emocional", "Red de apoyo", "Seguimiento semanal"]
                ],
                resources: ["Video: respiración para ansiedad", "Lectura: registro de pensamientos", "Actividad: pausa de cinco sentidos"]
            },
            "4": {
                title: "Descubriendo mi propósito",
                category: "Espiritualidad y propósito",
                image: "img/dos.jpg",
                description: "Explora tu identidad, tus valores y la dirección que quieres construir con sentido.",
                level: "Inicial",
                duration: "4 semanas",
                learn: ["Conectar valores con decisiones", "Reconocer dones y cargas personales", "Construir una declaración de propósito", "Definir próximos pasos"],
                topics: ["Propósito", "Identidad", "Valores", "Dirección"],
                modules: [
                    ["Identidad", "Quién soy y qué valoro", "Preguntas guía"],
                    ["Dones y sensibilidad", "Lo que me mueve", "Servicio e impacto"],
                    ["Propósito en proceso", "Temporadas de vida", "Paciencia y dirección"],
                    ["Plan de propósito", "Declaración personal", "Acciones de 30 días"]
                ],
                resources: ["Video: cómo encontrar tu propósito", "Lectura: mapa de valores", "Actividad: declaración de propósito"]
            },
            "5": {
                title: "Fe en tiempos difíciles",
                category: "Espiritualidad y propósito",
                image: "img/siete.jpg",
                description: "Fortalece tu fe, confianza y resiliencia cuando la vida se siente incierta.",
                level: "Inicial",
                duration: "4 semanas",
                learn: ["Sostener esperanza sin negar emociones", "Crear hábitos de oración o reflexión", "Confiar en procesos", "Acompañar crisis con comunidad"],
                topics: ["Fe", "Resiliencia", "Esperanza", "Procesos"],
                modules: [
                    ["Fe y realidad", "Nombrar lo difícil", "Esperanza práctica"],
                    ["Confianza en proceso", "Paciencia", "Historias que sostienen"],
                    ["Rutinas espirituales", "Oración", "Silencio y gratitud"],
                    ["Fe en comunidad", "Pedir ayuda", "Acompañar a otros"]
                ],
                resources: ["Video: resiliencia y fe", "Lectura: diario de gratitud", "Actividad: oración escrita"]
            },
            "6": {
                title: "Sanidad interior",
                category: "Espiritualidad y propósito",
                image: "img/tres.jpg",
                description: "Trabaja heridas emocionales, perdón y formas sanas de soltar el pasado.",
                level: "Intermedio",
                duration: "5 semanas",
                learn: ["Reconocer heridas emocionales", "Entender el perdón como proceso", "Soltar culpas innecesarias", "Crear un plan de cuidado interno"],
                topics: ["Sanidad", "Perdón", "Heridas", "Cuidado emocional"],
                modules: [
                    ["Mirar la herida", "Señales y patrones", "Nombrar sin juzgar"],
                    ["Perdón como proceso", "Mitos del perdón", "Límites y reparación"],
                    ["Soltar el pasado", "Culpa y aprendizaje", "Cartas no enviadas"],
                    ["Reconstruir confianza", "Cuidado interno", "Relaciones seguras"],
                    ["Cierre", "Plan de seguimiento", "Celebrar avances"]
                ],
                resources: ["Video: perdón y sanidad emocional", "Lectura: carta de cierre", "Actividad: límites protectores"]
            },
            "7": {
                title: "Descubre tu talento",
                category: "Talento y creatividad",
                image: "img/cinco.jpg",
                description: "Explora tus habilidades, prueba áreas creativas y empieza a crear sin miedo.",
                level: "Inicial",
                duration: "4 semanas",
                learn: ["Identificar habilidades naturales", "Probar áreas creativas", "Trabajar el miedo a equivocarte", "Crear un primer mini proyecto"],
                topics: ["Talento", "Creatividad", "Exploración", "Proyecto"],
                modules: [
                    ["Qué es talento", "Dones, práctica e interés", "Inventario creativo"],
                    ["Explorar sin presión", "Pruebas pequeñas", "Inspiración visual"],
                    ["Miedo y bloqueo", "Perfeccionismo", "Crear borradores"],
                    ["Mini proyecto", "Compartir avance", "Retroalimentación"]
                ],
                resources: ["Video: desbloquear creatividad", "Lectura: inventario de talentos", "Actividad: reto de 7 días"]
            },
            "8": {
                title: "Crecer en redes siendo creativo",
                category: "Talento y creatividad",
                image: "img/ocho.jpg",
                description: "Aprende a crear contenido, construir marca personal y mostrarte con autenticidad.",
                level: "Inicial",
                duration: "5 semanas",
                learn: ["Definir una voz personal", "Crear pilares de contenido", "Planear publicaciones simples", "Medir sin obsesionarte"],
                topics: ["Redes", "Contenido", "Marca personal", "Creatividad"],
                modules: [
                    ["Identidad digital", "Qué quiero comunicar", "Audiencia real"],
                    ["Pilares de contenido", "Ideas recurrentes", "Formatos simples"],
                    ["Crear sin agotarte", "Calendario ligero", "Reutilizar ideas"],
                    ["Mostrar proceso", "Historias", "Confianza frente a cámara"],
                    ["Aprender de métricas", "Qué observar", "Ajustes sanos"]
                ],
                resources: ["Video: marca personal para creativos", "Lectura: calendario de contenido", "Actividad: 10 ideas de publicaciones"]
            },
            "9": {
                title: "Colaborar y crear en comunidad",
                category: "Talento y creatividad",
                image: "img/cuatro.jpg",
                description: "Desarrolla habilidades para trabajar en equipo, hacer networking y crear proyectos colaborativos.",
                level: "Inicial",
                duration: "4 semanas",
                learn: ["Comunicar ideas con claridad", "Repartir tareas en proyectos", "Dar y recibir retroalimentación", "Crear acuerdos sanos"],
                topics: ["Comunidad", "Colaboración", "Networking", "Proyectos"],
                modules: [
                    ["Crear con otros", "Roles y fortalezas", "Objetivos compartidos"],
                    ["Comunicación de proyecto", "Brief simple", "Acuerdos"],
                    ["Retroalimentación", "Criterios", "Cuidar relaciones"],
                    ["Proyecto colaborativo", "Entrega", "Aprendizajes"]
                ],
                resources: ["Video: trabajo creativo en equipo", "Lectura: plantilla de acuerdos", "Actividad: mapa de colaboradores"]
            },
            "10": {
                title: "Crea con propósito",
                category: "Curso híbrido",
                image: "img/imagen2.png",
                description: "Une talento, espiritualidad e impacto para usar tus dones en algo que ayude a otros.",
                level: "Intermedio",
                duration: "5 semanas",
                learn: ["Elegir una causa o necesidad", "Conectar dones con servicio", "Diseñar un proyecto con impacto", "Presentar una propuesta clara"],
                topics: ["Propósito", "Talento", "Impacto", "Servicio"],
                modules: [
                    ["Dones que sirven", "Qué tengo para aportar", "Necesidades cercanas"],
                    ["Idea con impacto", "Problema y audiencia", "Propuesta de valor"],
                    ["Diseño del proyecto", "Recursos", "Primer alcance"],
                    ["Comunicar propósito", "Historia del proyecto", "Invitación"],
                    ["Presentación final", "Feedback", "Siguiente paso"]
                ],
                resources: ["Video: creatividad con propósito", "Lectura: plantilla de proyecto", "Actividad: pitch de 60 segundos"]
            },
            "11": {
                title: "De talento a ingreso",
                category: "Curso híbrido",
                image: "img/nueve.jpg",
                description: "Convierte lo que sabes hacer en una primera oferta sencilla, honesta y útil.",
                level: "Intermedio",
                duration: "4 semanas",
                learn: ["Reconocer habilidades vendibles", "Crear una oferta inicial", "Hablar de precio con claridad", "Buscar primeros clientes de forma ética"],
                topics: ["Talento", "Ingreso", "Oferta", "Clientes"],
                modules: [
                    ["Mentalidad y valor", "Lo que sé hacer", "Problemas que resuelvo"],
                    ["Oferta simple", "Paquete inicial", "Alcance y límites"],
                    ["Primeros clientes", "Red cercana", "Mensaje de presentación"],
                    ["Entrega y mejora", "Retroalimentación", "Siguiente versión"]
                ],
                resources: ["Video: crear tu primera oferta", "Lectura: plantilla de propuesta", "Actividad: mensaje para cliente ideal"]
            },
            "12": {
                title: "Construyendo una vida con sentido",
                category: "Curso híbrido",
                image: "img/imagen1.png",
                description: "Diseña hábitos, prioridades y una dirección personal alineada con tu propósito.",
                level: "Inicial",
                duration: "5 semanas",
                learn: ["Ordenar prioridades", "Diseñar hábitos sostenibles", "Crear una visión personal", "Medir avances sin castigarte"],
                topics: ["Hábitos", "Propósito", "Dirección", "Vida intencional"],
                modules: [
                    ["Vida con sentido", "Qué importa ahora", "Auditoría personal"],
                    ["Hábitos pequeños", "Diseño de ambiente", "Constancia realista"],
                    ["Dirección personal", "Visión", "Metas por temporada"],
                    ["Cuidado integral", "Descanso", "Relaciones y comunidad"],
                    ["Plan de 90 días", "Seguimiento", "Celebrar progreso"]
                ],
                resources: ["Video: hábitos con propósito", "Lectura: plan de 90 días", "Actividad: tablero de prioridades"]
            }
        };

        const params = new URLSearchParams(window.location.search);
        const courseId = params.get("id") || "1";
        const course = courses[courseId] || courses["1"];

        document.title = course.title + " - Relax Zone";
        document.getElementById("courseCategory").textContent = course.category;
        document.getElementById("courseTitle").textContent = course.title;
        document.getElementById("courseDescription").textContent = course.description;
        document.getElementById("courseImage").src = course.image;
        document.getElementById("courseImage").alt = course.title;
        document.getElementById("courseLevel").textContent = course.level;
        document.getElementById("courseDuration").textContent = course.duration;

        const learnList = document.getElementById("learnList");
        course.learn.forEach(function (item) {
            const div = document.createElement("div");
            div.className = "learn-item";
            div.innerHTML = '<span class="check">✓</span><span>' + item + '</span>';
            learnList.appendChild(div);
        });

        const topicList = document.getElementById("topicList");
        course.topics.forEach(function (topic) {
            const li = document.createElement("li");
            li.textContent = topic;
            topicList.appendChild(li);
        });

        const includesList = document.getElementById("includesList");
        [course.modules.length + " módulos guiados", "Lecturas descargables sugeridas", "Ejercicios de reflexión", "Referencias en video", "Actividades prácticas", "Proyecto o plan final"].forEach(function (item) {
            const li = document.createElement("li");
            li.textContent = "✓ " + item;
            includesList.appendChild(li);
        });

        const moduleList = document.getElementById("moduleList");
        course.modules.forEach(function (module, index) {
            const details = document.createElement("details");
            details.className = "module-item";
            if (index === 0) {
                details.open = true;
            }

            const lessons = module.slice(1).map(function (lesson) {
                return "<li>" + lesson + "</li>";
            }).join("");

            details.innerHTML = "<summary>Módulo " + (index + 1) + ": " + module[0] + "</summary><ul>" + lessons + "</ul>";
            moduleList.appendChild(details);
        });

        const resourceList = document.getElementById("resourceList");
        course.resources.forEach(function (resource) {
            const a = document.createElement("a");
            const query = encodeURIComponent(resource.replace("Video: ", "").replace("Lectura: ", "").replace("Actividad: ", "") + " crecimiento personal");
            a.href = resource.indexOf("Video:") === 0 ? "https://www.youtube.com/results?search_query=" + query : "#";
            a.target = resource.indexOf("Video:") === 0 ? "_blank" : "_self";
            a.textContent = resource;
            resourceList.appendChild(a);
        });

        const quickSearch = document.getElementById("quickSearch");
        quickSearch.addEventListener("input", function () {
            const term = this.value.toLowerCase().trim();
            document.querySelectorAll(".detail-panel, .module-item").forEach(function (item) {
                item.style.display = item.textContent.toLowerCase().includes(term) ? "" : "none";
            });
        });
    </script>
</body>
</html>
