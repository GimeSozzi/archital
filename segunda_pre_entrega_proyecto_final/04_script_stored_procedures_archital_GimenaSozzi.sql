-- DESAFIO COMPLEMENTARIO: Script de Creación de Stored Procedures
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/script_inserciondatos_archital-GimenaSozzi.sql

DELIMITER $$

/* Stored Procedure 1: sp_obtener_datos_con_orden 

Este S.P. se utiliza para obtener los datos de una tabla específica ("tabla_nombre") y ordenarlos según un campo dado ("campo_orden").
De manera ASC o DESC ("tipo_orden")

Ejemplo: CALL sp_obtener_datos_con_orden('Proyecto', 'superficie', 'ASC')

*/

CREATE PROCEDURE sp_obtener_datos_con_orden (
    IN tabla_nombre VARCHAR(255), -- Parámetro: Nombre de la tabla de la que se obtendrán los datos
    IN campo_orden VARCHAR(255),  -- Parámetro: Campo por el cual se ordenarán los datos
    IN tipo_orden VARCHAR(4)      -- Parámetro: Tipo de orden, 'ASC' o 'DESC'
)
BEGIN
    -- Definir una variable para almacenar la parte de la consulta SQL relacionada con el ordenamiento
    DECLARE consulta_orden VARCHAR(255);

    -- Verificar si el parámetro 'campo_orden' no está vacío
    IF campo_orden != '' THEN
        -- Si hay un campo de ordenamiento válido, construir la parte de la consulta SQL para el ordenamiento
        SET consulta_orden = CONCAT('ORDER BY ', campo_orden, ' ', tipo_orden);
    ELSE
        -- Si el campo de ordenamiento está vacío, dejar 'consulta_orden' como una cadena vacía
        SET consulta_orden = '';
    END IF;

    -- Construir la consulta SQL completa concatenando el nombre de la tabla y la parte de ordenamiento
    SET @consulta_sql = CONCAT ('SELECT * FROM ', tabla_nombre, ' ', consulta_orden);
    
    -- Ejecutar la consulta SQL dinámica
    PREPARE stmt FROM @consulta_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$


/*Stored Procedure 2: sp_insert_o_update_Cliente_o_Profesional

Este S.P. se utiliza para insertar o actualizar información sobre un cliente o profesional en las tablas "Persona", "Cliente" y "Profesional".
Si el cliente o profesional ya existe en la base de datos (se encuentra por su "persona_ID", "nombre", "apellido" y "dni" de la tabla "Persona"), se actualizarán sus datos. 
Sino, se insertará un nuevo registro en la tabla "Persona" y en la tablas "Cliente" o "Profesional" como nuevo cliente o profesional, segun corresponda.

Ejemplo: CALL sp_insert_o_update_Cliente_Profesional(NULL, 'German', 'Ordonez', '261432145', 'Los Alamos 561, Mendoza', 'gordonez@email.com', '12345612', 0, NULL, NULL, NULL, 1, '20123456120');

*/

CREATE PROCEDURE sp_insert_o_update_Cliente_Profesional(
    IN p_persona_ID INT,
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(120),
    IN p_email VARCHAR(120),
    IN p_dni VARCHAR(20),
    IN p_es_profesional TINYINT, -- 0 para cliente, 1 para profesional
    -- Datos adicionales para profesional
    IN p_matricula_profesional VARCHAR(50),
    IN p_curriculum_vitae VARCHAR(255),
    IN p_calificacion DECIMAL(3, 1),
    -- Datos adicionales para cliente
    IN p_condicion_fiscal_ID INT,
    IN p_cuit VARCHAR(15)
)
BEGIN
    DECLARE persona_existente_ID INT;

    -- Verificar si la persona ya existe por persona_ID, nombre, apellido y dni
    SELECT persona_ID INTO persona_existente_ID
    FROM archital.Persona
    WHERE nombre = p_nombre
      AND apellido = p_apellido
      AND dni = p_dni;

    IF persona_existente_ID IS NOT NULL THEN
        -- Actualizar datos del cliente o profesional en la tabla Persona
        UPDATE archital.Persona
        SET telefono = p_telefono,
            direccion = p_direccion,
            email = p_email
        WHERE persona_ID = persona_existente_ID;

        -- Verificar si es un profesional
        IF p_es_profesional = 1 THEN
            -- Verificar si el profesional ya existe en la tabla Profesional
            IF EXISTS (SELECT 1 FROM archital.Profesional WHERE persona_ID = persona_existente_ID) THEN
                -- Actualizar datos del profesional en la tabla Profesional
                UPDATE archital.Profesional
                SET matricula_profesional = p_matricula_profesional,
                    curriculum_vitae = p_curriculum_vitae,
                    calificacion = p_calificacion
                WHERE persona_ID = persona_existente_ID;
            ELSE
                -- Insertar nuevo registro en la tabla Profesional
                INSERT INTO archital.Profesional (persona_ID, matricula_profesional, curriculum_vitae, calificacion)
                VALUES (persona_existente_ID, p_matricula_profesional, p_curriculum_vitae, p_calificacion);
            END IF;
        ELSE
            -- Verificar si el cliente ya existe en la tabla Cliente
            IF EXISTS (SELECT 1 FROM archital.Cliente WHERE persona_ID = persona_existente_ID) THEN
                -- Actualizar datos del cliente en la tabla Cliente
                UPDATE archital.Cliente
                SET condicion_fiscal_ID = p_condicion_fiscal_ID,
                    cuit = p_cuit
                WHERE persona_ID = persona_existente_ID;
            ELSE
                -- Insertar nuevo registro en la tabla Cliente
                INSERT INTO archital.Cliente (persona_ID, condicion_fiscal_ID, cuit)
                VALUES (persona_existente_ID, p_condicion_fiscal_ID, p_cuit);
            END IF;
        END IF;
    ELSE
        -- Insertar nuevo registro en la tabla Persona
        INSERT INTO archital.Persona (nombre, apellido, telefono, direccion, email, dni)
        VALUES (p_nombre, p_apellido, p_telefono, p_direccion, p_email, p_dni);

        SET persona_existente_ID = LAST_INSERT_ID();

        -- Verificar si es un profesional
        IF p_es_profesional = 1 THEN
            -- Insertar nuevo registro en la tabla Profesional
            INSERT INTO archital.Profesional (persona_ID, matricula_profesional, curriculum_vitae, calificacion)
            VALUES (persona_existente_ID, p_matricula_profesional, p_curriculum_vitae, p_calificacion);
        ELSE
            -- Insertar nuevo registro en la tabla Cliente
            INSERT INTO archital.Cliente (persona_ID, condicion_fiscal_ID, cuit)
            VALUES (persona_existente_ID, p_condicion_fiscal_ID, p_cuit);
        END IF;
    END IF;
END $$


DELIMITER ;

-- # Ejemplos de llamadas:

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



