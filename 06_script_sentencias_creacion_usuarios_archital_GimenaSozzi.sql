-- DESAFIO COMPLEMENTARIO: Script de implementacion de Sentencias - Creación de usuarios y permisos
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- PRIMERO CORRER EL SCRIPT DE CREACION DE DATABASE, TABLAS E INSERCION DE DATOS: https://github.com/GimeSozzi/archital/blob/main/segunda_pre_entrega_proyecto_final/01_script_inserciondatos_archital-GimenaSozzi.sql

-- Conectar a MySQL como un usuario con privilegios de administración
USE Mysql;

-- Crear usuarios
CREATE USER 'archi_user1'@'localhost' IDENTIFIED BY 'archital1';
CREATE USER 'archi_user2'@'localhost' IDENTIFIED BY 'archital2';

-- Otorgar permisos de solo lectura a archi_user1 en todas las tablas de la base de datos
GRANT SELECT ON archital.* TO 'archi_user1'@'localhost';

-- Otorgar permisos de lectura, inserción y modificación a archi_user2 en todas las tablas de la base de base de datos
GRANT SELECT, INSERT, UPDATE ON archital.* TO 'archi_user2'@'localhost';

-- Verificar permisos establecidos para usuario: 'archi_user1'@'localhost'
SHOW GRANTS FOR 'archi_user1'@'localhost'; 

-- Verificar permisos establecidos para usuario: 'archi_user2'@'localhost'
SHOW GRANTS FOR 'archi_user2'@'localhost'; 

-- Ejemplos de uso usuario: 'archi_user1'@'localhost'
--
-- SELECT * FROM archital.Persona;
--
-- SELECT * FROM archital.Profesional;
-- 
-- INSERT INTO archital.Persona (nombre, apellido, telefono, direccion, email, dni) VALUES
--    ('Marcelo', 'Ortiz', '01112345678', 'Junin 456, Buenos Aires', 'ortizm@netarq.com', '11111111');
--
-- UPDATE archital.Persona SET nombre = 'Pepe'
-- WHERE persona_ID = 1;
--
-- DELETE FROM archital.Profesional
-- WHERE profesional_ID = 3;



-- Ejemplos de uso usuario: 'archi_user2'@'localhost'
--
-- SELECT * FROM archital.Persona;
--
-- SELECT * FROM archital.Profesional;
-- 
-- INSERT INTO archital.Persona (nombre, apellido, telefono, direccion, email, dni) VALUES
--    ('Marcelo', 'Ortiz', '01112345678', 'Junin 456, Buenos Aires', 'ortizm@netarq.com', '11111111');
--
-- SELECT * FROM archital.Persona;
--
-- UPDATE archital.Persona SET nombre = 'Pepe'
-- WHERE persona_ID = 1;
--
-- SELECT * FROM archital.Persona;
--
-- DELETE FROM archital.Profesional
-- WHERE profesional_ID = 3;
