CREATE DATABASE IF NOT EXISTS relaxzone
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE relaxzone;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR(160) NOT NULL UNIQUE,
    nombre_usuario VARCHAR(80) NOT NULL UNIQUE,
    password_hash VARCHAR(64) NOT NULL,
    foto_perfil VARCHAR(500) NULL,
    sitio_web VARCHAR(500) NULL,
    biografia TEXT NULL,
    talentos TEXT NULL,
    genero VARCHAR(30) NULL,
    intereses TEXT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS comunidad_publicaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comunidad_talentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    talento TEXT NULL,
    busca TEXT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS usuario_cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    curso_id VARCHAR(40) NOT NULL,
    titulo VARCHAR(180) NOT NULL,
    categoria VARCHAR(80) NULL,
    total_modulos INT NOT NULL DEFAULT 0,
    modulos_completados INT NOT NULL DEFAULT 0,
    modulos_completados_lista VARCHAR(255) NULL,
    porcentaje INT NOT NULL DEFAULT 0,
    fecha_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_usuario_curso (usuario_id, curso_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS usuario_actividad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo VARCHAR(60) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    curso_id VARCHAR(40) NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

SELECT * FROM usuarios;
SELECT * FROM comunidad_publicaciones;
SELECT * FROM comunidad_talentos;
SELECT * FROM usuario_cursos;
SELECT * FROM usuario_actividad;
