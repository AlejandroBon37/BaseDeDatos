-- =====================================================================================
-- 02_DML.sql -- Data Manipulation Language
-- Objetivo: Poblar la base de datos `control_acceso_institucion` con datos de prueba
-- realistas para validar las relaciones y el funcionamiento del sistema.
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

INSERT IGNORE INTO `usuario` (`numero_documento`, `nombres`, `apellidos`, `rol_id`, `departamento_id`)
VALUES (
    '1000123456', 'Carlos Andres', 'Perez Gomez',
    (SELECT `rol_id` FROM `rol` WHERE `nombre_rol` = 'Administrador'),
    (SELECT `departamento_id` FROM `departamento` WHERE `nombre_depto` = 'Tecnología y Sistemas')
);

-- ---------------------------------------------------------------------------------
INSERT IGNORE INTO `credencial` (`usuario_id`, `codigo_tarjeta`, `tipo_credencial`)
VALUES (
    (SELECT `usuario_id` FROM `usuario` WHERE `numero_documento` = '1000123456'),
    'RFID-998877',
    'Tarjeta RFID'
);

INSERT IGNORE INTO `zona` (`nombre_zona`, `ubicacion`) VALUES
('Entrada Principal', 'Porteria del Edificio A'),
('Sala de Servidores', 'Piso 3 - Ala Norte');

INSERT IGNORE INTO `dispositivo` (`nombre_dispositivo`, `zona_id`)
VALUES (
    'Lector Torniquete 1',
    (SELECT `zona_id` FROM `zona` WHERE `nombre_zona` = 'Entrada Principal')
);

INSERT IGNORE INTO `dispositivo` (`nombre_dispositivo`, `zona_id`)
VALUES (
    'Lector Torniquete 1',
    (SELECT `zona_id` FROM `zona` WHERE `nombre_zona` = 'Entrada Principal')
);

DELETE ra FROM `registro_acceso` ra
INNER JOIN `usuario` u ON u.`usuario_id` = ra.`usuario_id`
WHERE u.`numero_documento` = '1000123456' AND ra.`fecha_hora` = '2026-10-10 08:30:00';