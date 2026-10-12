-- ===================================================================
-- 06_TCL.sql
-- Purpose: Create the TCL (Transaction Control Language) for the database.
-- ===================================================================

USE `control_acceso_institucion`;

START TRANSACTION;

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `resultado`)
VALUES (
    (SELECT `usuario_id`
     FROM `usuario`
     WHERE `numero_documento` = '1000123456'),
    (SELECT `dispositivo_id`
     FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Torniquete 1'),
    'Denegado'
);

INSERT INTO `alerta_seguridad`
(`dispositivo_id`, `descripcion`, `estado`)
VALUES (
    (SELECT `dispositivo_id`
     FROM `dispositivo`
     WHERE `nombre_dispositivo` = 'Lector Torniquete 1'),
    'Intento de acceso no autorizado detectado',
    'Pendiente'
);

COMMIT;