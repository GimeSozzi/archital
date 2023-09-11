-- ENTREGA PROYECTO FINAL: Base de datos Archital
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425


-- CREACIÓN DE BASE DE DATOS

-- Crear la base de datos (archital)
CREATE DATABASE IF NOT EXISTS archital;

-- Usar la base de datos (archital)
USE archital;


-- CREACIÓN DE TABLAS

-- Tabla Persona
CREATE TABLE IF NOT EXISTS archital.Persona (
    persona_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(120),
    email VARCHAR(120) NOT NULL,
    dni VARCHAR(20) NOT NULL
);

-- Tabla Profesional
CREATE TABLE IF NOT EXISTS archital.Profesional (
    profesional_ID INT PRIMARY KEY AUTO_INCREMENT,
    persona_ID INT NOT NULL,
    matricula_profesional VARCHAR(10),
    curriculum_vitae VARCHAR(255), -- Almacena la ruta del archivo en el sistema de archivos
    calificacion DECIMAL(3, 1) DEFAULT 1 CHECK (calificacion >= 1.0 AND calificacion <= 10.0),
    CONSTRAINT fk_profesional_persona
        FOREIGN KEY (persona_ID) REFERENCES archital.Persona(persona_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla CondicionFiscal
CREATE TABLE IF NOT EXISTS archital.CondicionFiscal (
    condicion_fiscal_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cond_fiscal VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla Cliente
CREATE TABLE IF NOT EXISTS archital.Cliente (
    cliente_ID INT PRIMARY KEY AUTO_INCREMENT,
    persona_ID INT NOT NULL,
    condicion_fiscal_ID INT NOT NULL,
    cuit VARCHAR(15),
    CONSTRAINT fk_cliente_persona
        FOREIGN KEY (persona_ID) REFERENCES archital.Persona(persona_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_cliente_condicionfiscal
        FOREIGN KEY (condicion_fiscal_ID) REFERENCES archital.CondicionFiscal(condicion_fiscal_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE        
);

-- Tabla EstadoProyecto
CREATE TABLE IF NOT EXISTS archital.EstadoProyecto (
    estado_proyecto_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_est_proyecto VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla Tipologia
CREATE TABLE IF NOT EXISTS archital.Tipologia (
    tipologia_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipologia VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla Proyecto
CREATE TABLE IF NOT EXISTS archital.Proyecto (
    proyecto_ID INT PRIMARY KEY AUTO_INCREMENT,
    cliente_ID INT NOT NULL,
    profesional_ID INT NOT NULL,
    estado_proyecto_ID INT NOT NULL,
    tipologia_ID INT DEFAULT 1,
    titulo VARCHAR(100) NOT NULL,
    superficie DECIMAL(11, 2) DEFAULT 0,
    cantidad_plantas INT DEFAULT 1,
    plano VARCHAR(255), -- Almacena la ruta del archivo en el sistema de archivos
    memoria_descriptiva TEXT,
    fecha_inicio DATE,
    fecha_finalizacion DATE,
    CONSTRAINT fk_proyecto_cliente
        FOREIGN KEY (cliente_ID) REFERENCES archital.Cliente(cliente_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_proyecto_profesional
        FOREIGN KEY (profesional_ID) REFERENCES archital.Profesional(profesional_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_proyecto_estado
        FOREIGN KEY (estado_proyecto_ID) REFERENCES archital.EstadoProyecto(estado_proyecto_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_proyecto_tipologia
        FOREIGN KEY (tipologia_ID) REFERENCES archital.Tipologia(tipologia_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE        
);

-- Tabla Especialidad
CREATE TABLE IF NOT EXISTS archital.Especialidad (
    especialidad_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_esp VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla ProfEspecialidad (intermedia)
CREATE TABLE IF NOT EXISTS archital.ProfEspecialidad (
    prof_esp_ID INT PRIMARY KEY AUTO_INCREMENT,
    profesional_ID INT NOT NULL,
    especialidad_ID INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_profesional_prof_esp
        FOREIGN KEY (profesional_ID) REFERENCES archital.Profesional(profesional_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_especialidad_prof_esp
        FOREIGN KEY (especialidad_ID) REFERENCES archital.Especialidad(especialidad_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla Habilidades
CREATE TABLE IF NOT EXISTS archital.Habilidades (
    habilidad_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_hab VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla ProfHabilidad (intermedia)
CREATE TABLE IF NOT EXISTS archital.ProfHabilidad (
    prof_hab_ID INT PRIMARY KEY AUTO_INCREMENT,
    profesional_ID INT NOT NULL,
    habilidad_ID INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_profesional_prof_hab
        FOREIGN KEY (profesional_ID) REFERENCES archital.Profesional(profesional_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_habilidad_prof_hab
        FOREIGN KEY (habilidad_ID) REFERENCES archital.Habilidades(habilidad_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla EstadoContrato
CREATE TABLE IF NOT EXISTS archital.EstadoContrato (
    estado_contrato_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_est_contrato VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla Contrato
CREATE TABLE IF NOT EXISTS archital.Contrato (
    contrato_ID INT PRIMARY KEY AUTO_INCREMENT,
    proyecto_ID INT NOT NULL,
    estado_contrato_ID INT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_contrato_proyecto
        FOREIGN KEY (proyecto_ID) REFERENCES archital.Proyecto(proyecto_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_contrato_estado
        FOREIGN KEY (estado_contrato_ID) REFERENCES archital.EstadoContrato(estado_contrato_ID)
);

-- Tabla EstadoPresupuesto
CREATE TABLE IF NOT EXISTS archital.EstadoPresupuesto (
    estado_pres_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_est_pres VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla Presupuesto
CREATE TABLE IF NOT EXISTS archital.Presupuesto (
    presupuesto_ID INT PRIMARY KEY AUTO_INCREMENT,
    proyecto_ID INT NOT NULL,
    estado_pres_ID INT NOT NULL DEFAULT 1,
    monto DECIMAL(11, 2) DEFAULT 0,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_presupuesto_proyecto
        FOREIGN KEY (proyecto_ID) REFERENCES archital.Proyecto(proyecto_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_presupuesto_estado
        FOREIGN KEY (estado_pres_ID) REFERENCES archital.EstadoPresupuesto(estado_pres_ID)
);

-- Tabla EstadoPago
CREATE TABLE IF NOT EXISTS archital.EstadoPago (
    estado_pago_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_est_pago VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla MetodoPago
CREATE TABLE IF NOT EXISTS archital.MetodoPago (
    metodo_pago_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_met_pago VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla Pagos
CREATE TABLE IF NOT EXISTS archital.Pagos (
    pago_ID INT PRIMARY KEY AUTO_INCREMENT,
    presupuesto_ID INT NOT NULL,
    estado_pago_ID INT NOT NULL,
    metodo_pago_ID INT NOT NULL DEFAULT 1,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_pagos_presupuesto
        FOREIGN KEY (presupuesto_ID) REFERENCES archital.Presupuesto(presupuesto_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_pagos_estado
        FOREIGN KEY (estado_pago_ID) REFERENCES archital.EstadoPago(estado_pago_ID),
    CONSTRAINT fk_pagos_metodo
        FOREIGN KEY (metodo_pago_ID) REFERENCES archital.MetodoPago(metodo_pago_ID)
);

-- Tabla Seguimiento
CREATE TABLE IF NOT EXISTS archital.Seguimiento (
    seguimiento_ID INT PRIMARY KEY AUTO_INCREMENT,
    proyecto_ID INT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    descripcion VARCHAR(150) NOT NULL,
    CONSTRAINT fk_seguimiento_proyecto
        FOREIGN KEY (proyecto_ID) REFERENCES archital.Proyecto(proyecto_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla Mensajes
CREATE TABLE IF NOT EXISTS archital.Mensajes (
    mensaje_ID INT PRIMARY KEY AUTO_INCREMENT,
    proyecto_ID INT NOT NULL,
    persona_ID INT NOT NULL,
    asunto VARCHAR(150) NOT NULL,
    texto_mensaje TEXT NOT NULL,
    fecha_mensaje TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT fk_mensajes_proyecto
        FOREIGN KEY (proyecto_ID) REFERENCES archital.Proyecto(proyecto_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_mensajes_persona
        FOREIGN KEY (persona_ID) REFERENCES archital.Persona(persona_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla LogProyecto
CREATE TABLE IF NOT EXISTS archital.LogProyecto(
    log_proyecto_ID INT PRIMARY KEY AUTO_INCREMENT,
    proyecto_ID INT NOT NULL,
    accion VARCHAR(10) NOT NULL,
    titulo_anterior VARCHAR(100),
    titulo_nuevo VARCHAR(100),
    superficie_anterior DECIMAL(11, 2),
    superficie_nueva DECIMAL(11, 2),
    cantidad_plantas_anterior INT,
    cantidad_plantas_nuevo INT,
    plano_anterior VARCHAR(255),
    plano_nuevo VARCHAR(255),
    memoria_descriptiva_anterior TEXT,
    memoria_descriptiva_nueva TEXT,
    fecha_inicio_anterior DATE,
    fecha_inicio_nueva DATE,
    fecha_finalizacion_anterior DATE,
    fecha_finalizacion_nueva DATE,
    cliente_ID_anterior INT,
    cliente_ID_nuevo INT,
    profesional_ID_anterior INT,
    profesional_ID_nuevo INT,
    estado_proyecto_ID_anterior INT,
    estado_proyecto_ID_nuevo INT,
    tipologia_ID_anterior INT,
    tipologia_ID_nueva INT,
    fecha_registro DATE NOT NULL,
    hora_registro TIME NOT NULL,
    usuario_accion VARCHAR(50) NOT NULL
    );

-- Tabla LogProfesional
CREATE TABLE IF NOT EXISTS archital.LogProfesional(
    log_profesional_ID INT PRIMARY KEY AUTO_INCREMENT,
    profesional_ID INT,
    accion VARCHAR(50),
    fecha_registro DATE NOT NULL,
    hora_registro TIME NOT NULL,
    usuario_accion VARCHAR(50) NOT NULL
    );

-- Tabla LogCliente   
CREATE TABLE IF NOT EXISTS archital.LogCliente(
    log_cliente_ID INT PRIMARY KEY AUTO_INCREMENT,
    cliente_ID INT,
    accion VARCHAR(50),
    fecha_registro DATE NOT NULL,
    hora_registro TIME NOT NULL,
    usuario_accion VARCHAR(50) NOT NULL
    );

-- Tabla LogSeguimiento
CREATE TABLE IF NOT EXISTS archital.LogSeguimiento(
    log_seguimiento_ID INT PRIMARY KEY AUTO_INCREMENT,
    seguimiento_ID INT,
    accion VARCHAR(50),
    fecha_registro DATE NOT NULL,
    hora_registro TIME NOT NULL,
    usuario_accion VARCHAR(50) NOT NULL
    );


-- INSERCIÓN DE DATOS

-- Inserción de datos en Tabla Persona
INSERT INTO archital.Persona (nombre, apellido, telefono, direccion, email, dni) VALUES
    ('Juan', 'Pérez', '01112345678', 'San Martín 456, Buenos Aires', 'juan.perez@netarq.com', '12345678'),
    ('María', 'González', '03511234567', 'Libertador 2345, Córdoba', 'maria.gonzalez@archital.com', '87654321'),
    ('Luis', 'López', '03411321456', '9 de Julio 789, Rosario', 'luis.lopez@house.com', '23456789'),
    ('Ana', 'Martínez', '02611234567', 'Belgrano 567, Mendoza', 'ana.martinez@clients.com', '34567890'),
    ('Diego', 'Rodríguez', '03871567890', 'Corrientes 890, Salta', 'diego.rodriguez@dominio.com', '45678901'),
    ('Carla', 'Hernández', '03814123456', 'Sarmiento 123, Tucumán', 'carla.hernandez@arcdes.com', '56789012'),
    ('Pedro', 'Gómez', '02231567890', 'Mitre 456, Mar del Plata', 'pedro.gomez@email.com', '67890123'),
    ('Sofía', 'Rivera', '03815123456', 'Lavalle 234, San Miguel de Tucumán', 'sofia.rivera@person.com', '78901234'),
    ('Alejandro', 'Silva', '02211567890', 'San Juan 567, La Plata', 'alejandro.silva@correo.com', '89012345'),
    ('Valentina', 'Torres', '03431567890', 'Pellegrini 890, Rosario', 'valentina.torres@correo.com', '90123456'),
    ('Gabriel', 'Rojas', '03511567890', '25 de Mayo 123, Córdoba', 'gabriel.rojas@correo.com', '12345678'),
    ('Fernando', 'Vargas', '02292567890', 'Belgrano 456, Tandil', 'fernando.vargas@correo.com', '23456789'),
    ('Lucía', 'Peralta', '03874567890', 'Corrientes 789, Salta', 'lucia.peralta@correo.com', '34567890'),
    ('Matías', 'Guerrero', '02231567890', 'Mendoza 234, Mar del Plata', 'matias.guerrero@dominio.com', '45678901'),
    ('Renata', 'Mendoza', '02991567890', '9 de Julio 567, Neuquén', 'renata.mendoza@dominio.com', '56789012'),
    ('Emilio', 'Cruz', '02611567890', 'San Martín 890, Mendoza', 'emilio.cruz@archital.com', '67890123'),
    ('Isabella', 'Orozco', '03431567890', 'Libertador 2345, Rosario', 'isabella.orozco@netarq.com', '78901234'),
    ('Santiago', 'Soto', '03511567890', 'Belgrano 567, Córdoba', 'santiago.soto@house.com', '89012345'),
    ('Camila', 'Luna', '02236567890', 'Sarmiento 890, Mar del Plata', 'camila.luna@clients.com', '90123456'),
    ('Nicolás', 'Mejía', '01112345678', 'Mitre 123, Buenos Aires', 'nicolas.mejia@dominio.com', '12345678'),
    ('Valeria', 'Castañeda', '03431567890', 'Corrientes 456, Tucumán', 'valeria.castaneda@correo.com', '23456789'),
    ('Maximiliano', 'Sánchez', '02611567890', 'Lavalle 789, Mendoza', 'maximiliano.sanchez@arcdes.com', '34567890'),
    ('Emilia', 'Delgado', '03511567890', 'San Juan 234, Rosario', 'emilia.delgado@email.com', '45678901'),
    ('Sebastián', 'Peña', '02231567890', 'Pellegrini 567, Buenos Aires', 'sebastian.pena@person.com', '56789012'),
    ('Antonella', 'Ríos', '03431567890', '25 de Mayo 890, Córdoba', 'antonella.rios@correo.com', '67890123'),
    ('Benjamín', 'Morales', '02231567890', 'Belgrano 234, Mendoza', 'benjamin.morales@correo.com', '78901234'),
    ('Javiera', 'Cortés', '03511567890', 'Corrientes 567, Rosario', 'javiera.cortes@dominio.com', '89012345'),
    ('Matías', 'Herrera', '03864567890', 'Mendoza 890, Tucumán', 'matias.herrera@correo.com', '90123456'),
    ('Trinidad', 'Moya', '03871567890', 'San Martín 123, Salta', 'trinidad.moya@correo.com', '12345678'),
    ('Laura', 'Gómez', '02991567890', 'Avenida 9 de Julio 456, Neuquén', 'laura.gomez@dominio.com', '67890123');

-- Insercion de datos en la Tabla Profesional 
INSERT INTO archital.Profesional (persona_ID, matricula_profesional, curriculum_vitae, calificacion) VALUES
    (16, 'M32331A', '/uploads/cv/cv_emiliocruz.pdf', 9.2),
    (17, 'B12343A', '/uploads/cv/isabellaocv.pdf', 8.0),
    (18, 'E98756C', '/uploads/cv/arqsotoscv.pdf', 7.1),
    (19, 'M25897D', '/uploads/cv/cv_arq_camilaluna.pdf', 6.8),
    (20, 'C78651E', '/uploads/cv/cvmejianicolas.pdf', 6.2),
    (21, 'D30694A', '/uploads/cv/cvcastanedav.pdf', 10.0),
    (22, 'M89651A', '/uploads/cv/cv_sanchezmax.pdf', 9.3),
    (23, 'F78923W', '/uploads/cv/delgadoemilia_resume.pdf', 7.6),
    (24, 'R78965A', '/uploads/cv/cv_pena.pdf', 8.2),
    (25, 'C01235P', '/uploads/cv/ariosarqcv.pdf', 7.9),
    (26, 'M98635S', '/uploads/cv/cv_moralesb.pdf', 8.0),
    (27, 'A04587D', '/uploads/cv/cortezj_cv.pdf', 5.7),
    (28, 'A12985G', '/uploads/cv/resume_herrera_arq.pdf', 6.9),
    (29, 'B55874V', '/uploads/cv/cv_trinidadmoya23.pdf', 9.1),
    (30, 'D11335C', '/uploads/cv/gomez_laura_cv.pdf', 8.3);

-- Inserción de datos en la Tabla CondicionFiscal
INSERT INTO archital.CondicionFiscal (nombre_cond_fiscal) VALUES
    ('Resp. Inscripto'),
    ('Resp. Monotributo'),
    ('Exento'),
    ('No Inscripto');

-- Inserción de datos en la Tabla Cliente
INSERT INTO archital.Cliente (persona_ID, condicion_fiscal_ID, cuit) VALUES
    (1, 1, '20123456781'),
    (2, 2, '27876543213'),
    (3, 2, '20234567892'),
    (4, 3, '27345678901'),
    (5, 4, '20456789013'),
    (6, 1, '27567890122'),
    (7, 1, '20678901234'),
    (8, 1, '27789012343'),
    (9, 2, '20890123455'),
    (10, 2, '27901234563'),
    (11, 1, '20123456786'),
    (12, 2, '20234567890'),
    (13, 3, '27345678900'),
    (14, 2, '20456789017'),
    (15, 1, '27567890124');

-- Inserción de datos en la Tabla EstadoProyecto
INSERT INTO archital.EstadoProyecto (nombre_est_proyecto) VALUES
    ('Pendiente'),
    ('Iniciado'),
    ('En proceso'),
    ('Finalizado');

-- Inserción de datos en la Tabla Tipología
INSERT INTO archital.Tipologia (nombre_tipologia) VALUES
    ('Residencial'),
    ('Comercial'),
    ('Hotel'),
    ('Deportivo'),
    ('Educación'),
    ('Salud'),
    ('Turismo'),
    ('Corporativo');    

-- Inserción de datos en la Tabla Proyecto
INSERT INTO archital.Proyecto (cliente_ID, profesional_ID, estado_proyecto_ID, tipologia_ID, titulo, superficie, cantidad_plantas, plano, memoria_descriptiva, fecha_inicio, fecha_finalizacion) VALUES
    (3, 1, 2, 1, 'Casa Moderna', 180.50, 2, '/uploads/plano/casa_moderna_plano.pdf', 'Una casa moderna con diseño minimalista.', '2023-01-15', NULL),
    (5, 2, 1, 2, 'Edificio Comercial', 850.75, 5, '/uploads/plano/edificio_comercial_final.dwg', 'Edificio comercial de 5 plantas con locales y oficinas.', '2023-02-10', NULL),
    (2, 3, 3, 1, 'Remodelación Residencial', 120.25, 1, '/uploads/plano/remodelacion_residencial_plan2.pdf', 'Remodelación de una casa antigua para adaptarla a un estilo moderno.', '2023-03-05', NULL),
    (12, 4, 1, 3, 'Hotel de Lujo', 1250.30, 10, '/uploads/plano/hotel_de_lujo_terminado.dwg', 'Diseño y construcción de un hotel de lujo con vista al mar.', '2023-04-20', NULL),
    (8, 5, 3, 4, 'Complejo Deportivo', 3000.00, 3, '/uploads/plano/complejo_deportivo_plan_1.pdf', 'Un complejo deportivo con canchas de tenis, piscina y gimnasio.', '2023-05-12', NULL),
    (11, 6, 3, 1, 'Departamentos Urbanos', 480.90, 6, '/uploads/plano/departamentos_urbanos.dwg', 'Construcción de un edificio de departamentos en el centro de la ciudad.', '2023-06-08', NULL),
    (14, 7, 3, 5, 'Centro Educativo', 750.00, 4, '/uploads/plano/centro_educativo_final2.pdf', 'Diseño y construcción de un centro educativo con salones y áreas recreativas.', '2023-07-18', NULL),
    (10, 8, 4, 1, 'Viviendas Sustentables', 320.45, 2, '/uploads/plano/viviendas_sustentables.dwg', 'Proyecto de viviendas eco-friendly con sistemas de energía solar.', '2023-08-03', '2024-05-10'),
    (6, 9, 2, 2, 'Oficinas Corporativas', 1620.70, 7, '/uploads/plano/oficinas_corporativas_planta.pdf', 'Construcción de oficinas corporativas con diseño vanguardista.', '2023-07-15', NULL),
    (7, 10, 3, 6, 'Centro Médico', 900.80, 5, '/uploads/plano/centro_medico_plan_1.dwg', 'Un moderno centro médico con tecnología de punta.', '2023-01-22', NULL),
    (13, 11, 3, 1, 'Casa de Playa', 200.00, 1, '/uploads/plano/casa_de_playa_plan_2.pdf', 'Diseño de una casa de playa con acceso directo al mar.', '2023-03-05', NULL),
    (9, 12, 1, 7, 'Complejo Turístico', 1800.00, 8, '/uploads/plano/complejo_turistico_planimetria.dwg', 'Proyecto de un complejo turístico con cabañas y áreas recreativas.', '2023-06-10', NULL),
    (1, 13, 4, 2, 'Centro Comercial', 1200.25, 6, '/uploads/plano/centro_comercial_plantasyelevaciones.pdf', 'Construcción de un centro comercial con diversas tiendas y restaurantes.', '2023-01-08', '2023-05-20'),
    (15, 14, 3, 4, 'Estadio Deportivo', 4500.00, 1, '/uploads/plano/estadio_deportivo_finalll.dwg', 'Diseño y construcción de un estadio deportivo con capacidad para 30,000 personas.', '2023-02-20', NULL),
    (4, 15, 4, 1, 'Torre Residencial', 3560.60, 15, '/uploads/plano/torre_residencial_planos.pdf', 'Proyecto de una torre residencial de lujo con impresionantes vistas.', '2022-03-15', '2023-06-10');

-- Inserción de datos en la Tabla Especialidad
INSERT INTO archital.Especialidad (nombre_esp) VALUES
    ('Arq. Residencial'),
    ('Arq. Hospitalaria'),
    ('Arq. Comercial'),
    ('Arq. Corporativa'),
    ('Arq. Turistica'),
    ('Arq. Deportiva'),
    ('Paisajismo'),
    ('Urbanismo'),
    ('Interiorismo'),
    ('Restauracion'),
    ('Eficiencia Energetica'),
    ('Infoarquitectura'),
    ('Gestion BIM');

-- Insercion de datos en la Tabla ProfEspecialidad (intermedia)
INSERT INTO archital.ProfEspecialidad (profesional_ID, especialidad_ID) VALUES
    (1, 1),
    (1, 9),
    (2, 1),
    (2, 3),
    (2, 13),
    (3, 1),
    (4, 1),
    (4, 5),
    (5, 6),
    (6, 1),
    (6, 12),
    (7, 1),
    (7, 4),
    (7, 9),
    (7, 11),
    (8, 1),
    (8, 11),
    (8, 13),
    (9, 4),
    (9, 2),
    (10, 6),
    (11, 1),
    (11, 5),
    (11, 7),
    (12, 5),
    (13, 3),
    (14, 1),
    (14, 8),
    (15, 1),
    (15, 10),
    (15, 13);

-- Inserción de datos en la Tabla Habilidades
INSERT INTO archital.Habilidades (nombre_hab) VALUES
    ('AutoCAD'),
    ('Revit'),
    ('ArchiCAD'),
    ('3DMax'),
    ('Sketchup'),
    ('Rhino'),
    ('Lumion'),
    ('Blender'),
    ('Corona'),
    ('Vray'),
    ('Unreal Engine'),
    ('Vectorworks'),
    ('Allplan'),
    ('Photoshop');

-- Inserción de datos en la Tabla ProfHabilidad (intermedia)
INSERT INTO archital.ProfHabilidad (profesional_ID, habilidad_ID) VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 5),
    (3, 1),
    (3, 5),
    (3, 14),
    (4, 1),
    (4, 7),
    (5, 1),
    (5, 2),
    (5, 9),
    (6, 1),
    (6, 2),
    (6, 4),
    (6, 7),
    (6, 10),
    (6, 11),
    (6, 14),
    (7, 1),
    (7, 5),
    (8, 1),
    (8, 2),
    (8, 5),
    (9, 1),
    (9, 8),
    (10, 1),
    (10, 4),
    (10, 9),
    (11, 1),
    (12, 1),
    (12, 3),
    (12, 7),
    (13, 1),
    (14, 1),
    (15, 1),
    (15, 6);

-- Inserción de datos en la Tabla EstadoContrato
INSERT INTO archital.EstadoContrato (nombre_est_contrato) VALUES
    ('Pendiente'),
    ('Firmado');

-- Inserción de datos en la Tabla Contrato
INSERT INTO archital.Contrato (proyecto_ID, estado_contrato_ID) VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 1),
    (5, 1),
    (6, 2),
    (7, 2),
    (8, 1),
    (9, 1),
    (10, 1),
    (11, 1),
    (12, 1),
    (13, 2),
    (14, 2),
    (15, 1);

-- Inserción de datos en la Tabla EstadoPresupuesto
INSERT INTO archital.EstadoPresupuesto (nombre_est_pres) VALUES
    ('No enviado'),
    ('Enviado'),
    ('Aceptado'),
    ('Rechazado');

-- Inserción de datos en la Tabla Presupuesto
INSERT INTO archital.Presupuesto (proyecto_ID, estado_pres_ID, monto) VALUES
    (1, 1, NULL),
    (2, 2, 250000.00),
    (3, 2, 500000.00),
    (4, 2, 100000.00),
    (5, 2, 498200.00),
    (6, 2, 169000.00),
    (7, 2, 310000.00),
    (8, 3, 805100.00),
    (9, 2, 700000.00),
    (10, 2, 253700.00),
    (11, 2, 680000.00),
    (12, 1, NULL),
    (13, 3, 450000.00),
    (14, 2, 324000.00),
    (15, 2, 128900.00);

-- Inserción de datos en la Tabla EstadoPago
INSERT INTO archital.EstadoPago (nombre_est_pago) VALUES
    ('Pendiente'),
    ('Completado');


-- Inserción de datos en la Tabla MetodoPago
INSERT INTO archital.MetodoPago (nombre_met_pago) VALUES
    ('Transferencia'),
    ('Tarjeta de Debito'),
    ('Tarjeta de Credito'),
    ('PayPal');

-- Inserción de datos en la Tabla Pagos
INSERT INTO archital.Pagos (presupuesto_ID, estado_pago_ID, metodo_pago_ID) VALUES
     (8, 2, 1),
     (13, 2, 1),
     (15, 1, 1);

-- Inserción de datos en la Tabla Seguimiento
INSERT INTO archital.Seguimiento (proyecto_ID, descripcion) VALUES
     (5, 'Anteproyecto terminado. Se inicia Proyecto.'),
     (6, 'Plano de arquitectura finalizado. Se inicia estructura.'),
     (7, 'Plano de instalaciones eléctricas iniciado.'),
     (10, 'Anteproyecto iniciado.'),
     (11, 'Anteproyecto terminado.'),
     (14, 'Plano sistema contra incendios y señaletica terminado.');

-- Inserción de datos en la Tabla de Mensajes
INSERT INTO archital.Mensajes (proyecto_ID, persona_ID, asunto, texto_mensaje) VALUES
    (1, 3, 'Consulta honorarios', 'Hola, antes que me envies el presupuesto. Quisiera saber si cobras por hora o proyecto. Saludos'),
    (1, 1, 'Rta. Honorarios', 'Buenas tardes, mis honorarios son en base a los m2 del proyecto. Saludos Cordiales'),
    (8, 8, '', 'El proyecto quedo expectacular. Felicitaciones y muchas gracias! Saludos'),
    (14, 15, 'Aumentar escala', 'Buen dia, descargué la imagen del anteproyecto peor la escala no me permite leer las cotas. Podrias enviarla en 1:20. Gracias');


-- CREACIÓN DE VISTAS

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


-- CREACIÓN DE FUNCIONES

DELIMITER $$

-- Funcion 1 "f_obtener_info_proyecto_por_id": se utiliza para obtener informacion de un proyecto por su ID:

CREATE FUNCTION f_obtener_info_proyecto_por_id(proy_ID INT)
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

-- Funcion 2 "f_honorarios_estimado_proyecto": se utiliza para obtener el honorario estimado de un proyecto ingresando el valor de la hora fecha estimada de inicio y fecha estimada de finalizacion:

CREATE FUNCTION f_honorarios_estimado_proyecto(valor_hora DECIMAL(11, 2), fecha_estimada_inicio DATE, fecha_estimada_finalizacion DATE) 
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


-- CREACIÓN DE STORED PROCEDURES

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

    -- Definir un manejador de errores para SQLEXCEPTION
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

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
    PREPARE mi_consulta FROM @consulta_sql;
    EXECUTE mi_consulta;
    DEALLOCATE PREPARE mi_consulta;

    COMMIT;

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

    -- Definir un manejador de errores para SQLEXCEPTION
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

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

    COMMIT;
END $$

DELIMITER ;


-- CREACIÓN DE TRIGGERS

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
