-- ===================================================================
-- 05_DCL.sql
-- Purpose: Create the DCL (Data Control Language) for the database.
-- ===================================================================

USE `control_acceso_institucion`;

CREATE USER IF NOT EXISTS 'vigilante'@'localhost'
IDENTIFIED BY 'Seguridad2026';

GRANT SELECT
ON `control_acceso_institucion`.`registro_acceso`
TO 'vigilante'@'localhost';

GRANT SELECT
ON `control_acceso_institucion`.`alerta_seguridad`
TO 'vigilante'@'localhost';