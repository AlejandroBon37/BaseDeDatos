

USE `control_acceso_institucion`;


SELECT 
    u.`numero_documento` AS `Documento`,
    CONCAT(u.`nombres`, ' ', u.`apellidos`) AS `Nombre_Completo`,
    r.`nombre_rol` AS `Rol`,
    d.`nombre_depto` AS `Departamento`
FROM `usuario` u
INNER JOIN `rol` r ON r.`rol_id` = u.`rol_id`
INNER JOIN `departamento` d ON d.`departamento_id` = u.`departamento_id`;

--   ----------------------------------------------------------------------------------------
SELECT 
    ra.`acceso_id` AS `ID_Acceso`,
    CONCAT(u.`nombres`, ' ', u.`apellidos`) AS `Usuario`,
    d.`nombre_dispositivo` AS `Dispositivo`,
    z.`nombre_zona` AS `Zona`,
    ra.`fecha_hora` AS `Fecha_Y_Hora`,
    ra.`resultado` AS `Resultado`
FROM `registro_acceso` ra
INNER JOIN `usuario` u ON u.`usuario_id` = ra.`usuario_id`
INNER JOIN `dispositivo` d ON d.`dispositivo_id` = ra.`dispositivo_id`
INNER JOIN `zona` z ON z.`zona_id` = d.`zona_id`
ORDER BY ra.`fecha_hora` DESC;

--   ------------------------------------------------------------------------------------------
SELECT 
    a.`alerta_id` AS `ID_Alerta`,
    d.`nombre_dispositivo` AS `Dispositivo_Afectado`,
    z.`nombre_zona` AS `Zona`,
    a.`descripcion` AS `Descripcion_Incidente`,
    a.`fecha_hora` AS `Fecha_Alerta`,
    a.`estado` AS `Estado`
FROM `alerta_seguridad` a
INNER JOIN `dispositivo` d ON d.`dispositivo_id` = a.`dispositivo_id`
INNER JOIN `zona` z ON z.`zona_id` = d.`zona_id`
WHERE a.`estado` = 'Pendiente';