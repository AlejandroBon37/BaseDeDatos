-- =====================================================================================
-- 01_DDL.sql — Data Definition Language
-- Proyecto: Sistema de Control de Acceso y Seguridad
-- Objetivo: Definir y modificar la estructura de la base de datos de la institución.
-- =====================================================================================
USE `control_acceso_institucion`;

CREATE TABLE IF NOT EXISTS `tabla_prueba` (
    `Tabla_Prueba_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Descripcion` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`Tabla_Prueba_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci
  COMMENT = 'Tabla temporal usada únicamente para demostrar sentencias DDL.';

CREATE TABLE IF NOT EXISTS `rol` (
    `rol_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre_rol` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`rol_id`),
    UNIQUE KEY `uq_rol_nombre` (`nombre_rol`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Almacena los roles o perfiles de seguridad del sistema.';

CREATE TABLE IF NOT EXISTS `departamento` (
    `departamento_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre_depto` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`departamento_id`),
    UNIQUE KEY `uq_departamento_nombre` (`nombre_depto`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Departamentos o areas organizacionales.';

CREATE TABLE IF NOT EXISTS `usuario` (
    `usuario_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `numero_documento` VARCHAR(15) NOT NULL,
    `nombres` VARCHAR(100) NOT NULL,
    `apellidos` VARCHAR(100) NOT NULL,
    `rol_id` INT UNSIGNED NOT NULL,
    `departamento_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`usuario_id`),
    UNIQUE KEY `uq_usuario_documento` (`numero_documento`),
    CONSTRAINT `fk_usuario_rol`
        FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`),
    CONSTRAINT `fk_usuario_departamento`
        FOREIGN KEY (`departamento_id`)
        REFERENCES `departamento` (`departamento_id`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Registro central de usuarios del sistema de acceso.';

CREATE TABLE IF NOT EXISTS `credencial` (
    `credencial_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `usuario_id` INT UNSIGNED NOT NULL,
    `codigo_tarjeta` VARCHAR(50) NOT NULL,
    `tipo_credencial` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`credencial_id`),
    UNIQUE KEY `uq_credencial_codigo` (`codigo_tarjeta`),
    CONSTRAINT `fk_credencial_usuario`
        FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usuario_id`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Credenciales fisicas o digitales asignadas a los usuarios.';

CREATE TABLE IF NOT EXISTS `zona` (
    `zona_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre_zona` VARCHAR(100) NOT NULL,
    `ubicacion` VARCHAR(150) NOT NULL,
    PRIMARY KEY (`zona_id`),
    UNIQUE KEY `uq_zona_nombre` (`nombre_zona`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Zonas o espacios fisicos con control de ingreso.';

CREATE TABLE IF NOT EXISTS `dispositivo` (
    `dispositivo_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre_dispositivo` VARCHAR(100) NOT NULL,
    `zona_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`dispositivo_id`),
    UNIQUE KEY `uq_dispositivo_nombre` (`nombre_dispositivo`),
    CONSTRAINT `fk_dispositivo_zona`
        FOREIGN KEY (`zona_id`) REFERENCES `zona` (`zona_id`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Dispositivos de control de acceso ubicados en las zonas.';

CREATE TABLE IF NOT EXISTS `registro_acceso` (
    `acceso_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `usuario_id` INT UNSIGNED NULL,
    `dispositivo_id` INT UNSIGNED NULL,
    `fecha_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `resultado` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`acceso_id`),
    CONSTRAINT `fk_acceso_usuario`
        FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usuario_id`),
    CONSTRAINT `fk_acceso_dispositivo`
        FOREIGN KEY (`dispositivo_id`)
        REFERENCES `dispositivo` (`dispositivo_id`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Historial y auditoria de los intentos de acceso.';

CREATE TABLE IF NOT EXISTS `alerta_seguridad` (
    `alerta_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `dispositivo_id` INT UNSIGNED NULL,
    `descripcion` VARCHAR(200) NOT NULL,
    `fecha_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `estado` VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    PRIMARY KEY (`alerta_id`),
    CONSTRAINT `fk_alerta_dispositivo`
        FOREIGN KEY (`dispositivo_id`)
        REFERENCES `dispositivo` (`dispositivo_id`)
) ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_general_ci
COMMENT = 'Registro de alertas e incidencias de seguridad.';