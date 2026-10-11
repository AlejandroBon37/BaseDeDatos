-- ===================================================================
-- 06_TCL.sql
-- Purpose: Create the TCL (Transaction Control Language) for the database.
-- ===================================================================

-- Ejemplo: registrar un acceso y una alerta en una transacción
START TRANSACTION;

INSERT INTO registros_accesos (usuario_id, dispositivo_id, resultado)
VALUES (
    (SELECT usuario_id FROM usuario WHERE numero_documento = '1000123456'),
    (SELECT dispositivo_id FROM dispositivo WHERE nombre = 'Lector Torniquete 1'),
    'Denegado'
);

INSERT INTO alerta_seguridad (dispositivo_id, descripcion, estado)
VALUES (
    (SELECT dispositivo_id FROM dispositivo WHERE nombre_dispositivo = 'Lector Torniquete 1'),
    'Intento de acceso no autorizado detectado',
    'pendiente'
);

-- Confirmar la transacción
COMMIT;
-- Si ocurre un error, se puede revertir la transacción
-- ROLLBACK;