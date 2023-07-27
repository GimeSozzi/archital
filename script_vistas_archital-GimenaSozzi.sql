-- DESAFIO COMPLEMENTARIO: Script de creación de Vistas
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/script_inserciondatos_archital-GimenaSozzi.sql

-- Vista de Profesionales de alta calificación
CREATE OR REPLACE VIEW VistaProfesionalesCalificados AS
SELECT prof.profesional_ID,
       CONCAT(per.nombre, ' ', per.apellido) AS 'Nombre del Profesional',
       prof.calificacion AS 'Calificación'
FROM archital.Profesional AS prof
JOIN archital.Persona AS per ON prof.persona_ID = per.persona_ID
WHERE prof.calificacion >= 8.0;

-- Vista de Profesionales y Especialidades
CREATE OR REPLACE VIEW VistaProfesionalesEsp AS
SELECT prof.profesional_ID,
       CONCAT(per.nombre, ' ', per.apellido) AS 'Nombre del Profesional',
       GROUP_CONCAT(DISTINCT esp.nombre_esp ORDER BY esp.nombre_esp SEPARATOR ', ') AS 'Especialidades'
FROM archital.Profesional AS prof
JOIN archital.Persona AS per ON prof.persona_ID = per.persona_ID
LEFT JOIN archital.ProfEspecialidad AS prof_esp ON prof.profesional_ID = prof_esp.profesional_ID
LEFT JOIN archital.Especialidad AS esp ON prof_esp.especialidad_ID = esp.especialidad_ID
GROUP BY prof.profesional_ID;

-- Vista de Profesionales y Habilidades
CREATE OR REPLACE VIEW VistaProfesionalesHab AS
SELECT prof.profesional_ID,
       CONCAT(per.nombre, ' ', per.apellido) AS 'Nombre del Profesional',
       GROUP_CONCAT(DISTINCT hab.nombre_hab ORDER BY hab.nombre_hab SEPARATOR ', ') AS 'Habilidades'
FROM archital.Profesional AS prof
JOIN archital.Persona AS per ON prof.persona_ID = per.persona_ID
LEFT JOIN archital.ProfHabilidad AS prof_hab ON prof.profesional_ID = prof_hab.profesional_ID
LEFT JOIN archital.Habilidades AS hab ON prof_hab.habilidad_ID = hab.habilidad_ID
GROUP BY prof.profesional_ID;

-- Vista de información de Proyectos
CREATE OR REPLACE VIEW VistaProyectos AS
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

-- Vista de Proyectos por Tipología
CREATE OR REPLACE VIEW VistaProyectosPorTipologia AS
SELECT tip.nombre_tipologia AS tipologia, COUNT(*) AS 'Cantidad de Proyectos'
FROM archital.Proyecto AS pro
JOIN archital.Tipologia AS tip ON pro.tipologia_ID = tip.tipologia_ID
GROUP BY tip.nombre_tipologia;

-- Vista de Mensajes recibidos por un Proyecto
CREATE OR REPLACE VIEW VistaMensajesProyecto AS
SELECT pro.proyecto_ID,
       pro.titulo AS 'Título del Proyecto',
       CONCAT(per.nombre, ' ', per.apellido) AS 'Remitente',
       m.asunto AS 'Asunto',
       m.texto_mensaje AS 'Texto del Mensaje',
       m.fecha_mensaje AS 'Fecha del Mensaje'
FROM archital.Mensajes AS m
JOIN archital.Proyecto AS pro ON m.proyecto_ID = pro.proyecto_ID
JOIN archital.Persona AS per ON m.persona_ID = per.persona_ID;
