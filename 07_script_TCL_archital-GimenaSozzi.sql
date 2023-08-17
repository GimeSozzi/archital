-- DESAFIO ENTREGABLE: Script Sentencias del Sublenguaje TCL
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/segunda_pre_entrega_proyecto_final/01_script_inserciondatos_archital-GimenaSozzi.sql

-- 1) Tabla Seguimiento

-- Inicio de la transacción
START TRANSACTION;

-- Consultar registros de la Tabla
-- SELECT * FROM archital.Seguimiento;

-- Eliminar dos registros de la Tabla Seguimiento
DELETE FROM archital.Seguimiento WHERE seguimiento_ID = 3;
DELETE FROM archital.Seguimiento WHERE seguimiento_ID = 1;

-- Consultar registros de la Tabla luego de los Delete
-- SELECT * FROM archital.Seguimiento;

-- ROLLBACK;

-- COMMIT;

-- Sentencias de reinserción de registros eliminados en la Tabla Seguimiento
-- INSERT INTO archital.Seguimiento (proyecto_ID, descripcion) VALUES
--      (5, 'Anteproyecto terminado. Se inicia Proyecto.'),
--      (7, 'Plano de instalaciones eléctricas iniciado.');


-- 2) Tabla Mensajes

-- Inicio de la transaccion
START TRANSACTION;

-- Consulta Tabla Mensajes antes de la insercion de registros
-- SELECT * FROM archital.Mensajes;

-- Insercion de nuevos registros
INSERT INTO archital.Mensajes (proyecto_ID, persona_ID, asunto, texto_mensaje) VALUES
    (5, 10, 'Sobre el avance del proyecto', 'Hola, me gustaría saber cómo va el avance del proyecto. ¿Podrías darme una actualización?'),
    (7, 12, 'Consulta sobre instalaciones eléctricas', 'Buen día, tengo algunas dudas respecto al plano de instalaciones eléctricas. ¿Podrías aclarármelas?'),
    (11, 6, 'Reunión para revisar diseño', 'Hola, ¿podemos agendar una reunión para revisar los detalles finales del diseño?'),
    (13, 9, 'Consulta sobre materiales', 'Estoy revisando los planos y tengo algunas preguntas sobre los materiales a utilizar. ¿Podemos discutirlo?');
-- SAVEPOINT después del registro #4
SAVEPOINT primeros_4;
INSERT INTO archital.Mensajes (proyecto_ID, persona_ID, asunto, texto_mensaje) VALUES
    (14, 15, 'Felicidades por el avance', '¡El trabajo que están realizando es increíble! Los planos están quedando geniales.'),
    (6, 3, 'Solicitud de reunión', 'Quisiera agendar una reunión para hablar sobre los próximos pasos del proyecto.'),
    (10, 8, 'Dudas sobre el presupuesto', 'Tengo algunas dudas sobre los costos. ¿Podemos hablar al respecto?'),
    (1, 11, 'Confirmación de reunión', 'La reunión para discutir los honorarios está confirmada para el próximo martes.');
-- SAVEPOINT después del registro #8
SAVEPOINT primeros_8;

-- Consulta de Tabla Mensajes despues de la insercion de registros
-- SELECT * FROM archital.Mensajes;

-- ROLLBACK TO primeros_4;

-- ROLLBACK;

-- Sentencia de eliminación del SAVEPOINT de los primeros 4 registros
-- RELEASE SAVEPOINT primeros_4;

-- COMMIT;
