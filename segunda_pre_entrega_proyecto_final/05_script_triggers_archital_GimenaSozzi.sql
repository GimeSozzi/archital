-- DESAFIO COMPLEMENTARIO: Script de Creación de Triggers
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/script_inserciondatos_archital-GimenaSozzi.sql
-- SEGUNDO CORRER EL SCRIPT DE CREACIÓN DE STORED PROCEDURES (Para poder ejecutar los triggers 5 y 7): https://github.com/GimeSozzi/archital/blob/main/script_stored_procedures_archital_GimenaSozzi.sql

DELIMITER $$

-- Tabla LogProyecto y Tabla Mensajes:

/*Trigger 1 "tr_after_insert_proyecto":
Se dispara luego de que se agrega un nuevo proyecto en la tabla "Proyecto", guardando automáticamente los datos en la tabla "LogProyecto".*/
CREATE TRIGGER tr_after_insert_proyecto
AFTER INSERT ON archital.Proyecto
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogProyecto (proyecto_ID, accion, titulo_nuevo, superficie_nueva, cantidad_plantas_nuevo, plano_nuevo, memoria_descriptiva_nueva, fecha_inicio_nueva, fecha_finalizacion_nueva, cliente_ID_nuevo, profesional_ID_nuevo, estado_proyecto_ID_nuevo, tipologia_ID_nueva, fecha_registro, hora_registro, usuario_accion)
    VALUES (NEW.proyecto_ID, 'INSERT', NEW.titulo, NEW.superficie, NEW.cantidad_plantas, NEW.plano, NEW.memoria_descriptiva, NEW.fecha_inicio, NEW.fecha_finalizacion, NEW.cliente_ID, NEW.profesional_ID, NEW.estado_proyecto_ID, NEW.tipologia_ID, CURDATE(), CURTIME(), USER());
END $$

/*Trigger 2 "tr_after_update_proyecto":
Se dispara luego de que se realiza un update de un proyecto en la tabla "Proyecto", guardando automáticamente los datos en la tabla "LogProyecto".*/
CREATE TRIGGER tr_after_update_proyecto
AFTER UPDATE ON archital.Proyecto
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogProyecto (proyecto_ID, accion, titulo_anterior, titulo_nuevo, superficie_anterior, superficie_nueva, cantidad_plantas_anterior, cantidad_plantas_nuevo, plano_anterior, plano_nuevo, memoria_descriptiva_anterior, memoria_descriptiva_nueva, fecha_inicio_anterior, fecha_inicio_nueva, fecha_finalizacion_anterior, fecha_finalizacion_nueva, cliente_ID_anterior, cliente_ID_nuevo, profesional_ID_anterior, profesional_ID_nuevo, estado_proyecto_ID_anterior, estado_proyecto_ID_nuevo, tipologia_ID_anterior, tipologia_ID_nueva, fecha_registro, hora_registro, usuario_accion)
    VALUES (OLD.proyecto_ID, 'UPDATE', OLD.titulo, NEW.titulo, OLD.superficie, NEW.superficie, OLD.cantidad_plantas, NEW.cantidad_plantas, OLD.plano, NEW.plano, OLD.memoria_descriptiva, NEW.memoria_descriptiva, OLD.fecha_inicio, NEW.fecha_inicio, OLD.fecha_finalizacion, NEW.fecha_finalizacion, OLD.cliente_ID, NEW.cliente_ID, OLD.profesional_ID, NEW.profesional_ID, OLD.estado_proyecto_ID, NEW.estado_proyecto_ID, OLD.tipologia_ID, NEW.tipologia_ID, CURDATE(), CURTIME(), USER());
END $$

/* Trigger 3 "tr_mensaje_after_insert_proyecto":
Se dispara luego de que detecta la acción "INSERT" en la tabla "LogProyecto", guardando automáticamente un mensaje de "Creación de Nuevo Proyecto" en la tabla "Mensajes".*/
CREATE TRIGGER tr_mensaje_after_insert_proyecto
AFTER INSERT ON LogProyecto
FOR EACH ROW
BEGIN
    IF NEW.accion = 'INSERT' THEN
        -- Obtener el valor de persona_ID desde la tabla Persona basado en profesional_ID
        SET @persona_ID = (SELECT per.persona_ID FROM Persona AS per
                           JOIN Profesional AS prof ON per.persona_ID = prof.persona_ID
                           JOIN Proyecto AS proy ON prof.profesional_ID = proy.profesional_ID
                           WHERE proy.proyecto_ID = NEW.proyecto_ID);
        -- Insertar mensaje con proyecto_ID y persona_ID en la tabla Mensajes
        INSERT INTO Mensajes (proyecto_ID, persona_ID, asunto, texto_mensaje)
        VALUES (NEW.proyecto_ID, @persona_ID, 'Creacion de Nuevo Proyecto', 'Hola!!! Se ha creado el proyecto.');
    END IF;
END $$

/* Trigger 4 "tr_mensaje_cambio_estado_proyecto":
Se dispara luego de que detecta la acción "UPDATE" y el dato en el campo "estado_proyecto_ID_nuevo" es distinto del dato en "estado_proyecto_id_anterior" en la tabla "LogProyecto", 
guardando automáticamente un mensaje de "Cambio de Estado de Proyecto" en la tabla "Mensajes".*/
CREATE TRIGGER tr_mensaje_update_cambio_estado_proyecto
AFTER INSERT ON LogProyecto
FOR EACH ROW
BEGIN
    IF NEW.accion = 'UPDATE' AND NEW.estado_proyecto_ID_nuevo != NEW.estado_proyecto_ID_anterior THEN
        -- Obtener el nombre del estado nuevo
        SET @nombre_estado_nuevo = (SELECT nombre_est_proyecto FROM EstadoProyecto 
                                    WHERE estado_proyecto_ID = NEW.estado_proyecto_ID_nuevo);
        -- Obtener el valor de persona_ID desde la tabla Persona basado en profesional_ID
        SET @persona_ID = (SELECT per.persona_ID FROM Persona AS per
                           INNER JOIN Profesional AS prof ON per.persona_ID = prof.persona_ID
                           INNER JOIN Proyecto AS proy ON prof.profesional_ID = proy.profesional_ID
                           WHERE proy.proyecto_ID = NEW.proyecto_ID);
        -- Insertar mensaje con el nombre del estado nuevo en la tabla Mensajes
        INSERT INTO Mensajes (proyecto_ID, persona_ID, asunto, texto_mensaje)
        VALUES (NEW.proyecto_ID, @persona_ID, 'Cambio de Estado de Proyecto', CONCAT('El estado del proyecto ha sido cambiado a "', @nombre_estado_nuevo, '"'));
    END IF;
END $$

-- Tabla LogProfesional:

/*Trigger 5 "tr_before_insert_profesional":
Se dispara antes de detectar que se agregado un nuevo profesional en la tabla "Profesional", guardando automáticamente los datos en la tabla "LogProfesional".*/
CREATE TRIGGER tr_before_insert_profesional
BEFORE INSERT ON archital.Profesional
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogProfesional (profesional_ID, accion, fecha_registro, hora_registro, usuario_accion)
    VALUES (NEW.profesional_ID, 'INSERT', CURDATE(), CURTIME(), USER());
END $$

/*Trigger 6 "tr_before_update_profesional":
Se dispara antes de detectar que se ha realizado un update de un profesional en la tabla "Profesional", guardando automáticamente los datos en la tabla "LogProfesional".*/
CREATE TRIGGER tr_before_update_profesional
BEFORE UPDATE ON archital.Profesional
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogProfesional (profesional_ID, accion, fecha_registro, hora_registro, usuario_accion)
    VALUES (NEW.profesional_ID, 'UPDATE', CURDATE(), CURTIME(), USER());
END $$

-- Tabla LogCliente:

/*Trigger 7 "tr_before_insert_cliente":
Se dispara antes de detectar que se agregado un nuevo cliente en la tabla "Cliente", guardando automáticamente los datos en la tabla "LogCliente".*/
CREATE TRIGGER tr_before_insert_cliente
BEFORE INSERT ON archital.Cliente
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogCliente (cliente_ID, accion, fecha_registro, hora_registro, usuario_accion)
    VALUES (NEW.cliente_ID, 'INSERT', CURDATE(), CURTIME(), USER());
END $$

/*Trigger 8 "tr_before_update_cliente":
Se dispara antes de detectar que se ha realizado un update de un cliente en la tabla "Cliente", guardando automáticamente los datos en la tabla "LogCliente".*/
CREATE TRIGGER tr_before_update_cliente
BEFORE UPDATE ON archital.Cliente
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogCliente (cliente_ID, accion, fecha_registro, hora_registro, usuario_accion)
    VALUES (NEW.cliente_ID, 'UPDATE', CURDATE(), CURTIME(), USER());
END $$

-- Tabla LogSeguimiento y Tabla Mensajes

/*Trigger 9 "tr_before_insert_seguimiento":
Se dispara luego de que detecta que se ha agregado un nuevo seguimiento de proyecto (observación) en la tabla "Seguimiento", guardando automáticamente los datos en la tabla "LogSeguimiento".*/
CREATE TRIGGER tr_before_insert_seguimiento
AFTER INSERT ON archital.Seguimiento
FOR EACH ROW
BEGIN
    INSERT INTO archital.LogSeguimiento (seguimiento_ID, accion, fecha_registro, hora_registro, usuario_accion)
    VALUES (NEW.seguimiento_ID, 'INSERT', CURDATE(), CURTIME(), USER());
END $$

/* Trigger 10 "tr_mensaje_after_insert_seguimiento":
Se dispara luego de que detecta la acción "INSERT" en la tabla "LogSeguimiento", guardando automáticamente un mensaje de "Nuevo Seguimiento de Proyecto" en la tabla "Mensajes".*/
CREATE TRIGGER tr_mensaje_after_insert_seguimiento
AFTER INSERT ON archital.LogSeguimiento
FOR EACH ROW
BEGIN
    IF NEW.accion = 'INSERT' THEN
        -- Obtener el valor de proyecto_ID desde la tabla Seguimiento
        SET @proyecto_ID = (SELECT proyecto_ID FROM archital.Seguimiento WHERE seguimiento_ID = NEW.seguimiento_ID);
        
        -- Obtener el valor de persona_ID desde la tabla Persona basado en el cliente_ID del proyecto
        SET @persona_ID = (SELECT per.persona_ID FROM Persona AS per
                           JOIN Cliente AS c ON per.persona_ID = c.persona_ID
                           JOIN Proyecto AS proy ON c.cliente_ID = proy.cliente_ID
                           WHERE proy.proyecto_ID = @proyecto_ID);
        
        -- Obtener el nombre del cliente
        SET @cliente_nombre = (SELECT CONCAT(per.nombre, ' ', per.apellido) FROM Persona AS per
                               JOIN Cliente AS c ON per.persona_ID = c.persona_ID
                               JOIN Proyecto AS proy ON c.cliente_ID = proy.cliente_ID
                               WHERE proy.proyecto_ID = @proyecto_ID);
        
        -- Obtener el título del proyecto
        SET @proyecto_titulo = (SELECT titulo FROM archital.Proyecto WHERE proyecto_ID = @proyecto_ID);
        
        -- Insertar mensaje con proyecto_ID y persona_ID en la tabla Mensajes
        INSERT INTO Mensajes (proyecto_ID, persona_ID, asunto, texto_mensaje)
        VALUES (@proyecto_ID, @persona_ID, 'Nuevo seguimiento de Proyecto',
                CONCAT('Hola ', @cliente_nombre, ', tienes una nueva observación en tu proyecto "', @proyecto_titulo, '". ¡Revísala!'));
    END IF;
END $$


DELIMITER ;

-- # Ejemplos de uso:


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
