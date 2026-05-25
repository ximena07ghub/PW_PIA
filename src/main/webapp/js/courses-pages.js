(function () {
    const baseStorageKey = "relaxzone.courseProgress.v2";
    const progressEndpoint = "CursoProgresoServlet";
    let remoteStore = null;
    let remoteActivity = [];

    function storageKey() {
        const user = String(window.RelaxZoneUser || "guest").trim() || "guest";
        return baseStorageKey + "." + user;
    }

    function deletedStorageKey() {
        return storageKey() + ".deleted";
    }

    function courses() {
        return window.RelaxZoneCourses || [];
    }

    function byId(id) {
        return courses().find(function (course) {
            return course.id === String(id);
        }) || courses()[0];
    }

    function normalize(text) {
        return String(text || "")
            .toLowerCase()
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "");
    }

    function relatedTerms(term) {
        const normalized = normalize(term);
        const groups = [
            ["ansiedad", "estres", "calma", "respiracion", "mindfulness", "grounding", "sobrepensamiento"],
            ["autoestima", "seguridad", "comparacion", "valor", "autocompasion", "limites"],
            ["proposito", "sentido", "identidad", "dones", "servicio", "fe", "cristiano", "espiritualidad"],
            ["creatividad", "talento", "arte", "contenido", "redes", "marca", "proyecto"],
            ["comunidad", "colaboracion", "equipo", "feedback", "co-creacion", "crear juntos"],
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

    function readStore() {
        try {
            return JSON.parse(localStorage.getItem(storageKey())) || {};
        } catch (error) {
            return {};
        }
    }

    function writeStore(store) {
        localStorage.setItem(storageKey(), JSON.stringify(store));
    }

    // Texto buscable: quita acentos y permite palabras relacionadas.

    function readDeletedCourses() {
        try {
            return JSON.parse(localStorage.getItem(deletedStorageKey())) || {};
        } catch (error) {
            return {};
        }
    }

    function writeDeletedCourses(store) {
        localStorage.setItem(deletedStorageKey(), JSON.stringify(store));
    }

    function forgetDeletedCourse(courseId) {
        const deleted = readDeletedCourses();
        delete deleted[String(courseId)];
        writeDeletedCourses(deleted);
    }

    function completedFromRemote(value) {
        return String(value || "")
            .split(",")
            .map(function (item) { return Number(item); })
            .filter(function (item) { return !Number.isNaN(item); });
    }

    function mergeRemoteProgress(data) {
        remoteStore = {};
        remoteActivity = Array.isArray(data.activity) ? data.activity : [];
        const deleted = readDeletedCourses();

        (Array.isArray(data.courses) ? data.courses : []).forEach(function (item) {
            if (deleted[item.id]) return;
            remoteStore[item.id] = {
                enrolled: true,
                completedModules: completedFromRemote(item.completedList),
                percent: Number(item.percent) || 0,
                totalModules: Number(item.totalModules) || 0,
                completedCount: Number(item.completedModules) || 0
            };
        });

        const local = readStore();
        Object.keys(deleted).forEach(function (courseId) {
            delete local[courseId];
        });

        Object.keys(remoteStore).forEach(function (courseId) {
            const course = byId(courseId);
            const remote = remoteStore[courseId];
            const localSaved = local[courseId] || {};
            local[courseId] = {
                enrolled: true,
                completedModules: remote.completedModules.length ? remote.completedModules : localSaved.completedModules || [],
                startedAt: localSaved.startedAt || new Date().toISOString()
            };
            if (!local[courseId].completedModules.length && remote.completedCount > 0) {
                local[courseId].completedModules = course.modules
                    .map(function (_module, index) { return index; })
                    .slice(0, remote.completedCount);
            }
        });
        writeStore(local);
    }

    function loadServerProgress(callback) {
        if (!window.RelaxZoneLoggedIn || !window.fetch) {
            if (callback) callback();
            return;
        }

        fetch(progressEndpoint, { credentials: "same-origin" })
            .then(function (response) {
                if (!response.ok) throw new Error("progress");
                return response.json();
            })
            .then(function (data) {
                mergeRemoteProgress(data);
                if (callback) callback();
            })
            .catch(function () {
                if (callback) callback();
            });
    }

    function saveServerProgress(course, progress, action, activityText) {
        if (!window.RelaxZoneLoggedIn || !window.fetch) return;

        const body = new URLSearchParams();
        body.set("action", action || "update");
        body.set("courseId", course.id);
        body.set("title", course.title);
        body.set("category", course.category);
        body.set("totalModules", String(course.modules.length));
        body.set("completedModules", String(progress.completedModules.length));
        body.set("completedList", progress.completedModules.join(","));
        body.set("percent", String(progress.percent));
        body.set("activityType", action === "enroll" ? "Curso" : "Avance");
        body.set("activityText", activityText || "");

        fetch(progressEndpoint, {
            method: "POST",
            credentials: "same-origin",
            headers: { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" },
            body: body.toString()
        }).catch(function () {});
    }

    function postActivity(course, type, description) {
        if (!window.RelaxZoneLoggedIn || !window.fetch) return;

        const body = new URLSearchParams();
        body.set("action", "activity");
        body.set("courseId", course ? course.id : "");
        body.set("activityType", type);
        body.set("activityText", description);

        fetch(progressEndpoint, {
            method: "POST",
            credentials: "same-origin",
            headers: { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" },
            body: body.toString()
        }).catch(function () {});
    }

    function getProgress(courseId) {
        const course = byId(courseId);
        const store = readStore();
        const saved = store[course.id] || {};
        const completed = Array.isArray(saved.completedModules) ? saved.completedModules : [];
        const uniqueCompleted = completed.filter(function (value, index, array) {
            return array.indexOf(value) === index && value >= 0 && value < course.modules.length;
        });
        const percent = course.modules.length ? Math.round((uniqueCompleted.length / course.modules.length) * 100) : 0;

        return {
            enrolled: Boolean(saved.enrolled || uniqueCompleted.length),
            completedModules: uniqueCompleted,
            percent: percent,
            nextModule: Math.min(uniqueCompleted.length + 1, course.modules.length)
        };
    }

    function enroll(courseId) {
        const course = byId(courseId);
        const store = readStore();
        const saved = store[course.id] || {};
        forgetDeletedCourse(course.id);
        store[course.id] = {
            enrolled: true,
            completedModules: Array.isArray(saved.completedModules) ? saved.completedModules : [],
            startedAt: saved.startedAt || new Date().toISOString()
        };
        writeStore(store);
        const progress = getProgress(course.id);
        saveServerProgress(course, progress, "enroll", "Agregaste " + course.title + " a tu ruta.");
        return progress;
    }

    function toggleModule(courseId, moduleIndex) {
        const course = byId(courseId);
        const store = readStore();
        const saved = store[course.id] || { enrolled: true, completedModules: [] };
        const completed = Array.isArray(saved.completedModules) ? saved.completedModules.slice() : [];
        const current = Number(moduleIndex);
        const found = completed.indexOf(current);
        forgetDeletedCourse(course.id);

        if (found >= 0) {
            completed.splice(found, 1);
        } else {
            completed.push(current);
        }

        completed.sort(function (a, b) { return a - b; });
        store[course.id] = {
            enrolled: true,
            completedModules: completed,
            startedAt: saved.startedAt || new Date().toISOString(),
            updatedAt: new Date().toISOString()
        };
        writeStore(store);
        const progress = getProgress(course.id);
        const moduleCompleted = progress.completedModules.indexOf(current) >= 0;
        const activity = progress.percent === 100 && moduleCompleted
            ? "Completaste el curso " + course.title + "."
            : moduleCompleted
                ? "Completaste un modulo de " + course.title + "."
                : "Actualizaste tu avance en " + course.title + ".";
        saveServerProgress(course, progress, "update", activity);
        return progress;
    }

    function removeCourse(courseId) {
        const course = byId(courseId);
        const store = readStore();
        const deleted = readDeletedCourses();
        delete store[course.id];
        deleted[course.id] = true;
        writeStore(store);
        writeDeletedCourses(deleted);

        if (window.RelaxZoneLoggedIn && window.fetch) {
            const body = new URLSearchParams();
            body.set("action", "deleteCourse");
            body.set("courseId", course.id);
            fetch(progressEndpoint, {
                method: "POST",
                credentials: "same-origin",
                headers: { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" },
                body: body.toString()
            }).catch(function () {});
        }
    }

    function text(tag, className, value) {
        const element = document.createElement(tag);
        if (className) element.className = className;
        element.textContent = value;
        return element;
    }

    function courseHref(course) {
        return "curso_detalle1.jsp?id=" + encodeURIComponent(course.id);
    }

    function renderCourseCard(course, className) {
        const card = document.createElement("a");
        card.className = className || "course-card";
        card.href = courseHref(course);
        card.dataset.course = normalize([
            course.title,
            course.category,
            course.badge,
            course.keywords,
            course.hook,
            course.description,
            course.audience,
            course.project,
            (course.topics || []).join(" "),
            (course.learn || []).join(" ")
        ].join(" "));
        card.dataset.category = course.filter;

        const thumb = document.createElement("div");
        thumb.className = className === "catalog-card" ? "catalog-image" : "course-thumb";

        const image = document.createElement("img");
        image.src = course.image;
        image.alt = course.alt || course.title;
        thumb.appendChild(image);

        if (className !== "catalog-card") {
            thumb.appendChild(text("span", "course-badge", course.badge));
        }

        const body = document.createElement("div");
        body.className = className === "catalog-card" ? "catalog-card-body" : "course-body";

        if (className === "catalog-card") {
            body.appendChild(text("span", "", course.badge));
            body.appendChild(text("h2", "", course.title));
        } else {
            body.appendChild(text("h3", "", course.title));
        }

        body.appendChild(text("p", "", course.hook));

        const meta = document.createElement("div");
        meta.className = "course-meta";
        meta.appendChild(text("span", "", course.modules.length + " m\u00f3dulos"));
        meta.appendChild(text("span", "", course.format));
        body.appendChild(meta);

        card.appendChild(thumb);
        card.appendChild(body);
        return card;
    }

    function renderFeaturedCard(course) {
        const card = document.createElement("a");
        card.className = "featured-card";
        card.href = courseHref(course);

        const image = document.createElement("img");
        image.src = course.image;
        image.alt = course.alt || course.title;

        const label = document.createElement("div");
        label.appendChild(document.createTextNode(course.title));
        label.appendChild(text("span", "", "\u2192"));

        card.appendChild(image);
        card.appendChild(label);
        return card;
    }

    function renderProgressCard(course) {
        const progress = getProgress(course.id);
        const card = document.createElement("article");
        card.className = "progress-card" + (progress.percent === 100 ? " is-complete" : "");

        const ring = document.createElement("div");
        ring.className = "progress-ring";
        ring.style.setProperty("--value", progress.percent + "%");
        ring.appendChild(text("span", "", progress.percent + "%"));

        const copy = document.createElement("div");
        copy.appendChild(text("h3", "", course.title));
        const status = progress.percent === 100
            ? "Curso finalizado. Logro guardado en tu perfil."
            : "Siguiente m\u00f3dulo: " + progress.nextModule + " de " + course.modules.length + ".";
        copy.appendChild(text("p", "", status));

        if (progress.percent === 100) {
            copy.appendChild(text("span", "progress-achievement", "Curso finalizado"));
        }

        const actions = document.createElement("div");
        actions.className = "progress-actions";

        const link = document.createElement("a");
        link.href = courseHref(course);
        link.textContent = progress.percent === 100 ? "Repasar" : "Continuar";

        const remove = document.createElement("button");
        remove.type = "button";
        remove.textContent = "Eliminar";
        remove.addEventListener("click", function () {
            removeCourse(course.id);
            initDashboard();
        });

        actions.appendChild(link);
        if (progress.percent < 100) {
            actions.appendChild(remove);
        }
        copy.appendChild(actions);

        card.appendChild(ring);
        card.appendChild(copy);
        return card;
    }

    function renderRouteOptions() {
        const routeSteps = document.getElementById("routeSteps");
        if (!routeSteps) return;

        const profileText = normalize(window.RelaxZoneProfileText || "");
        const deleted = readDeletedCourses();
        const enrolledIds = courses().filter(function (course) {
            return getProgress(course.id).enrolled;
        }).map(function (course) { return course.id; });

        const baseOrder = ["bienestar", "espiritualidad", "creatividad", "hibrido"];
        const enrolled = enrolledIds.map(byId);
        const nextByProcess = baseOrder
            .map(function (filter) {
                return courses().find(function (course) {
                    return course.filter === filter && enrolledIds.indexOf(course.id) < 0 && !deleted[course.id];
                });
            })
            .filter(Boolean);

        const scored = courses().filter(function (course) {
            return !deleted[course.id];
        }).map(function (course) {
            const haystack = normalize([course.title, course.category, course.keywords, course.hook, course.description, (course.topics || []).join(" ")].join(" "));
            let score = enrolledIds.indexOf(course.id) >= 0 ? 8 : 0;
            relatedTerms(profileText).forEach(function (term) {
                if (haystack.indexOf(term) >= 0) score += 2;
            });
            if (course.featured) score += 1;
            return { course: course, score: score };
        }).sort(function (a, b) {
            return b.score - a.score;
        }).map(function (item) { return item.course; });

        const route = enrolled.concat(nextByProcess).concat(scored).filter(function (course, index, list) {
            return list.findIndex(function (item) { return item.id === course.id; }) === index;
        }).slice(0, 4);

        routeSteps.innerHTML = "";
        route.forEach(function (course, index) {
            const progress = getProgress(course.id);
            const step = document.createElement("a");
            step.className = "route-step";
            step.href = courseHref(course);
            step.style.textDecoration = "none";
            step.appendChild(text("span", "route-number", String(index + 1)));

            const copy = document.createElement("div");
            copy.appendChild(text("strong", "", course.title));
            copy.appendChild(text("span", "", progress.enrolled
                ? progress.percent + "% completado. Continua con el siguiente modulo."
                : course.hook));
            step.appendChild(copy);
            routeSteps.appendChild(step);
        });
    }

    function filterCards(container, searchValue, activeFilter) {
        const terms = relatedTerms(searchValue);
        const cards = container.querySelectorAll("[data-course], .catalog-card");
        let visible = 0;

        cards.forEach(function (card) {
            const categoryMatch = !activeFilter || activeFilter === "todas" || card.dataset.category === activeFilter;
            const searchableText = normalize(card.textContent + " " + (card.dataset.course || "") + " " + (card.dataset.keywords || ""));
            const textMatch = !terms.length || terms.some(function (term) {
                return searchableText.indexOf(term) >= 0;
            });
            const show = categoryMatch && textMatch;
            card.style.display = show ? "" : "none";
            if (show) visible += 1;
        });

        return visible;
    }

    function initDashboard() {
        const progressGrid = document.getElementById("progressGrid");
        const courseGrid = document.getElementById("courseGrid");
        const featuredGrid = document.getElementById("featuredGrid");
        const searchInput = document.getElementById("courseSearch");
        const emptyProgress = document.getElementById("emptyProgress");
        const totalCourses = document.getElementById("totalCourses");
        const activeCourses = document.getElementById("activeCourses");

        loadServerProgress(render);

        function render() {
            if (totalCourses) totalCourses.textContent = courses().length;

            if (progressGrid) {
                const enrolled = courses().filter(function (course) {
                return getProgress(course.id).enrolled;
                });

                progressGrid.innerHTML = "";
                enrolled.slice(0, 6).forEach(function (course) {
                    progressGrid.appendChild(renderProgressCard(course));
                });

                if (activeCourses) activeCourses.textContent = enrolled.length;
                if (emptyProgress) emptyProgress.style.display = enrolled.length ? "none" : "block";
            }

            if (featuredGrid) {
                featuredGrid.innerHTML = "";

                const copy = document.createElement("div");
                copy.className = "featured-copy";
                copy.appendChild(text("h2", "", "Escoge una ruta y mira el desglose completo"));
                copy.appendChild(text("p", "", "Cada curso tiene modulos, tecnicas, retos, recursos externos y progreso guardado en tu cuenta."));
                featuredGrid.appendChild(copy);

                courses().filter(function (course) { return course.featured; }).slice(0, 3).forEach(function (course) {
                    featuredGrid.appendChild(renderFeaturedCard(course));
                });
            }

            if (courseGrid) {
                courseGrid.innerHTML = "";
                courses().forEach(function (course) {
                    courseGrid.appendChild(renderCourseCard(course, "course-card"));
                });
            }

            if (searchInput && courseGrid) {
                searchInput.addEventListener("input", function () {
                    filterCards(courseGrid, searchInput.value, "todas");
                });
            }

            renderRouteOptions();
        }
    }

    function initHome() {
        const track = document.getElementById("coursesTrack");
        if (!track) return;

        track.innerHTML = "";

        function addHomeCard(course, duplicate, index) {
            const card = document.createElement("a");
            card.className = "home-course-card" + (duplicate ? " duplicate" : "") + (!duplicate && index === 0 ? " is-active" : "");
            card.href = courseHref(course);
            card.dataset.category = course.filter;
            card.dataset.keywords = [
                course.keywords,
                course.title,
                course.category,
                course.hook,
                course.description,
                (course.topics || []).join(" "),
                (course.learn || []).join(" ")
            ].join(" ");

            const imageWrap = document.createElement("div");
            imageWrap.className = "card-img-container";
            const image = document.createElement("img");
            image.src = course.image;
            image.alt = course.alt || course.title;
            imageWrap.appendChild(image);

            const body = document.createElement("div");
            body.className = "card-contenido";
            body.appendChild(text("span", "tag", course.badge));
            body.appendChild(text("h3", "", course.title));
            body.appendChild(text("p", "", course.hook));

            const meta = document.createElement("div");
            meta.className = "card-meta";
            meta.appendChild(text("span", "", course.modules.length + " m\u00f3dulos"));
            meta.appendChild(text("span", "", "Ver curso"));
            body.appendChild(meta);

            card.appendChild(imageWrap);
            card.appendChild(body);
            track.appendChild(card);
        }

        courses().forEach(function (course, index) {
            addHomeCard(course, false, index);
        });

        courses().forEach(function (course, index) {
            addHomeCard(course, true, index);
        });
    }

    function initCatalog() {
        const grid = document.getElementById("catalogGrid");
        const search = document.getElementById("catalogSearch");
        const chips = document.querySelectorAll(".catalog-chip");
        const empty = document.getElementById("catalogEmpty");
        let active = "todas";

        if (!grid) return;

        grid.innerHTML = "";
        courses().forEach(function (course) {
            grid.appendChild(renderCourseCard(course, "catalog-card"));
        });

        chips.forEach(function (chip) {
            const filter = chip.dataset.filter || "todas";
            const count = filter === "todas"
                ? courses().length
                : courses().filter(function (course) { return course.filter === filter; }).length;
            const label = chip.textContent.replace(/\s*\(\d+\)/, "").trim();
            chip.innerHTML = label + " <span>" + count + "</span>";
        });

        function apply() {
            const count = filterCards(grid, search ? search.value : "", active);
            if (empty) empty.style.display = count ? "none" : "block";
        }

        if (search) search.addEventListener("input", apply);

        chips.forEach(function (chip) {
            chip.addEventListener("click", function () {
                chips.forEach(function (item) { item.classList.remove("activo"); });
                chip.classList.add("activo");
                active = chip.dataset.filter || "todas";
                apply();
            });
        });

        apply();
    }

    function renderDetailProgress(course) {
        const progress = getProgress(course.id);
        const progressBar = document.getElementById("courseProgressBar");
        const progressText = document.getElementById("courseProgressText");
        const startButton = document.getElementById("startCourseButton");

        if (progressBar) progressBar.style.width = progress.percent + "%";
        if (progressText) progressText.textContent = progress.percent + "% completado";
        if (startButton) startButton.textContent = progress.enrolled ? "Curso agregado a mi ruta" : "Agregar a mis cursos";

        document.querySelectorAll("[data-module-toggle]").forEach(function (button) {
            const index = Number(button.dataset.moduleToggle);
            const done = progress.completedModules.indexOf(index) >= 0;
            button.classList.toggle("is-done", done);
            button.textContent = done ? "M\u00f3dulo completado" : "Marcar como completado";
        });
    }

    function initDetail() {
        const params = new URLSearchParams(window.location.search);
        const course = byId(params.get("id") || "1");
        const image = document.getElementById("courseImage");
        const startButton = document.getElementById("startCourseButton");
        const learnList = document.getElementById("learnList");
        const topicList = document.getElementById("topicList");
        const includesList = document.getElementById("includesList");
        const moduleList = document.getElementById("moduleList");
        const resourceList = document.getElementById("resourceList");
        const dimensionList = document.getElementById("dimensionList");
        const audienceText = document.getElementById("courseAudience");
        const projectText = document.getElementById("courseProject");
        const relatedGrid = document.getElementById("relatedCourses");
        const quickSearch = document.getElementById("quickSearch");

        document.title = course.title + " - Relax Zone";
        document.getElementById("courseCategory").textContent = course.category;
        document.getElementById("courseTitle").textContent = course.title;
        document.getElementById("courseDescription").textContent = course.description;
        document.getElementById("courseLevel").textContent = course.level;
        document.getElementById("courseDuration").textContent = course.duration;
        document.getElementById("courseFormat").textContent = course.format;
        if (image) {
            image.src = course.image;
            image.alt = course.alt || course.title;
        }

        if (audienceText) audienceText.textContent = course.audience || "";
        if (projectText) projectText.textContent = course.project || "";

        if (dimensionList) {
            dimensionList.innerHTML = "";
            (course.dimensions || []).forEach(function (dimension) {
                const card = document.createElement("article");
                card.className = "dimension-card";
                card.appendChild(text("h3", "", dimension.title));
                card.appendChild(text("p", "", dimension.text));
                dimensionList.appendChild(card);
            });
        }

        learnList.innerHTML = "";
        course.learn.forEach(function (item) {
            const row = document.createElement("div");
            row.className = "learn-item";
            row.appendChild(text("span", "check", "\u2713"));
            row.appendChild(text("span", "", item));
            learnList.appendChild(row);
        });

        topicList.innerHTML = "";
        course.topics.forEach(function (topic) {
            topicList.appendChild(text("li", "", topic));
        });

        includesList.innerHTML = "";
        [
            course.modules.length + " m\u00f3dulos guiados",
            "T\u00e9cnicas y ejercicios pr\u00e1cticos",
            "Retos de reflexi\u00f3n",
            "Recursos externos",
            "Progreso local",
            "Plan o proyecto final"
        ].forEach(function (item) {
            includesList.appendChild(text("li", "", "\u2713 " + item));
        });

        moduleList.innerHTML = "";
        course.modules.forEach(function (module, index) {
            const details = document.createElement("details");
            details.className = "module-item";
            if (index === 0) details.open = true;

            const summary = text("summary", "", "M\u00f3dulo " + (index + 1) + ": " + module.title);
            const theory = text("p", "module-theory", module.theory || "");
            const list = document.createElement("ul");
            module.lessons.forEach(function (lesson) {
                list.appendChild(text("li", "", lesson));
            });
            list.appendChild(text("li", "module-practice", "Reto: " + module.practice));
            const quote = text("blockquote", "module-quote", module.quote || "");

            const button = document.createElement("button");
            button.type = "button";
            button.className = "module-complete";
            button.dataset.moduleToggle = index;
            button.addEventListener("click", function () {
                const before = getProgress(course.id).percent;
                const progress = toggleModule(course.id, index);
                renderDetailProgress(course);
                if (before < 100 && progress.percent === 100) {
                    showCompletionModal(course);
                }
            });

            details.appendChild(summary);
            details.appendChild(theory);
            details.appendChild(list);
            details.appendChild(quote);
            details.appendChild(button);
            moduleList.appendChild(details);
        });

        resourceList.innerHTML = "";
        course.resources.forEach(function (resource) {
            const link = document.createElement("a");
            link.href = resource.url;
            link.target = "_blank";
            link.rel = "noopener noreferrer";
            link.appendChild(text("span", "resource-type", resource.type || "Recurso"));
            link.appendChild(text("strong", "", resource.label));
            link.appendChild(text("small", "", resource.url.indexOf("youtube.com") >= 0 ? "Abrir b\u00fasqueda de video" : "Abrir fuente externa"));
            resourceList.appendChild(link);
        });

        if (relatedGrid) {
            const related = courses()
                .filter(function (item) { return item.id !== course.id && item.filter === course.filter; })
                .concat(courses().filter(function (item) { return item.id !== course.id && item.filter !== course.filter; }))
                .slice(0, 3);

            relatedGrid.innerHTML = "";
            related.forEach(function (item) {
                relatedGrid.appendChild(renderCourseCard(item, "course-card related-card"));
            });
        }

        if (startButton) {
            startButton.addEventListener("click", function () {
                enroll(course.id);
                renderDetailProgress(course);
            });
        }

        if (quickSearch) {
            quickSearch.addEventListener("input", function () {
                const term = normalize(quickSearch.value);
                document.querySelectorAll(".detail-panel, .module-item").forEach(function (item) {
                    item.style.display = !term || normalize(item.textContent).includes(term) ? "" : "none";
                });
            });
        }

        loadServerProgress(function () {
            renderDetailProgress(course);
            postActivity(course, "Curso", "Entraste al curso " + course.title + ".");
        });
    }

    function showCompletionModal(course) {
        const modal = document.getElementById("courseCompletionModal");
        if (!modal) return;

        const title = document.getElementById("completionCourseTitle");
        if (title) title.textContent = course.title;

        modal.classList.add("is-open");
        modal.setAttribute("aria-hidden", "false");
    }

    window.RelaxZoneCoursesPages = {
        initHome: initHome,
        initDashboard: initDashboard,
        initCatalog: initCatalog,
        initDetail: initDetail,
        getProgress: getProgress
    };
})();
