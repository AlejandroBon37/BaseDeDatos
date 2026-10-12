-- =====================================================================================
-- 02_DML.sql -- Data Manipulation Language
-- Objetivo: Poblar la base de datos `control_acceso_institucion` con datos de prueba
-- realistas para validar las relaciones y el funcionamiento del sistema.
-- =====================================================================================
-- =====================================================================================
-- 04_DML.sql — Data Manipulation Language
-- Proyecto: Sistema de Control de Acceso y Seguridad
-- Objetivo: Demostrar operaciones de insercion, actualizacion y eliminacion
-- de registros dentro de las tablas de la base de datos.
-- =====================================================================================

USE `control_acceso_institucion`;

-- 1. INSERT: Registrar un nuevo acceso

INSERT INTO `registro_acceso`
(`usuario_id`, `dispositivo_id`, `fecha_hora`, `resultado`)
SELECT
    u.`usuario_id`,
    d.`dispositivo_id`,
    '2026-10-12 13:00:00',
    'Aceptado'
FROM `usuario` u
INNER JOIN `dispositivo` d
    ON d.`nombre_dispositivo` = 'Lector Torniquete Principal'
WHERE u.`numero_documento` = '1000123458'
AND NOT EXISTS (
    SELECT 1
    FROM `registro_acceso` ra
    WHERE ra.`usuario_id` = u.`usuario_id`
      AND ra.`dispositivo_id` = d.`dispositivo_id`
      AND ra.`fecha_hora` = '2026-10-12 13:00:00'
      AND ra.`resultado` = 'Aceptado'
);

-- 2. UPDATE: Actualizar el estado de una alerta

UPDATE `alerta_seguridad`
SET `estado` = 'Atendida'
WHERE `descripcion` = 'Intento de acceso no autorizado detectado'
AND `estado` = 'Pendiente';

-- 3. INSERT: Crear una alerta temporal para demostrar operaciones DML

INSERT INTO `alerta_seguridad`
(`dispositivo_id`, `descripcion`, `fecha_hora`, `estado`)
SELECT
    d.`dispositivo_id`,
    'Alerta temporal de prueba DML',
    '2026-10-12 13:05:00',
    'Pendiente'
FROM `dispositivo` d
WHERE d.`nombre_dispositivo` = 'Lector Parqueadero'
AND NOT EXISTS (
    SELECT 1
    FROM `alerta_seguridad` a
    WHERE a.`descripcion` = 'Alerta temporal de prueba DML'
      AND a.`fecha_hora` = '2026-10-12 13:05:00'
);

-- 4. DELETE: Eliminar únicamente la alerta temporal de prueba

DELETE FROM `alerta_seguridad`
WHERE `descripcion` = 'Alerta temporal de prueba DML'
AND `fecha_hora` = '2026-10-12 13:05:00';