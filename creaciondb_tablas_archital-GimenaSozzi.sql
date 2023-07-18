-- PRIMERA PRE ENTREGA PROYECTO FINAL
-- Curso: SQL
-- Alumna: Gimena Sozzi
-- Comision: #43425

-- CREACION DE BASE DE DATOS Y TABLAS

-- Crear la base de datos (archital)
CREATE DATABASE IF NOT EXISTS archital;

-- Usar la base de datos (archital)
USE archital;

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
    curriculum_vitae BLOB,
    calificacion DECIMAL(3, 1) DEFAULT 1 CHECK (calificacion >= 1.0 AND calificacion <= 10.0),
    CONSTRAINT fk_profesional_persona
        FOREIGN KEY (persona_ID) REFERENCES archital.Persona(persona_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla Cliente
CREATE TABLE IF NOT EXISTS archital.Cliente (
    cliente_ID INT PRIMARY KEY AUTO_INCREMENT,
    persona_ID INT NOT NULL,
    condicion_fiscal VARCHAR(30),
    cuit VARCHAR(15),
    CONSTRAINT fk_cliente_persona
        FOREIGN KEY (persona_ID) REFERENCES archital.Persona(persona_ID)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

-- Tabla EstadoProyecto
CREATE TABLE IF NOT EXISTS archital.EstadoProyecto (
    estado_proyecto_ID INT PRIMARY KEY AUTO_INCREMENT,
    nombre_est_proyecto VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla Proyecto
CREATE TABLE IF NOT EXISTS archital.Proyecto (
    proyecto_ID INT PRIMARY KEY AUTO_INCREMENT,
    cliente_ID INT NOT NULL,
    profesional_ID INT NOT NULL,
    estado_proyecto_ID INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    tipologia VARCHAR(30),
    superficie DECIMAL(11, 2) DEFAULT 0,
    cantidad_plantas INT DEFAULT 1,
    plano BLOB,
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
    especialidad_ID INT NOT NULL,
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
    habilidad_ID INT NOT NULL,
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
    estado_pres_ID INT NOT NULL,
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
    nombre_met_pago VARCHAR(15) NOT NULL UNIQUE
);

-- Tabla Pagos
CREATE TABLE IF NOT EXISTS archital.Pagos (
    pago_ID INT PRIMARY KEY AUTO_INCREMENT,
    presupuesto_ID INT NOT NULL,
    estado_pago_ID INT NOT NULL,
    metodo_pago_ID INT NOT NULL,
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


