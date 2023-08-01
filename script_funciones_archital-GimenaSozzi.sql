-- DESAFIO ENTREGABLE: Script de Creación de Funciones
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/script_inserciondatos_archital-GimenaSozzi.sql


DELIMITER $$

-- Funcion para obtener informacion de un proyecto por su ID:

CREATE FUNCTION obtener_info_proyecto_por_id(proy_ID INT)
RETURNS TEXT
READS SQL DATA
BEGIN
    DECLARE proyecto_info TEXT;
    SELECT CONCAT('Título: ', titulo, '\n'
                  'Cliente: ', pc.nombre, ' ', pc.apellido, '\n'
                  'Profesional: ', pp.nombre, ' ', pp.apellido, '\n'
                  'Estado del proyecto: ', epro.nombre_est_proyecto, '\n'
                  'Tipología: ', tip.nombre_tipologia, '\n'
                  'Superficie: ', superficie, '\n'
                  'Cantidad de plantas: ', cantidad_plantas, '\n'
                  'Memoria descriptiva: ', IFNULL(memoria_descriptiva, 'No disponible'), '\n'
                  'Fecha de inicio: ', fecha_inicio, '\n'
                  'Fecha de finalización: ', IFNULL(fecha_finalizacion, 'No disponible'))
    INTO proyecto_info
    FROM archital.Proyecto AS proy
    JOIN archital.Persona pc ON proy.cliente_ID = pc.persona_ID
    JOIN archital.Persona pp ON proy.profesional_ID = pp.persona_ID
    JOIN archital.EstadoProyecto AS epro ON proy.estado_proyecto_ID = epro.estado_proyecto_ID
    JOIN archital.Tipologia AS tip ON proy.tipologia_ID = tip.tipologia_ID
    WHERE proy.proyecto_ID = proy_ID;

    RETURN proyecto_info;
END $$


-- Funcion para obtener el honorario estimado de un proyecto ingresando el valor de la hora fecha estimada de inicio y fecha estimada de finalizacion:

CREATE FUNCTION honorarios_estimado_proyecto(valor_hora DECIMAL(11, 2), fecha_estimada_inicio DATE, fecha_estimada_finalizacion DATE) 
RETURNS DECIMAL(11, 2)
NO SQL
BEGIN
    DECLARE dias_estimados INT;
    DECLARE semanas_completas INT;
    DECLARE dias_adicionales INT;
    DECLARE honorario_estimado DECIMAL(11, 2);
    DECLARE result VARCHAR(100);

    SET dias_estimados = DATEDIFF(fecha_estimada_finalizacion, fecha_estimada_inicio); -- Calcula la diferencia en días entre la fecha estimada de finalizacion y la fecha estimada de inicio.
    SET dias_estimados = GREATEST(dias_estimados, 0); -- Asegura que días_estimados no sea negativo.
    
    SET semanas_completas = FLOOR(dias_estimados / 7); -- Calcula el número de semanas completas (redondea para abajo en el caso de sean menos de 7 dias)
    SET dias_adicionales = dias_estimados MOD 7; -- Calcula los días adicionales 
    
    SET dias_adicionales = LEAST(dias_adicionales, 5); -- Limita los días adicionales a un máximo de 5 (días laborables a la semana).
    
    SET honorario_estimado = valor_hora * ((semanas_completas * 5) + dias_adicionales) * 8; -- Multiplica por 8 horas laborables por día.

    RETURN honorario_estimado;
END $$

DELIMITER ;


-- Ejemplos de uso:

-- SELECT obtener_info_proyecto_por_id(5) AS informacion_de_proyecto;
-- SELECT honorarios_estimado_proyecto(35, '2023-08-01', '2023-10-05') AS honorario_estimado;
