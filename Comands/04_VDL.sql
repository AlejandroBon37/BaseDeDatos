-- =======================================================================
-- 04_VDL.sql
-- Purpose: Create the VDL (View Definition Language) for the database.
--========================================================================

USE `control_acceso_institucion`;

CREATE OR REPLACE VIEW `vista_accesos_recientes` AS
SELECT
    ra.`acceso_id`,
    CONCAT(u.`nombres`, ' ', u.`apellidos`) AS `usuario`,
    d.`nombre_dispositivo`,
    z.`nombre_zona`,
    ra.`fecha_hora`,
    ra.`resultado`
FROM `registro_acceso` ra
LEFT JOIN `usuario` u
    ON u.`usuario_id` = ra.`usuario_id`
LEFT JOIN `dispositivo` d
    ON d.`dispositivo_id` = ra.`dispositivo_id`
LEFT JOIN `zona` z
    ON z.`zona_id` = d.`zona_id`;

-- Vista de alertas pendientes
CREATE OR REPLACE VIEW `vista_alertas_pendientes` AS
SELECT
    a.`alerta_id`,
    d.`nombre_dispositivo`,
    z.`nombre_zona`,
    a.`descripcion`,
    a.`fecha_hora`,
    a.`estado`
FROM `alerta_seguridad` a
LEFT JOIN `dispositivo` d
    ON d.`dispositivo_id` = a.`dispositivo_id`
LEFT JOIN `zona` z
    ON z.`zona_id` = d.`zona_id`
WHERE a.`estado` = 'Pendiente';