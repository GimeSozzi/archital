-- EJEMPLOS DE USO: Elementos Base de datos Archital
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425


-- # EJEMPLOS DE USO: VISTAS

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


-- # EJEMPLOS DE USO: FUNCIONES

-- # Ejemplo Funcion 1 "f_obtener_info_proyecto_por_id":
-- SELECT f_obtener_info_proyecto_por_id(5) AS informacion_de_proyecto;

-- # Ejemplo Funcion 2 "f_honorarios_estimado_proyecto":
-- SELECT f_honorarios_estimado_proyecto(35, '2023-08-01', '2023-10-05') AS honorario_estimado;


-- # EJEMPLOS DE USO (LLAMADA): STORED PROCEDURES

-- # 1) Ejemplo de llamada al stored procedure 1 para obtener datos ordernados de la tabla "Proyecto" por campo "superficie" de tipo ASC:
-- CALL sp_obtener_datos_con_orden('Proyecto', 'superficie', 'ASC');
-- CALL sp_obtener_datos_con_orden('Proyecto', 'cantidad_plantas', 'DESC');

-- # 2) Ejemplo de llamada al stored procedure 2 para insertar un nuevo cliente:
-- SELECT * FROM archital.Persona; -- Consulta antes de llamar al S.P.2
-- SELECT * FROM archital.Cliente; -- Consulta antes de llamar al S.P.2
-- CALL sp_insert_o_update_Cliente_Profesional(NULL, 'German', 'Ordonez', '261432145', 'Los Alamos 561, Mendoza', 'gordonez@email.com', '12345612', 0, NULL, NULL, NULL, 1, '20123456120');
-- SELECT * FROM archital.Persona; -- Consulta después de llamar al S.P.2
-- SELECT * FROM archital.Cliente; -- Consulta después de llamar al S.P.2

-- # 3) Ejemplo de llamada al stored procedure 2 para actualizar la direccion, el email y el curriculum vitae de un profesional existente (persona_ID = 19):
-- SELECT * FROM archital.Persona; -- Consulta antes de llamar al S.P.2
-- SELECT * FROM archital.Profesional; -- Consulta anted de llamar al S.P.2
-- CALL sp_insert_o_update_Cliente_Profesional(19, 'Camila', 'Luna','02236567890', 'Bº Belgrano III M3 C2, Mar del Plata','camiarq@arq.com', '90123456', 1,'M25897D', '/uploads/cv/arqcamilalcv.pdf', 9.0, NULL, NULL);
-- SELECT * FROM archital.Persona; -- Consulta después de llamar al S.P.2
-- SELECT * FROM archital.Profesional; -- Consulta después de llamar al S.P.2


-- # EJEMPLOS DE USO: TRIGGERS

-- # Ejemplo Trigger 1 "tr_after_insert_proyecto":
-- SELECT * FROM archital.Proyecto; -- Consulta para mostrar la tabla "Proyecto" antes del "INSERT"
-- 
-- INSERT INTO archital.Proyecto (cliente_ID, profesional_ID, estado_proyecto_ID, tipologia_ID, titulo, superficie, cantidad_plantas, plano, memoria_descriptiva, fecha_inicio, fecha_finalizacion) VALUES
--    (6, 15, 1, 1, 'Casa Campo 1', 300.50, 1, '/uploads/plano/casacampo_1.dwg', 'Vivienda unifamiliar de estilo rural con materiales autóctonos.', '2023-07-10', NULL);
--
-- SELECT * FROM archital.Proyecto; -- Consulta para mostrar la tabla "Proyecto" después de la inserción del nuevo proyecto.
--
-- SELECT * FROM archital.LogProyecto; -- Consulta para mostrar la tabla "LogProyecto" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 3 "tr_mensaje_after_insert_proyecto":
-- SELECT * FROM archital.Mensajes; -- Consulta para mostrar la tabla "Mensajes" con el mensaje guardado al dispararse el trigger luego de la creación de un nuevo proyecto.


-- # Ejemplo Trigger 2 "tr_after_update_proyecto":
-- SELECT * FROM archital.Proyecto 
-- WHERE proyecto_ID = 3; -- Consulta para mostrar el registro proyecto_ID = 3 en la tabla "Proyecto" antes de aplicar un "UPDATE".
--
-- UPDATE archital.Proyecto
-- SET
--    estado_proyecto_ID = 2, -- cambio de estado para probar trigger
--    titulo = 'Remodelación Residencial Los Alamos',
--    superficie = 150.25 
-- WHERE proyecto_ID = 3;
--
-- SELECT * FROM archital.Proyecto
-- WHERE proyecto_ID = 3;  -- Consulta para mostrar el registro proyecto_ID = 3 en la tabla "Proyecto" después de aplicar un "UPDATE".
--
-- SELECT * FROM archital.Logproyecto; -- Consulta para mostrar la tabla "LogProyecto" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 4 "tr_mensaje_cambio_estado_proyecto":
-- SELECT * FROM archital.Mensajes; -- Consulta para mostrar la tabla "Mensajes" con el mensaje guardado al dispararse el trigger luego del cambio de estado de proyecto.


-- # Ejemplo Trigger 5 "tr_before_insert_profesional":
-- SELECT *
-- FROM archital.Persona AS per
-- LEFT JOIN archital.Profesional AS prof ON per.persona_ID = prof.persona_ID; -- Consulta para mostrar las tablas "Persona" y "Profesional" antes de ejecutar el "INSERT".
--
-- CALL sp_insert_o_update_Cliente_Profesional(NULL, 'Juan Ignacio', 'Perez Gomez', '0261432145', 'Las Tipas 1445, Mendoza', 'jiperezg@email.com', '01234560', 1, 'A32330G', '/uploads/cv/arqperezgomez-resume.pdf', 1.0, NULL, NULL); -- Llamada a S.P. para insertar un nuevo profesional.
--
-- SELECT *
-- FROM archital.Persona AS per
-- LEFT JOIN archital.Profesional AS prof ON per.persona_ID = prof.persona_ID; -- Consulta para mostrar las tablas "Persona" y "Profesional" luego de llamar al S.P. y agregar un nuevo profesional.
--
-- SELECT * FROM archital.LogProfesional; -- Consulta para mostrar la tabla "LogProfesional" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 6 "tr_before_update_profesional":
-- SELECT * 
-- FROM archital.Profesional 
-- WHERE profesional_ID = 10; -- Consulta para mostrar el profesional "profesional_ID = 10" de la tabla "Profesional" antes de ejecutar el "UPDATE".
--
-- UPDATE Profesional
-- SET calificacion = 4.5
-- WHERE profesional_ID = 10;
--
-- SELECT * 
-- FROM archital.Profesional
-- WHERE profesional_ID = 10; -- Consulta para mostrar el profesional "profesional_ID = 10" de la tabla "Profesional" luego de ejecutar el "UPDATE".
--
-- SELECT * FROM archital.LogProfesional; -- Consulta para mostrar la tabla "LogProfesional" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 7 "tr_before_insert_cliente":
-- SELECT *
-- FROM archital.Persona AS per
-- LEFT JOIN archital.Cliente AS c ON per.persona_ID = c.persona_ID; -- Consulta para mostrar las tablas "Persona" y "Cliente" antes de ejecutar el "INSERT"
--
-- CALL sp_insert_o_update_Cliente_Profesional(NULL, 'Elina', 'Garcia', '0263420565', 'Alvarez Condarco 1445, San Martin', 'elina_garcia@email.com', '89456123', 0, NULL, NULL, NULL, 2, 27894561239); -- Llamada a S.P. para insertar un nuevo cliente.
--
-- SELECT * 
-- FROM archital.Persona AS per
-- LEFT JOIN archital.Cliente AS c ON per.persona_ID = c.persona_ID; -- Consulta para mostrar las tablas "Persona" y "Cliente" luego de llamar al S.P. y agregar un cliente.
--
-- SELECT * FROM archital.LogCliente; -- Consulta para mostrar la tabla "LogCliente" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 8 "tr_before_update_cliente":
-- SELECT * 
-- FROM archital.Cliente
-- WHERE cliente_ID = 6; -- Consulta para mostrar el cliente "cliente_ID = 6" de la tabla "Cliente" antes de ejecutar el "UPDATE".
--
-- UPDATE archital.Cliente
-- SET condicion_fiscal_ID = 2
-- WHERE cliente_ID = 6;
--
-- SELECT * 
-- FROM archital.Cliente
-- WHERE cliente_ID = 6; -- Consulta para mostrar el cliente "cliente_ID = 6" la tabla "Cliente" luego de ejecutar el "UPDATE".
--
-- SELECT * FROM archital.LogCliente; -- Consulta para mostrar la tabla "LogCliente" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 9 "tr_before_insert_seguimiento":
-- SELECT * FROM archital.Seguimiento; -- Consulta para mostrar la tabla "Seguimiento" antes de ejecutar el "INSERT".
--
-- INSERT INTO archital.Seguimiento (proyecto_ID, descripcion) VALUES
--     (6, 'Proyecto terminado 2.');
--
-- SELECT * FROM archital.Seguimiento; -- Consulta para mostrar la tabla "Seguimiento" luego de ejecutarse el "INSERT".
--
-- SELECT * FROM archital.LogSeguimiento; -- Consulta para mostrar la tabla "LogSeguimiento" con los datos guardados al dispararse el trigger.


-- # Ejemplo Trigger 10 "tr_mensaje_after_insert_seguimiento":
-- SELECT * FROM archital.Mensajes; -- Consulta para mostrar la tabla "Mensajes" con el mensaje guardado al dispararse el trigger luego de la creación de un nuevo seguimiento (observación) de proyecto. .
