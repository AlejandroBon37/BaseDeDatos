-- ===================================================================
-- 05_DCL.sql
-- Purpose: Create the DCL (Data Control Language) for the database.
-- ===================================================================

-- Crear un usuario de base de datos para el vigilante
CREATE USER 'vigilante'@'localhost' IDENTIFIED BY 'Seguridad2026';

-- Dar permisos de solo lectura sobre accesos y alertas
GRANT SELECT ON control_acceso_institucion.registro_accesos TO 'vigilante'@'localhost';
GRANT SELECT ON control_acceso_institucion.alerta_seguridad TO 'vigilante'@'localhost';

-- Revocar permisos de escritura si los hubiera
REVOKE INSERT, UPDATE, DELETE ON control_acceso_institucion.* FROM 'vigilante'@'localhost';

