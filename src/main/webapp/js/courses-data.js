// Catalogo de cursos.
// Para cambiar tarjetas: edita title, category, badge, image, hook y description.
// Imagenes: guarda el archivo en /img y pon aqui "img/nombre.jpg".
// Color/categoria: filter usa bienestar, espiritualidad, creatividad o hibrido.
// Detalle del curso: modules cambia temas, teoria, actividades y avance.
window.RelaxZoneCourses = [
    {
        id: "1",
        title: "Gestión emocional: arte para volver a tu centro",
        category: "Bienestar emocional",
        badge: "Bienestar",
        filter: "bienestar",
        image: "img/diez.jpg",
        alt: "Mesa creativa con libreta y café",
        hook: "Usa el arte como espejo emocional para nombrar lo que sientes, bajar la autocrítica y recuperar calma.",
        description: "Una ruta educativa que une regulación emocional, arteterapia, hábitos de calma y comunidad. No busca que el resultado sea bonito: busca que puedas mirar tu mundo interior con seguridad.",
        audience: "Para personas creativas que se sienten solas, bloqueadas o poco validadas, y quieren entender sus emociones sin juzgarse.",
        project: "Crear un diario emocional visual con colores, palabras y símbolos que te ayude a reconocer patrones y pedir apoyo con más claridad.",
        level: "Inicial",
        duration: "4 semanas",
        format: "Arte + reflexión",
        featured: true,
        keywords: "emociones arte arteterapia bienestar cortisol regulación autocompasión impostor",
        dimensions: [
            { title: "Fundamento psicológico", text: "La regulación emocional empieza cuando puedes nombrar lo que pasa dentro. El arte ayuda a externalizar miedo, vergüenza o bloqueo sin confundirlos con tu identidad." },
            { title: "Conexión emocional", text: "Pasas de pensar 'soy el problema' a mirar la emoción como una señal. Compartir el proceso reduce la sensacion de estar solo." },
            { title: "Hábito de bienestar", text: "Crear durante unos minutos, respirar y escribir una frase de cierre entrena una pausa saludable antes de reaccionar." }
        ],
        learn: [
            "Identificar emociones y necesidades detrás del bloqueo creativo.",
            "Usar expresión visual o escrita para sacar el miedo de la cabeza.",
            "Practicar autocompasión y reencuadre de pensamientos.",
            "Crear un ritual breve de calma para antes o después de trabajar en tu talento."
        ],
        topics: ["Arteterapia", "Regulación emocional", "Sindrome del impostor", "Autocompasión"],
        modules: [
            {
                title: "Gestión del impostor",
                theory: "El sindrome del impostor se alimenta de sesgos de autopercepción: minimizas lo que haces bien y exageras tus errores. En vez de discutir con el miedo, este modulo lo convierte en imagen o texto para observarlo desde fuera.",
                lessons: ["Sesgos de autopercepción", "Miedo vs. identidad", "Mapa visual del impostor"],
                practice: "Busca un lugar tranquilo, toma una hoja y dibuja o escribe como se ve tu miedo cuando piensas en mostrar tu talento. Ponle un nombre y al lado escribe: 'esto es una emoción, no mi identidad'.",
                quote: "Tu miedo puede hablar, pero no tiene que dirigir tu obra."
            },
            {
                title: "El arte como catarsis",
                theory: "La expresión libre permite procesar carga emocional sin exigir palabras perfectas. El valor está en liberar y ordenar, no en producir algo estético.",
                lessons: ["Trazo libre", "Color como emoción", "Ritmo y respiración"],
                practice: "Pon un temporizador de 12 minutos. Elige tres colores: uno para tension, uno para esperanza y uno para descanso. Llena la hoja sin borrar nada y al final escribe una frase sobre lo que salio.",
                quote: "No todo lo que sana tiene que verse perfecto."
            },
            {
                title: "Ciencia del descanso creativo",
                theory: "Prácticas creativas y mente-cuerpo pueden apoyar el manejo del estrés. Cuando repites un ritual de calma, tu cerebro aprende nuevas rutas de respuesta: eso conecta con la neuroplasticidad y los hábitos.",
                lessons: ["Cortisol y estrés", "Neuroplasticidad", "Rituales de calma"],
                practice: "Durante tres días, crea 10 minutos antes de dormir: una linea, una palabra, una forma. Después respira lento y registra del 1 al 5 como está tu cuerpo.",
                quote: "Un hábito pequeño puede abrir un espacio grande de paz."
            },
            {
                title: "Reencuadre colectivo",
                theory: "La autocompasión no es conformismo: es hablarte con verdad y cuidado. En comunidad, descubres que otros también dudan, y eso baja la vergüenza.",
                lessons: ["Autocrítica vs. autocompasión", "Frases de reparacion", "Pedir apoyo"],
                practice: "Comparte con alguien de confianza una parte de tu diario y pide solo una respuesta: 'que emoción ves aquí?'. Escucha sin defenderte.",
                quote: "Ser vulnerable con cuidado también es una forma de valentia."
            }
        ],
        resources: [
            { type: "Investigacion", label: "Estudio sobre arte y reduccion de cortisol", url: "https://pubmed.ncbi.nlm.nih.gov/27695158/" },
            { type: "Psicologia", label: "NIMH: psicoterapias y enfoques de tratamiento", url: "https://www.nimh.nih.gov/health/topics/psychotherapies" },
            { type: "Video", label: "Buscar videos sobre arteterapia y emociones", url: "https://www.youtube.com/results?search_query=arteterapia+regulación+emocional" }
        ]
    },
    {
        id: "2",
        title: "Autoestima creativa sin compararte",
        category: "Bienestar emocional",
        badge: "Bienestar",
        filter: "bienestar",
        image: "img/uno.jpg",
        alt: "Espacio tranquilo para escribir",
        hook: "Reconstruye seguridad personal y aprende a mirar tu talento sin castigarte por no estar 'más avanzado'.",
        description: "Curso para trabajar comparación, autoconcepto y diálogo interno. Integra ejercicios de escritura, evidencia real y pequeños actos de cuidado.",
        audience: "Para quienes aman crear pero se frenan por compararse, sentir que no son suficientes o esperar validación externa.",
        project: "Crear una carpeta de evidencia personal: logros, fortalezas, feedback sano y una declaración de valor creativo.",
        level: "Inicial",
        duration: "4 semanas",
        format: "Ejercicios guiados",
        keywords: "autoestima comparación seguridad autocompasión límites talento",
        dimensions: [
            { title: "Fundamento psicológico", text: "El diálogo interno influye en motivacion y conducta. Reencuadrar pensamientos ayuda a ver evidencia completa, no solo errores." },
            { title: "Conexión emocional", text: "Reconocer tus avances reduce la sensacion de no valer y fortalece una identidad menos dependiente de aplausos." },
            { title: "Hábito de bienestar", text: "Registrar fortalezas y límites cada semana crea una práctica estable de cuidado emocional." }
        ],
        learn: [
            "Detectar pensamientos de comparación y perfeccionismo.",
            "Reemplazar insultos internos por frases honestas y útiles.",
            "Reconocer fortalezas sin sentir culpa.",
            "Practicar límites para proteger tu energía creativa."
        ],
        topics: ["Autoestima", "Comparación", "Límites", "Autocompasión"],
        modules: [
            { title: "Mi historia con mi valor", theory: "La autoestima se forma con experiencias, mensajes y relaciones. Mirar esa historia te permite separar lo aprendido de lo verdadero.", lessons: ["Creencias heredadas", "Eventos que marcaron mi seguridad", "Lo que necesito sanar"], practice: "Busca un espacio tranquilo y escribe tres frases que aprendiste sobre ti. Al lado de cada una, escribe una evidencia que la cuestione.", quote: "No eres solo lo que te dijeron; también eres lo que estas reconstruyendo." },
            { title: "Comparación y redes", theory: "La comparación suele enfrentar tu proceso completo contra la vitrina de alguien más. Este modulo entrena una mirada más justa.", lessons: ["Sesgos al compararme", "Curar lo que consumo", "Descanso digital"], practice: "Silencia por 48 horas una cuenta que active comparación. Usa ese tiempo para guardar tres referencias que si te inspiren.", quote: "Inspirarte no debe hacerte desaparecer." },
            { title: "Fortalezas reales", theory: "El cerebro tiende a recordar amenazas o errores. Registrar fortalezas compensa ese sesgo y te da evidencia para seguir.", lessons: ["Logros invisibles", "Habilidades blandas", "Testimonio de otros"], practice: "Pide a dos personas que te digan una fortaleza concreta. Guardala en una nota llamada 'evidencia'.", quote: "Aceptar una fortaleza también es humildad." },
            { title: "Límites que cuidan", theory: "Sin límites, el talento se agota. Un límite sano no rechaza a otros; protege tu energía para crear con presencia.", lessons: ["Decir no", "Pedir espacio", "Cuidar energía"], practice: "Elige un límite pequeño para esta semana: horario, descanso, silencio o una conversación pendiente.", quote: "Cuidar tu energía también cuida tu obra." }
        ],
        resources: [
            { type: "Psicologia", label: "APA: terapia cognitivo conductual", url: "https://www.apa.org/ptsd-guideline/patients-and-families/cognitive-behavioral" },
            { type: "Video", label: "Buscar videos sobre autoestima y autocompasión", url: "https://www.youtube.com/results?search_query=autoestima+autocompasión+psicologia" }
        ]
    },
    {
        id: "3",
        title: "Ansiedad, calma y mindfulness creativo",
        category: "Bienestar emocional",
        badge: "Bienestar",
        filter: "bienestar",
        image: "img/seis.jpg",
        alt: "Agua con luz suave",
        hook: "Herramientas breves para volver al presente cuando la mente corre demasiado.",
        description: "Integra mindfulness, respiración, grounding y registro de pensamientos para bajar el ruido mental y construir rutinas de calma.",
        audience: "Para quienes sobrepiensan, anticipan escenarios o sienten que la ansiedad les roba energía creativa.",
        project: "Diseñar una rutina personal de calma de 15 minutos con respiración, registro breve y una práctica creativa simple.",
        level: "Inicial",
        duration: "5 semanas",
        format: "Herramientas prácticas",
        featured: true,
        keywords: "ansiedad mindfulness respiración grounding hábitos calma sobrepensamiento",
        dimensions: [
            { title: "Fundamento científico", text: "Mindfulness entrena atención al presente. Junto con respiración y registro, ayuda a observar pensamientos sin obedecerlos de inmediato." },
            { title: "Conexión emocional", text: "La ansiedad deja de ser un enemigo invisible y se convierte en información: que necesito, que me activa, que apoyo requiero." },
            { title: "Hábito de bienestar", text: "Rutinas pequeñas y repetidas ensenan al cuerpo a volver a seguridad con más rapidez." }
        ],
        learn: [
            "Reconocer señales fisicas de ansiedad.",
            "Usar respiración y sentidos para regresar al presente.",
            "Separar hechos de predicciones.",
            "Crear un plan de apoyo para días intensos."
        ],
        topics: ["Mindfulness", "Respiración", "Grounding", "Pensamientos"],
        modules: [
            { title: "Entender mi ansiedad", theory: "La ansiedad prepara al cuerpo para protegerse, pero a veces se activa aunque no haya peligro inmediato. Nombrar señales reduce confusion.", lessons: ["Señales del cuerpo", "Detonantes comunes", "Mapa de alerta"], practice: "En un lugar tranquilo, dibuja una silueta y marca donde sientes ansiedad: pecho, garganta, manos, estomago. Escribe que suele activarla.", quote: "Entender tu cuerpo es empezar a cuidarlo." },
            { title: "Volver al presente", theory: "El grounding usa sentidos para anclar la atención. Es simple, pero efectivo para salir del bucle mental y reconocer el aquí y ahora.", lessons: ["5-4-3-2-1 con sentidos", "Respiración cuadrada", "Observacion sin juicio"], practice: "Haz el ejercicio 5-4-3-2-1: mira 5 cosas, toca 4, escucha 3, huele 2 y agradece 1. Hazlo despacio.", quote: "El presente no resuelve todo, pero te devuelve el piso." },
            { title: "Ordenar pensamientos", theory: "No todo pensamiento es una verdad. La terapia cognitiva propone revisar evidencia y construir respuestas más equilibradas.", lessons: ["Hechos vs. predicciones", "Probabilidad real", "Acción pequeña"], practice: "Escribe una preocupacion. Divide la hoja en: hechos, historia que mi mente cuenta, acción pequeña que si puedo hacer.", quote: "Un pensamiento puede visitarte sin quedarse a vivir." },
            { title: "Rutina de calma", theory: "Los hábitos funcionan mejor cuando son claros, pequeños y repetibles. La calma también se entrena con señales y horarios.", lessons: ["Sueno", "Pantallas", "Movimiento suave"], practice: "Diseña una rutina de 15 minutos para cerrar el dia: agua, respiración, una linea de diario y pantalla fuera.", quote: "La paz también necesita agenda." },
            { title: "Red de apoyo", theory: "Pedir ayuda es una habilidad de autocuidado. Tener mensajes preparados facilita actuar cuando estas saturado.", lessons: ["Cuando pedir ayuda", "Mensaje de apoyo", "Señales de alerta"], practice: "Guarda este mensaje: 'Hoy me siento saturado, no necesito soluciones, solo que me escuches 10 minutos'.", quote: "No tienes que regularlo todo en soledad." }
        ],
        resources: [
            { type: "Salud", label: "NCCIH: meditacion y mindfulness", url: "https://www.nccih.nih.gov/health/meditation/overview.htm" },
            { type: "Psicologia", label: "NIMH: psicoterapias", url: "https://www.nimh.nih.gov/health/topics/psychotherapies" },
            { type: "Video", label: "Buscar videos de respiración para ansiedad", url: "https://www.youtube.com/results?search_query=respiración+para+ansiedad+mindfulness" }
        ]
    },
    {
        id: "4",
        title: "Identidad y propósito cristiano",
        category: "Espiritualidad cristiana",
        badge: "Espiritual",
        filter: "espiritualidad",
        image: "img/dos.jpg",
        alt: "Camino con luz suave",
        hook: "Conecta dones, historia y servicio con una fe vivida de forma intencional.",
        description: "Una ruta de reflexión cristiana que integra sentido, identidad, dones y servicio. Usa retos bíblicos, oración escrita y pasos concretos.",
        audience: "Para quienes sienten que tienen talento, pero no dirección, y quieren conectar su vida interior con un propósito de servicio.",
        project: "Redactar una declaración de propósito y un plan de 30 días para servir con un don concreto.",
        level: "Inicial",
        duration: "4 semanas",
        format: "Devocional y práctica",
        featured: true,
        keywords: "propósito cristiano identidad biblia dones servicio ikigai logoterapia perma",
        dimensions: [
            { title: "Fundamento psicológico", text: "La logoterapia habla de la búsqueda de sentido como fuerza motivadora. Aquí se conecta con decisiones, servicio y esperanza." },
            { title: "Conexión espiritual", text: "La identidad se trabaja antes que el rendimiento: quien eres delante de Dios antes de que produzcas algo." },
            { title: "Hábito de propósito", text: "Oración, lectura bíblica y acciones pequeñas convierten la inspiración en dirección diaria." }
        ],
        learn: [
            "Relacionar dones personales con servicio.",
            "Usar una version espiritual del Ikigai: pasion, habilidad, necesidad y llamado.",
            "Aprender historias bíblicas como ejemplos de proceso.",
            "Crear una declaración de propósito concreta."
        ],
        topics: ["Identidad", "Dones", "Servicio", "Propósito"],
        modules: [
            { title: "Tu diseño único", theory: "El propósito no empieza preguntando qué produces, sino quien eres y a quien puedes servir. David fue formado en lo oculto antes de ser visto en público.", lessons: ["Identidad antes que rendimiento", "Salmo 139", "David y el proceso"], practice: "Busca un lugar tranquilo. Lee Salmo 139 y escribe tres frases: fui creado con, me duele ver, puedo servir desde.", quote: "Lo oculto también forma el carácter." },
            { title: "Dones y sensibilidad", theory: "Tus dones y tus cargas pueden apuntar hacia una necesidad. Nehemías sintió dolor por su pueblo y lo transformo en acción organizada.", lessons: ["Lo que me mueve", "Romanos 12", "Nehemías como ejemplo"], practice: "Anota cinco problemas que te importan. Elige uno y escribe una acción pequeña que podrías hacer esta semana.", quote: "La compasión se vuelve propósito cuando da un paso." },
            { title: "Creacion intencional", theory: "Crear con propósito implica pasar del ego al mensaje: qué verdad, consuelo o belleza quiero entregar? La inspiración también se cultiva con presencia.", lessons: ["Crear por mensaje", "Mateo 5:16", "Disciplina espiritual"], practice: "Antes de crear, ora o guarda silencio dos minutos. Luego escribe: qué quiero que alguien reciba con esto?", quote: "Tu talento puede ser una lámpara, no solo una vitrina." },
            { title: "Declaración de propósito", theory: "Una declaración clara une identidad, don, audiencia y acción. No encierra tu vida; te da una brújula para la siguiente temporada.", lessons: ["Brújula personal", "Plan de 30 días", "Servicio cercano"], practice: "Completa: 'En esta temporada quiero usar ___ para servir a ___ mediante ___ durante 30 días'.", quote: "La dirección se confirma caminando." }
        ],
        resources: [
            { type: "Biblia", label: "Salmo 139", url: "https://www.biblegateway.com/passage/?search=Psalm%20139&version=RVR1960" },
            { type: "Biblia", label: "Romanos 12", url: "https://www.biblegateway.com/passage/?search=Romans%2012&version=RVR1960" },
            { type: "Video", label: "Buscar videos sobre propósito cristiano", url: "https://www.youtube.com/results?search_query=propósito+cristiano+dones+servicio" }
        ]
    },
    {
        id: "5",
        title: "Fe en tiempos difíciles",
        category: "Espiritualidad cristiana",
        badge: "Espiritual",
        filter: "espiritualidad",
        image: "img/siete.jpg",
        alt: "Paisaje natural de esperanza",
        hook: "Fortalece esperanza, paciencia y comunidad cuando la vida se siente incierta.",
        description: "Retos bíblicos y prácticas de gratitud, oración y acompañamiento para sostener la fe sin negar emociones reales.",
        audience: "Para quienes atraviesan temporadas de duda, cansancio o espera y necesitan una fe honesta, no fingida.",
        project: "Construir un diario de esperanza de 7 días con gratitud, una promesa bíblica y una acción de apoyo.",
        level: "Inicial",
        duration: "4 semanas",
        format: "Retos bíblicos",
        keywords: "fe esperanza resiliencia gratitud biblia comunidad oración",
        dimensions: [
            { title: "Fundamento emocional", text: "La fe madura no niega el dolor. Permite nombrarlo y buscar apoyo sin perder esperanza." },
            { title: "Historia bíblica", text: "Los salmos de lamento muestran una espiritualidad honesta: dolor, pregunta y confianza pueden convivir." },
            { title: "Hábito espiritual", text: "Gratitud, oración escrita y comunidad son prácticas pequeñas que sostienen el animo en procesos largos." }
        ],
        learn: ["Orar con honestidad", "Practicar gratitud concreta", "Pedir apoyo sin culpa", "Crear recordatorios de esperanza"],
        topics: ["Fe", "Esperanza", "Gratitud", "Comunidad"],
        modules: [
            { title: "Fe honesta", theory: "El Salmo 42 muestra un alma abatida que aún conversa con Dios. La fe no siempre se siente fuerte; a veces solo sigue hablando.", lessons: ["Lamento y esperanza", "Salmo 42", "No negar lo que duele"], practice: "En silencio, escribe: 'Esto duele...', 'Hoy necesito...', 'Aún puedo confiar en...'. No edites la oración.", quote: "Dios no necesita una version maquillada de tu proceso." },
            { title: "Confianza en proceso", theory: "Santiago presenta las pruebas como espacios donde se forma paciencia. No romantiza el dolor, pero reconoce que puede producir madurez.", lessons: ["Santiago 1:2-4", "Paciencia", "Aprender en pruebas"], practice: "Nombra una cosa que esta temporada te está enseñando. Luego escribe una acción pequeña para responder con paciencia.", quote: "La espera también puede formar raíces." },
            { title: "Gratitud que sostiene", theory: "La gratitud entrena la atención hacia lo que aún sostiene. No borra problemas, pero evita que el dolor ocupe toda la pantalla.", lessons: ["Filipenses 4:6-7", "Paz y petición", "Diario de gratitud"], practice: "Agradece 5 cosas hoy: una persona, un lugar, una oportunidad, una lección y un detalle pequeño.", quote: "Agradecer no niega la lucha; recuerda que no todo está perdido." },
            { title: "Fe en comunidad", theory: "Hebreos anima a estimularnos al amor y buenas obras. La fe se fortalece cuando alguien camina contigo.", lessons: ["Pedir ayuda", "Acompañamiento", "Hebreos 10:24-25"], practice: "Manda un mensaje a alguien confiable: 'Estoy en una temporada difícil. Puedes orar por mí o escucharme esta semana?'.", quote: "La comunidad no carga todo por ti, pero te recuerda que no caminas solo." }
        ],
        resources: [
            { type: "Biblia", label: "Salmo 42", url: "https://www.biblegateway.com/passage/?search=Psalm%2042&version=RVR1960" },
            { type: "Biblia", label: "Filipenses 4", url: "https://www.biblegateway.com/passage/?search=Philippians%204&version=RVR1960" },
            { type: "Video", label: "Buscar videos sobre fe en tiempos difíciles", url: "https://www.youtube.com/results?search_query=fe+en+tiempos+difíciles+esperanza" }
        ]
    },
    {
        id: "6",
        title: "Sanidad interior y perdón",
        category: "Espiritualidad cristiana",
        badge: "Espiritual",
        filter: "espiritualidad",
        image: "img/tres.jpg",
        alt: "Flor blanca con fondo azul",
        hook: "Procesa heridas, límites y perdón como camino gradual de sanidad.",
        description: "Curso de reflexión espiritual y cuidado emocional para trabajar heridas sin apresurar procesos ni confundir perdón con falta de límites.",
        audience: "Para quienes quieren sanar heridas desde una mirada cristiana cuidadosa, con verdad, límites y acompañamiento.",
        project: "Escribir una carta de cierre no enviada y un plan de límites seguros para cuidar tu proceso.",
        level: "Intermedio",
        duration: "5 semanas",
        format: "Diario personal",
        keywords: "sanidad interior perdón límites heridas cuidado emocional biblia",
        dimensions: [
            { title: "Fundamento emocional", text: "Sanar requiere reconocer patrones y necesidades. Nombrar una herida no es vivir en el pasado; es dejar de repetirlo sin verlo." },
            { title: "Conexión espiritual", text: "El perdón puede ser un proceso delante de Dios, no una presión para negar daño o quitar límites." },
            { title: "Hábito de cuidado", text: "Diario, oración y límites concretos ayudan a sostener avances sin exponerte a ambientes inseguros." }
        ],
        learn: ["Reconocer heridas sin juzgarte", "Diferenciar perdón, reconciliación y límites", "Practicar cartas no enviadas", "Crear un plan de cuidado interno"],
        topics: ["Perdón", "Heridas", "Límites", "Cuidado"],
        modules: [
            { title: "Mirar la herida", theory: "El Salmo 34 habla de cercania al quebrantado. Mirar una herida con cuidado permite dejar de confundir proteccion con dureza.", lessons: ["Patrones que se repiten", "Nombrar sin culpar", "Salmo 34:18"], practice: "Busca un lugar tranquilo. Escribe: que paso, que senti, que necesite y que necesito ahora. No busques culpables en este ejercicio; busca claridad.", quote: "Lo que nombras con verdad empieza a perder poder secreto." },
            { title: "Perdón como proceso", theory: "Perdón no siempre significa reconciliación inmediata. Puede iniciar como decisión de dejar venganza y seguir sanando con límites.", lessons: ["Mitos del perdón", "Efesios 4:32", "Tiempo y verdad"], practice: "Haz dos columnas: 'lo que puedo soltar' y 'el límite que necesito conservar'. Ora o reflexiona sobre ambas.", quote: "Perdonar no borra límites; puede ayudarte a ponerlos con paz." },
            { title: "Límites sanos", theory: "Un límite sano protege dignidad, descanso y crecimiento. En relaciones heridas, amar también puede requerir distancia segura.", lessons: ["Amar con verdad", "Conversaciónes seguras", "Distancia necesaria"], practice: "Redacta un límite en una frase: 'Para cuidar mi proceso, necesito...'. Ensayalo en voz baja tres veces.", quote: "La paz también se construye con límites." },
            { title: "Reconstruir confianza", theory: "La confianza vuelve por evidencia, no por prisa. Pequeños actos consistentes muestran si un espacio es seguro.", lessons: ["Relaciones seguras", "Pedir apoyo", "Pequeños pasos"], practice: "Identifica una persona segura y una actividad segura. Agenda una conversación breve o un momento de cuidado esta semana.", quote: "No tienes que abrir toda la puerta para probar si hay luz." },
            { title: "Cierre y cuidado", theory: "Cerrar no siempre significa olvidar. A veces significa dejar de cargar solo lo que ya puedes entregar con apoyo y sabiduria.", lessons: ["Plan de seguimiento", "Oración de cierre", "Celebrar avance"], practice: "Escribe una carta que no vas a enviar. Termina con: 'lo que aprendi', 'lo que suelto', 'lo que voy a cuidar'.", quote: "Cerrar una etapa también puede ser una forma de honrar tu vida." }
        ],
        resources: [
            { type: "Biblia", label: "Salmo 34", url: "https://www.biblegateway.com/passage/?search=Psalm%2034&version=RVR1960" },
            { type: "Psicologia", label: "NIMH: psicoterapias", url: "https://www.nimh.nih.gov/health/topics/psychotherapies" },
            { type: "Video", label: "Buscar videos sobre perdón y límites", url: "https://www.youtube.com/results?search_query=perdón+límites+sanidad+interior" }
        ]
    },
    {
        id: "7",
        title: "Descubre tu talento creativo",
        category: "Talento y creatividad",
        badge: "Creatividad",
        filter: "creatividad",
        image: "img/cinco.jpg",
        alt: "Material creativo con luz natural",
        hook: "Explora habilidades y crea un primer proyecto sin esperar perfeccion.",
        description: "Ruta para identificar intereses, vencer bloqueo creativo y probar formatos pequeños hasta descubrir lo que disfrutas construir.",
        audience: "Para quienes sienten que tienen talento, pero no saben por donde empezar o temen no ser suficientemente buenos.",
        project: "Crear un mini proyecto de 7 días: una pieza pequeña diaria en el formato que elijas.",
        level: "Inicial",
        duration: "4 semanas",
        format: "Reto creativo",
        keywords: "talento creatividad flow bloqueo arte práctica habilidades",
        dimensions: [
            { title: "Fundamento psicológico", text: "El estado de flow aparece cuando reto y habilidad se equilibran. Por eso empezamos con retos pequeños, no con obras perfectas." },
            { title: "Conexión emocional", text: "Probar sin presión baja el miedo al rechazo y permite recuperar curiosidad." },
            { title: "Hábito creativo", text: "Crear poco, seguido y con registro te da evidencia de progreso." }
        ],
        learn: ["Reconocer habilidades e intereses repetidos", "Probar ideas en formato pequeño", "Trabajar perfeccionismo", "Compartir un primer avance"],
        topics: ["Flow", "Exploracion", "Bloqueo", "Proyecto"],
        modules: [
            { title: "Inventario de talento", theory: "Tu talento no siempre se siente espectacular; a veces aparece como algo que repites, disfrutas o resuelves con facilidad.", lessons: ["Lo que hago fácil", "Lo que otros me piden", "Lo que me da energía"], practice: "Haz una lista de 20 habilidades, gustos o curiosidades. Marca con una estrella las que te dan energía.", quote: "Tu talento también puede hablar en voz baja." },
            { title: "Explorar sin presión", theory: "El pensamiento lateral conecta ideas que parecen lejanas. Probar formatos distintos ayuda al cerebro a encontrar rutas nuevas.", lessons: ["Bocetos", "Pruebas pequeñas", "Referencias"], practice: "Elige una idea y expresala en tres formatos: frase, dibujo simple y audio de 30 segundos.", quote: "Explorar no es perder tiempo; es abrir posibilidades." },
            { title: "Bloqueo y perfeccionismo", theory: "El perfeccionismo promete calidad, pero muchas veces evita que empieces. Un borrador pequeño reduce amenaza y aumenta acción.", lessons: ["Borrador feo", "Práctica deliberada", "Comparación"], practice: "Crea algo en 20 minutos sin borrar. Al terminar, solo responde: qué parte tiene vida?", quote: "Un borrador existe; una idea perfecta escondida no." },
            { title: "Mini proyecto", theory: "El progreso creativo se consolida cuando compartes, recibes feedback y ajustas. No necesitas exponerlo a todos; empieza con un espacio seguro.", lessons: ["Elegir idea", "Publicar avance", "Recibir feedback"], practice: "Comparte tu prototipo con una persona segura y pregunta: qué mensaje recibes de esto?", quote: "Mostrar un avance también es entrenar confianza." }
        ],
        resources: [
            { type: "Psicologia", label: "APA: creatividad", url: "https://www.apa.org/topics/creativity" },
            { type: "Video", label: "Buscar videos sobre estado de flow", url: "https://www.youtube.com/results?search_query=estado+de+flow+creatividad" }
        ]
    },
    {
        id: "8",
        title: "Crecer en redes sin perderte",
        category: "Talento y creatividad",
        badge: "Creatividad",
        filter: "creatividad",
        image: "img/ocho.jpg",
        alt: "Contenido digital creativo",
        hook: "Crea contenido con intencion, voz personal y una rutina que no te queme.",
        description: "Aprende pilares de contenido, marca personal y planificacion sencilla para mostrar lo que haces de forma clara y auténtica.",
        audience: "Para creativos que quieren compartir su trabajo sin volverse esclavos de likes o comparación.",
        project: "Diseñar un calendario de 7 publicaciones con mensaje, formato y objetivo emocional.",
        level: "Inicial",
        duration: "5 semanas",
        format: "Plantillas",
        keywords: "redes contenido marca personal creatividad hábitos comunidad",
        dimensions: [
            { title: "Fundamento creativo", text: "Una voz clara reduce ansiedad: sabes que dices, a quien sirves y por que lo compartes." },
            { title: "Conexión emocional", text: "Mostrar proceso, no solo resultado, crea cercania y reduce presión por perfeccion." },
            { title: "Hábito sostenible", text: "Un calendario ligero protege energía y hace que crear contenido sea repetible." }
        ],
        learn: ["Definir voz personal", "Crear pilares de contenido", "Planear con energía realista", "Leer métricas sin obsesion"],
        topics: ["Redes", "Contenido", "Marca personal", "Rutina"],
        modules: [
            { title: "Identidad digital", theory: "Tu presencia digital funciona mejor cuando nace de identidad, no de imitación. La claridad protege tu autenticidad.", lessons: ["Qué comunico", "A quien ayudo", "Tono y estilo"], practice: "Escribe tres frases: lo que creo, a quien acompaño, que no quiero fingir.", quote: "Tu voz no necesita gritar para ser clara." },
            { title: "Pilares de contenido", theory: "Los pilares evitan publicar desde la improvisacion total. Te dan estructura sin quitar creatividad.", lessons: ["Educar", "Inspirar", "Mostrar proceso"], practice: "Crea 12 ideas: 4 educativas, 4 personales, 4 de proceso. Guardalas en una nota.", quote: "La estructura puede ser una amiga de la creatividad." },
            { title: "Calendario ligero", theory: "Los hábitos sostenibles consideran energía real. Mejor tres publicaciones constantes que diez desde agotamiento.", lessons: ["Ritmo sostenible", "Reciclar ideas", "Banco de contenido"], practice: "Planea una semana con tres publicaciones y una historia de proceso. Deja un dia sin publicar.", quote: "Consistencia no significa abandonarte." },
            { title: "Mostrar proceso", theory: "La seguridad psicológica aumenta cuando normalizas intentos, errores y aprendizaje. Tu audiencia conecta con camino, no solo vitrina.", lessons: ["Historias", "Detrás de cámara", "Confianza"], practice: "Comparte un antes/después o una reflexión breve: 'esto estoy aprendiendo mientras creo'.", quote: "Tu proceso también puede inspirar." },
            { title: "Mejora sin obsesion", theory: "Las métricas son información, no identidad. Sirven para ajustar el mensaje, no para medir tu valor.", lessons: ["Métricas útiles", "Comentarios", "Ajustes"], practice: "Elige una metrica y una mejora. No revises numeros por 24 horas después de publicar.", quote: "Los numeros orientan; no definen tu valor." }
        ],
        resources: [
            { type: "Herramienta", label: "Meta: recursos para creadores", url: "https://creators.facebook.com/" },
            { type: "Video", label: "Buscar videos sobre marca personal creativa", url: "https://www.youtube.com/results?search_query=marca+personal+para+creativos" }
        ]
    },
    {
        id: "9",
        title: "Ecosistemas de co-creación",
        category: "Talento y creatividad",
        badge: "Creatividad",
        filter: "creatividad",
        image: "img/cuatro.jpg",
        alt: "Personas colaborando",
        hook: "Convierte ideas sueltas en proyectos compartidos con roles, acuerdos y confianza.",
        description: "Curso para estructurar colaboraciones creativas usando acuerdos simples, feedback sano y metodologías ligeras de proyecto.",
        audience: "Para personas que quieren crear con otros, pero necesitan orden, contactos y seguridad para recibir crítica.",
        project: "Armar un brief colaborativo con roles, fechas, acuerdos y una primera entrega pequeña.",
        level: "Inicial",
        duration: "4 semanas",
        format: "Proyecto grupal",
        keywords: "co-creación comunidad colaboración equipo feedback seguridad psicológica",
        dimensions: [
            { title: "Fundamento grupal", text: "La seguridad psicológica permite proponer ideas sin miedo excesivo al ridiculo. Es base para co-crear." },
            { title: "Conexión emocional", text: "Los acuerdos reducen ansiedad y cuidan relaciones. Nadie tiene que adivinar expectativas." },
            { title: "Hábito de proyecto", text: "Brief, roles y revisiones pequeñas hacen que la colaboración avance sin caos." }
        ],
        learn: ["Explicar una idea con claridad", "Repartir roles y tiempos", "Dar feedback sin herir", "Crear acuerdos de colaboración"],
        topics: ["Colaboración", "Feedback", "Roles", "Proyecto"],
        modules: [
            { title: "Idea compartida", theory: "Una idea se vuelve proyecto cuando define problema, audiencia y resultado. La claridad invita a otros a sumarse.", lessons: ["Problema", "Audiencia", "Resultado esperado"], practice: "Escribe un brief de cinco lineas: que haremos, para quien, por que importa, que entregamos y cuando.", quote: "Una idea clara abre puertas." },
            { title: "Roles y acuerdos", theory: "Los roles no limitan; cuidan energía. Cada persona necesita saber que aporta y que espera el grupo.", lessons: ["Fortalezas", "Responsables", "Fechas"], practice: "Crea una tabla: tarea, responsable, fecha, apoyo necesario. Compartela con tu equipo.", quote: "La colaboración sana también necesita bordes." },
            { title: "Feedback sano", theory: "El feedback útil habla del trabajo y del objetivo, no ataca la identidad. Eso sostiene seguridad psicológica.", lessons: ["Criterios", "Preguntas", "Cuidar relaciones"], practice: "Pide feedback con una pregunta concreta: qué parte comunica mejor el mensaje? qué parte confunde?", quote: "La crítica que cuida ayuda a crecer." },
            { title: "Entrega y cierre", theory: "Cerrar un proyecto implica reconocer aprendizajes, dar credito y definir próximo paso. Eso fortalece comunidad real.", lessons: ["Aprendizajes", "Credito", "Siguiente paso"], practice: "Al terminar, cada persona responde: que aporte, que aprendi y que mejoraria.", quote: "Crear juntos también forma carácter." }
        ],
        resources: [
            { type: "Metodo", label: "Google: Design Sprint Kit", url: "https://designsprintkit.withgoogle.com/" },
            { type: "Video", label: "Buscar videos sobre feedback creativo", url: "https://www.youtube.com/results?search_query=feedback+creativo+trabajo+en+equipo" }
        ]
    },
    {
        id: "10",
        title: "Crea con propósito",
        category: "Ruta hibrida",
        badge: "Hibrido",
        filter: "hibrido",
        image: "img/imagen2.png",
        alt: "Ilustracion de proyecto creativo",
        hook: "Une talento, fe y servicio para crear algo que ayude a otras personas.",
        description: "Diseña un proyecto pequeño con impacto: elige una necesidad, conecta tus dones y presenta una propuesta clara.",
        audience: "Para quienes quieren que su creatividad tenga mensaje, servicio e impacto más alla de verse bien.",
        project: "Presentar un pitch de 60 segundos de un proyecto con propósito y una primera prueba de una semana.",
        level: "Intermedio",
        duration: "5 semanas",
        format: "Proyecto final",
        featured: true,
        keywords: "propósito impacto servicio talento proyecto espiritualidad creatividad",
        dimensions: [
            { title: "Fundamento de sentido", text: "El bienestar profundo crece cuando conectas habilidades con significado, relaciones y logros reales." },
            { title: "Conexión espiritual", text: "Crear con propósito mueve el centro del ego hacia el servicio: que bien puedo entregar?" },
            { title: "Hábito de impacto", text: "Probar pequeño permite servir pronto, aprender y mejorar sin paralizarte." }
        ],
        learn: ["Elegir una necesidad cercana", "Conectar talento con servicio", "Diseñar un proyecto posible", "Presentar una propuesta de impacto"],
        topics: ["Impacto", "Servicio", "Proyecto", "Propósito"],
        modules: [
            { title: "Dones que sirven", theory: "Tus dones encuentran dirección cuando se conectan con una necesidad real. 1 Pedro 4 habla de administrar dones para servir.", lessons: ["Lo que tengo", "A quien puedo ayudar", "Necesidades cercanas"], practice: "Elige una persona o grupo al que quieres servir. Escribe qué necesitan y qué don tuyo podría aportar.", quote: "Un don se fortalece cuando se entrega con amor." },
            { title: "Idea con impacto", theory: "Un proyecto con impacto empieza pequeño: problema claro, audiencia clara y una solucion que puedas probar.", lessons: ["Problema", "Solucion", "Alcance realista"], practice: "Define una prueba de una semana. Que haras, para quien y como sabras si ayudo?", quote: "Lo pequeño también puede ser significativo." },
            { title: "Diseño del proyecto", theory: "La creatividad necesita límites: recursos, tiempo y alcance. Los límites convierten inspiración en acción.", lessons: ["Recursos", "Tiempo", "Primer prototipo"], practice: "Haz una lista de recursos disponibles: personas, materiales, tiempo, habilidades. Diseña con eso, no con lo ideal.", quote: "La claridad vuelve caminable el propósito." },
            { title: "Comunicar propósito", theory: "Una historia clara ayuda a otros a entender por que existe tu proyecto. No vendas humo: comunica necesidad, proceso y esperanza.", lessons: ["Historia", "Invitacion", "Claridad"], practice: "Redacta un pitch de 60 segundos: problema, idea, a quién ayuda, cómo pueden sumarse.", quote: "Cuando el mensaje es claro, el propósito se comparte." },
            { title: "Presentación final", theory: "El feedback convierte una idea personal en una propuesta más útil para otros.", lessons: ["Feedback", "Ajuste", "Siguiente paso"], practice: "Presenta tu idea a una persona. Pregunta: qué entiendes, qué te emociona, qué falta?", quote: "El impacto crece cuando escuchas." }
        ],
        resources: [
            { type: "Biblia", label: "1 Pedro 4", url: "https://www.biblegateway.com/passage/?search=1%20Peter%204&version=RVR1960" },
            { type: "Video", label: "Buscar videos sobre proyectos con propósito", url: "https://www.youtube.com/results?search_query=proyecto+con+propósito+creatividad" }
        ]
    },
    {
        id: "11",
        title: "Monetizacion ética y sostenible",
        category: "Ruta hibrida",
        badge: "Hibrido",
        filter: "hibrido",
        image: "img/nueve.jpg",
        alt: "Espacio de trabajo creativo",
        hook: "Convierte lo que sabes hacer en una oferta clara sin perder tus valores.",
        description: "Desmitifica el mito del artista hambriento y aprende valor percibido, precio, alcance y comunicación honesta.",
        audience: "Para creativos que quieren ganar dinero con su talento, pero temen vender, cobrar o parecer interesados.",
        project: "Construir una primera oferta sencilla con problema, transformación, entregables, precio y mensaje de venta honesto.",
        level: "Intermedio",
        duration: "4 semanas",
        format: "Oferta inicial",
        keywords: "monetizacion ética talento ingreso oferta valor clientes emprendimiento",
        dimensions: [
            { title: "Fundamento económico", text: "El valor no se calcula solo por horas; también por la transformación, claridad y alivio que generas." },
            { title: "Conexión emocional", text: "Cobrar con ética requiere seguridad: no estas mendigando, estas proponiendo una ayuda concreta." },
            { title: "Hábito sostenible", text: "Definir alcance y límites evita prometer de más y protege tu energía." }
        ],
        learn: ["Identificar habilidades con valor", "Crear una oferta inicial", "Definir alcance, precio y límites", "Buscar primeros clientes de forma honesta"],
        topics: ["Valor", "Oferta", "Clientes", "Ética"],
        modules: [
            { title: "Lo que se vender", theory: "La economia creativa monetiza valor, no solo productos. Empieza por entender que problema resuelves o que experiencia entregas.", lessons: ["Habilidades", "Problemas", "Resultados"], practice: "Une una habilidad con un problema: 'ayudo a ___ a lograr ___ mediante ___'.", quote: "Tu talento puede ser bello y útil a la vez." },
            { title: "Valor percibido", theory: "El precio comunica posicionamiento, claridad y transformación. No se trata de inflar, sino de explicar bien el valor.", lessons: ["Transformación", "Evidencia", "Precio base"], practice: "Escribe tres beneficios de tu oferta: emocional, práctico y creativo.", quote: "Cobrar claro también es cuidar al cliente." },
            { title: "Oferta simple", theory: "Una oferta sana tiene entregables, límites y expectativas. Eso evita frustracion y te hace profesional.", lessons: ["Promesa", "Entregables", "Límites"], practice: "Redacta tu oferta en una frase y agrega: incluye, no incluye, tiempo de entrega.", quote: "Los límites hacen confiable tu servicio." },
            { title: "Primeros clientes", theory: "Vender de forma ética es invitar, no presionar. Tu mensaje debe ser claro, humano y respetuoso.", lessons: ["Red cercana", "Mensaje claro", "Seguimiento"], practice: "Escribe un mensaje para 3 personas: qué ofreces, a quién ayuda, cómo pueden pedir información.", quote: "La venta honesta no manipula; comunica." }
        ],
        resources: [
            { type: "Herramienta", label: "Google Digital Garage", url: "https://learndigital.withgoogle.com/digitalgarage" },
            { type: "Video", label: "Buscar videos sobre precio para creativos", url: "https://www.youtube.com/results?search_query=precio+para+servicios+creativos" }
        ]
    },
    {
        id: "12",
        title: "Vida con sentido: plan de 90 días",
        category: "Ruta hibrida",
        badge: "Hibrido",
        filter: "hibrido",
        image: "img/imagen1.png",
        alt: "Plan personal con notas",
        hook: "Ordena hábitos, prioridades y dirección para vivir con más intencion.",
        description: "Ruta de integracion entre bienestar, espiritualidad y creatividad para construir un plan personal sostenible.",
        audience: "Para quienes quieren unir salud emocional, fe/propósito y talento en una rutina realista.",
        project: "Crear un plan de 90 días con tres prioridades, hábitos pequeños y una revision semanal.",
        level: "Inicial",
        duration: "5 semanas",
        format: "Plan personal",
        keywords: "hábitos propósito bienestar plan 90 días espiritualidad creatividad",
        dimensions: [
            { title: "Fundamento científico", text: "Los hábitos se sostienen mejor cuando son pequeños, medibles y conectados con una señal concreta." },
            { title: "Conexión emocional", text: "Una vida con sentido no intenta hacerlo todo: elige lo importante para esta temporada." },
            { title: "Despertar de propósito", text: "Tu talento necesita espacio en la agenda para convertirse en fruto, no solo en deseo." }
        ],
        learn: ["Elegir prioridades por temporada", "Diseñar hábitos sostenibles", "Medir progreso sin castigarte", "Crear un plan de 90 días"],
        topics: ["Hábitos", "Prioridades", "Propósito", "Plan"],
        modules: [
            { title: "Auditoría personal", theory: "Antes de cambiar tu vida, necesitas verla con honestidad: energía, relaciones, descanso, fe y creatividad.", lessons: ["Energía", "Relaciones", "Tiempo"], practice: "Califica del 1 al 5 tus áreas principales. Elige una que necesita cuidado urgente y una que ya tiene vida.", quote: "La claridad es una forma de descanso." },
            { title: "Hábitos pequeños", theory: "Un hábito pequeño reduce resistencia. La constancia nace más fácil cuando la acción tarda menos de cinco minutos.", lessons: ["Señal", "Acción", "Recompensa"], practice: "Diseña un hábito de 3 minutos: después de ___ hare ___ y celebrare con ___.", quote: "Lo pequeño repetido también transforma." },
            { title: "Prioridades", theory: "Elegir prioridades implica renunciar a ruido. No todo merece tu energía en la misma temporada.", lessons: ["Decir si", "Decir no", "Temporadas"], practice: "Elige tres prioridades para este mes y escribe que vas a pausar para protegerlas.", quote: "Una vida con sentido también sabe decir no." },
            { title: "Cuidado integral", theory: "Bienestar, espiritualidad y creatividad se alimentan entre sí. Si descuidas el cuerpo o el alma, el talento se resiente.", lessons: ["Descanso", "Fe", "Creatividad"], practice: "Agenda tres bloques esta semana: descanso real, reflexión/oración y creatividad sin presión.", quote: "Tu talento vive dentro de una persona, no de una máquina." },
            { title: "Plan de 90 días", theory: "Un plan útil tiene dirección y revision. No es una sentencia; es una brújula ajustable.", lessons: ["Meta", "Semana tipo", "Revision"], practice: "Escribe tres metas pequeñas de 90 días. Para cada una define una acción semanal y un dia de revision.", quote: "La dirección mejora cuando revisas el camino." }
        ],
        resources: [
            { type: "Salud", label: "NCCIH: prácticas mente-cuerpo", url: "https://www.nccih.nih.gov/health/mind-and-body-practices" },
            { type: "Video", label: "Buscar videos sobre hábitos y propósito", url: "https://www.youtube.com/results?search_query=hábitos+propósito+plan+90+días" }
        ]
    }
];
