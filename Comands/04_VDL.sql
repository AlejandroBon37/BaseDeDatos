-- =======================================================================
-- 04_VDL.sql
-- Purpose: Create the VDL (View Definition Language) for the database.
--========================================================================

--Vista que muestra los accesos recientes con información del usuario, dispositivo y zona.
CREATE VIEW vista_accesos_recientes AS
SELECT
    ra.acceso_id,
    CONCAT(u.nombres, ' ', u.apellidos) AS usuario,
    d.nombre_dispositivo,
    z.nombre_zona,
    ra.fecha_hora,
    ra.resultado
FROM registros_accesos ra
INNER JOIN usuario u ON u.usuario_id = ra.usuario_id
INNER JOIN dispositivo d ON d.dispositivo_id = ra.dispositivo_id
INNER JOIN zona z ON z.zona_id = d.zona_id
ORDER BY ra.fecha_hora DESC;

--Vista que muestra unicamente las alertas pendientes 
CREATE VIEW vista_alertas_pendientes AS
SELECT
    a.alerta_id,
    d.nombre_dispositivo,
    z.nombre_zona,
    a.descripcion,
    a.fecha_hora,
    a.estado
FROM alerta_seguridad a
INNER JOIN dispositivo d ON d.dispositivo_id = a.dispositivo_id
INNER JOIN zona z ON z.zona_id = d.zona_id
WHERE a.estado = 'pendiente';

