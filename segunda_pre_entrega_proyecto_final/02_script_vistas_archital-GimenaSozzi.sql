-- DESAFIO COMPLEMENTARIO: Script de creación de Vistas
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/script_inserciondatos_archital-GimenaSozzi.sql

-- Vista 1 "VistaProfesionalesCalificados": muestra Profesionales con mejor calificación (>= 8.0)
CREATE OR REPLACE VIEW archital.VistaProfesionalesCalificados AS
SELECT prof.profesional_ID,
       CONCAT(per.nombre, ' ', per.apellido) AS 'Nombre del Profesional',
       prof.calificacion AS 'Calificación'
FROM archital.Profesional AS prof
JOIN archital.Persona AS per ON prof.persona_ID = per.persona_ID
WHERE prof.calificacion >= 8.0;

-- Vista 2 "VistaProfesionalesEsp": muestra Profesionales y Especialidad
CREATE OR REPLACE VIEW archital.VistaProfesionalesEsp AS
SELECT prof.profesional_ID,
       CONCAT(per.nombre, ' ', per.apellido) AS 'Nombre del Profesional',
       GROUP_CONCAT(DISTINCT esp.nombre_esp ORDER BY esp.nombre_esp SEPARATOR ', ') AS 'Especialidades'
FROM archital.Profesional AS prof
JOIN archital.Persona AS per ON prof.persona_ID = per.persona_ID
LEFT JOIN archital.ProfEspecialidad AS prof_esp ON prof.profesional_ID = prof_esp.profesional_ID
LEFT JOIN archital.Especialidad AS esp ON prof_esp.especialidad_ID = esp.especialidad_ID
GROUP BY prof.profesional_ID;

-- Vista 3 "VistaProfesionalesHab": muestra de Profesionales y Habilidades
CREATE OR REPLACE VIEW archital.VistaProfesionalesHab AS
SELECT prof.profesional_ID,
       CONCAT(per.nombre, ' ', per.apellido) AS 'Nombre del Profesional',
       GROUP_CONCAT(DISTINCT hab.nombre_hab ORDER BY hab.nombre_hab SEPARATOR ', ') AS 'Habilidades'
FROM archital.Profesional AS prof
JOIN archital.Persona AS per ON prof.persona_ID = per.persona_ID
LEFT JOIN archital.ProfHabilidad AS prof_hab ON prof.profesional_ID = prof_hab.profesional_ID
LEFT JOIN archital.Habilidades AS hab ON prof_hab.habilidad_ID = hab.habilidad_ID
GROUP BY prof.profesional_ID;

-- Vista 4 "VistaProyectos": muestra información de Proyectos
CREATE OR REPLACE VIEW archital.VistaProyectos AS
SELECT pro.proyecto_ID,
    pro.titulo AS 'Título del Proyecto', 
    CONCAT(per_c.nombre, ' ', per_c.apellido) AS 'Nombre del Cliente',
    epro.nombre_est_proyecto AS 'Estado del Proyecto',
    CONCAT(per_prof.nombre, ' ', per_prof.apellido) AS 'Nombre del Profesional',
    pro.fecha_inicio AS 'Fecha de Inicio'
FROM archital.Proyecto AS pro
JOIN archital.Cliente AS c ON pro.cliente_ID = c.cliente_ID
JOIN archital.Persona AS per_c ON c.persona_ID = per_c.persona_ID
JOIN archital.EstadoProyecto AS epro ON pro.estado_proyecto_ID = epro.estado_proyecto_ID
JOIN archital.Profesional AS prof ON pro.profesional_ID = prof.profesional_ID
JOIN archital.Persona AS per_prof ON prof.persona_ID = per_prof.persona_ID;

-- Vista 5 "VistaProyectosPorTipologia": muestra Proyectos por Tipología
CREATE OR REPLACE VIEW archital.VistaProyectosPorTipologia AS
SELECT tip.nombre_tipologia AS tipologia, COUNT(*) AS 'Cantidad de Proyectos'
FROM archital.Proyecto AS pro
JOIN archital.Tipologia AS tip ON pro.tipologia_ID = tip.tipologia_ID
GROUP BY tip.nombre_tipologia;

-- Vista 6 "VistaMensajesProyecto": muestra los mensajes recibidos por un Proyecto
CREATE OR REPLACE VIEW archital.VistaMensajesProyecto AS
SELECT pro.proyecto_ID,
       pro.titulo AS 'Título del Proyecto',
       CONCAT(per.nombre, ' ', per.apellido) AS 'Remitente',
       m.asunto AS 'Asunto',
       m.texto_mensaje AS 'Texto del Mensaje',
       m.fecha_mensaje AS 'Fecha del Mensaje'
FROM archital.Mensajes AS m
JOIN archital.Proyecto AS pro ON m.proyecto_ID = pro.proyecto_ID
JOIN archital.Persona AS per ON m.persona_ID = per.persona_ID;

-- Vista 7 "VistaProfesional": muestra profesionales con nombre completo y datos de la tabla "Profesional"
CREATE OR REPLACE VIEW archital.VistaProfesional AS
SELECT
    per.nombre AS nombre_profesional,
    per.apellido AS apellido_profesional,
    prof.* -- Seleccionar todos los campos de la tabla Profesional
FROM
    archital.Persona AS per
JOIN archital.Profesional AS prof ON per.persona_ID = prof.persona_ID;

-- Vista 8 "VistaCliente": muestra clientes con nombre completo y datos de la tabla "Cliente"
CREATE OR REPLACE VIEW archital.VistaCliente AS
SELECT
    per.nombre AS nombre_cliente,
    per.apellido AS apellido_cliente,
    c.*
FROM
    archital.Persona AS per
JOIN archital.Cliente AS c ON per.persona_ID = c.persona_ID;

-- # Ejemplos de uso:


-- # Ejemplo Vista 1 "VistaProfesionalesCalificados":
-- SELECT * FROM archital.VistaProfesionalesCalificados;

-- # Ejemplo Vista 2 "VistaProfesionalesEsp":
-- SELECT * FROM archital.VistaProfesionalesEsp;

-- # Ejemplo Vista 3 "VistaProfesionalesHab":
-- SELECT * FROM archital.VistaProfesionalesHab;

-- # Ejemplo Vista 4 "VistaProyectos":
-- SELECT * FROM archital.VistaProyectos;

-- # Ejemplo Vista 5 "VistaProyectosPorTipologia":
-- SELECT * FROM archital.VistaProyectosPorTipologia;

-- # Ejemplo Vista 6 "VistaMensajesProyecto":
-- SELECT * FROM archital.VistaMensajesProyecto;

-- # Ejemplo Vista 7 "VistaProfesional":
-- SELECT * FROM archital.VistaProfesional;

-- # Ejemplo Vista 8 "VistaCliente":
-- SELECT * FROM archital.VistaCliente;
