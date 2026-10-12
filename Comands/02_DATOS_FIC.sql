-- =====================================================================================
-- 02_DATOS_FIC.sql
-- Proyecto: Sistema de Control de Acceso y Seguridad
-- Objetivo: Poblar las tablas con datos ficticios para probar las relaciones,
-- consultas y operaciones del sistema.
-- =====================================================================================

USE `control_acceso_institucion`;

INSERT IGNORE INTO `rol` (`nombre_rol`) VALUES
('Administrador'),
('Vigilante'),
('Empleado'),
('Visitante');

INSERT IGNORE INTO `departamento` (`nombre_depto`) VALUES
('Tecnologia y Sistemas'),
('Talento Humano'),
('Seguridad Fisica'),
('Administracion');
 

INSERT IGNORE INTO `zona` (`nombre_zona`, `ubicacion`) VALUES
('Entrada Principal', 'Porteria del Edificio A'),
('Sala de Servidores', 'Piso 3 - Ala Norte'),
('Archivo Central', 'Piso 1 - Bloque B'),
('Parqueadero', 'Zona exterior del Edificio A');

INSERT IGNORE INTO `usuario`
(`numero_documento`, `nombres`, `apellidos`, `rol_id`, `departamento_id`)
VALUES
(
    '1000123456',
    'Carlos Andres',
    'Perez Gomez',
    (SELECT `rol_id` FROM `rol`
     WHERE `nombre_rol` = 'Administrador'),
    (SELECT `departamento_id` FROM `departamento`
     WHERE `nombre_depto` = 'Tecnologia y Sistemas')
),
(
    '1000123457',
    'Laura Camila',
    'Rodriguez Torres',
    (SELECT `rol_id` FROM `rol`
     WHERE `nombre_rol` = 'Vigilante'),
    (SELECT `departamento_id` FROM `departamento`
     WHERE `nombre_depto` = 'Seguridad Fisica')
),
(
    '1000123458',
    'Miguel Angel',
    'Castillo Rojas',
    (SELECT `rol_id` FROM `rol`
     WHERE `nombre_rol` = 'Empleado'),
    (SELECT `departamento_id` FROM `departamento`
     WHERE `nombre_depto` = 'Talento Humano')
),
(
    '1000123459',
    'Sofia',
    'Martinez Gomez',
    (SELECT `rol_id` FROM `rol`
     WHERE `nombre_rol` = 'Visitante'),
    (SELECT `departamento_id` FROM `departamento`
     WHERE `nombre_depto` = 'Administracion')
),
(
    '1000123460',
    'Daniel Felipe',
    'Vargas Ruiz',
    (SELECT `rol_id` FROM `rol`
     WHERE `nombre_rol` = 'Empleado'),
    (SELECT `departamento_id` FROM `departamento`
     WHERE `nombre_depto` = 'Tecnologia y Sistemas')
);


INSERT IGNORE INTO `credencial`
(`usuario_id`, `codigo_tarjeta`, `tipo_credencial`)
VALUES
(
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123456'),
    'RFID-998877',
    'Tarjeta RFID'
),
(
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123457'),
    'RFID-998878',
    'Tarjeta RFID'
),
(
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123458'),
    'RFID-998879',
    'Tarjeta RFID'
),
(
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123459'),
    'VIS-100001',
    'Credencial de visitante'
),
(
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123460'),
    'RFID-998880',
    'Tarjeta RFID'
);

INSERT IGNORE INTO `dispositivo`
(`nombre_dispositivo`, `zona_id`)
VALUES
(
    'Lector Torniquete Principal',
    (SELECT `zona_id` FROM `zona`
     WHERE `nombre_zona` = 'Entrada Principal')
),
(
    'Lector Sala Servidores',
    (SELECT `zona_id` FROM `zona`
     WHERE `nombre_zona` = 'Sala de Servidores')
),
(
    'Lector Archivo Central',
    (SELECT `zona_id` FROM `zona`
     WHERE `nombre_zona` = 'Archivo Central')
),
(
    'Lector Parqueadero',
    (SELECT `zona_id` FROM `zona`
     WHERE `nombre_zona` = 'Parqueadero')
);

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `fecha_hora`, `resultado`)
SELECT
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123456'),
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Torniquete Principal'),
    '2026-10-10 07:55:00',
    'Aceptado'
WHERE NOT EXISTS (
    SELECT 1 FROM `registro_acceso`
    WHERE `usuario_id` = (
        SELECT `usuario_id` FROM `usuario`
        WHERE `numero_documento` = '1000123456'
    )
    AND `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Torniquete Principal'
    )
    AND `fecha_hora` = '2026-10-10 07:55:00'
    AND `resultado` = 'Aceptado'
);

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `fecha_hora`, `resultado`)
SELECT
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123457'),
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Torniquete Principal'),
    '2026-10-10 08:02:00',
    'Aceptado'
WHERE NOT EXISTS (
    SELECT 1 FROM `registro_acceso`
    WHERE `usuario_id` = (
        SELECT `usuario_id` FROM `usuario`
        WHERE `numero_documento` = '1000123457'
    )
    AND `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Torniquete Principal'
    )
    AND `fecha_hora` = '2026-10-10 08:02:00'
    AND `resultado` = 'Aceptado'
);

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `fecha_hora`, `resultado`)
SELECT
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123460'),
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Sala Servidores'),
    '2026-10-10 08:15:00',
    'Denegado'
WHERE NOT EXISTS (
    SELECT 1 FROM `registro_acceso`
    WHERE `usuario_id` = (
        SELECT `usuario_id` FROM `usuario`
        WHERE `numero_documento` = '1000123460'
    )
    AND `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Sala Servidores'
    )
    AND `fecha_hora` = '2026-10-10 08:15:00'
    AND `resultado` = 'Denegado'
);

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `fecha_hora`, `resultado`)
SELECT
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123459'),
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Torniquete Principal'),
    '2026-10-10 10:40:00',
    'Denegado'
WHERE NOT EXISTS (
    SELECT 1 FROM `registro_acceso`
    WHERE `usuario_id` = (
        SELECT `usuario_id` FROM `usuario`
        WHERE `numero_documento` = '1000123459'
    )
    AND `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Torniquete Principal'
    )
    AND `fecha_hora` = '2026-10-10 10:40:00'
    AND `resultado` = 'Denegado'
);

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `fecha_hora`, `resultado`)
SELECT
    (SELECT `usuario_id` FROM `usuario`
     WHERE `numero_documento` = '1000123458'),
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Archivo Central'),
    '2026-10-10 11:00:00',
    'Aceptado'
WHERE NOT EXISTS (
    SELECT 1 FROM `registro_acceso`
    WHERE `usuario_id` = (
        SELECT `usuario_id` FROM `usuario`
        WHERE `numero_documento` = '1000123458'
    )
    AND `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Archivo Central'
    )
    AND `fecha_hora` = '2026-10-10 11:00:00'
    AND `resultado` = 'Aceptado'
);

INSERT INTO `alerta_seguridad`
(`dispositivo_id`, `descripcion`, `fecha_hora`, `estado`)
SELECT
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Sala Servidores'),
    'Intento de acceso no autorizado detectado',
    '2026-10-10 08:15:00',
    'Pendiente'
WHERE NOT EXISTS (
    SELECT 1 FROM `alerta_seguridad`
    WHERE `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Sala Servidores'
    )
    AND `descripcion` = 'Intento de acceso no autorizado detectado'
    AND `fecha_hora` = '2026-10-10 08:15:00'
);

INSERT INTO `alerta_seguridad`
(`dispositivo_id`, `descripcion`, `fecha_hora`, `estado`)
SELECT
    (SELECT `dispositivo_id` FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Parqueadero'),
    'Dispositivo sin comunicacion con el sistema',
    '2026-10-10 12:30:00',
    'Pendiente'
WHERE NOT EXISTS (
    SELECT 1 FROM `alerta_seguridad`
    WHERE `dispositivo_id` = (
        SELECT `dispositivo_id` FROM `dispositivo`
        WHERE `nombre_dispositivo` = 'Lector Parqueadero'
    )
    AND `descripcion` = 'Dispositivo sin comunicacion con el sistema'
    AND `fecha_hora` = '2026-10-10 12:30:00'
);
