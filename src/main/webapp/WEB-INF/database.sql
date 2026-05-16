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
    foto_perfil VARCHAR(255) NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
