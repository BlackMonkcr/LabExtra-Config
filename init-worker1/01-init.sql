-- Configurar para aceptar conexiones
ALTER SYSTEM SET listen_addresses = '*';

-- Crear las tablas para las ciudades de Lima y Arequipa
CREATE TABLE medico_lima (
    DNI VARCHAR(8),
    Nombre VARCHAR(50),
    Apellidos VARCHAR(100),
    Especialidad VARCHAR(50),
    NumColegiado VARCHAR(20),
    CentroSalud VARCHAR(100),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Lima'),
    PRIMARY KEY (DNI, Ciudad)
);

CREATE TABLE medico_arequipa (
    DNI VARCHAR(8),
    Nombre VARCHAR(50),
    Apellidos VARCHAR(100),
    Especialidad VARCHAR(50),
    NumColegiado VARCHAR(20),
    CentroSalud VARCHAR(100),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Arequipa'),
    PRIMARY KEY (DNI, Ciudad)
);

CREATE TABLE diagnostico_lima (
    Id SERIAL,
    DNI_Paciente VARCHAR(8),
    DNI_Medico VARCHAR(8),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Lima'),
    Diagnostico TEXT,
    Peso DECIMAL(5,2),
    Edad INTEGER,
    Sexo CHAR(1),
    PRIMARY KEY (Id, Ciudad),
    FOREIGN KEY (DNI_Medico, Ciudad) REFERENCES medico_lima(DNI, Ciudad)
);

CREATE TABLE diagnostico_arequipa (
    Id SERIAL,
    DNI_Paciente VARCHAR(8),
    DNI_Medico VARCHAR(8),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Arequipa'),
    Diagnostico TEXT,
    Peso DECIMAL(5,2),
    Edad INTEGER,
    Sexo CHAR(1),
    PRIMARY KEY (Id, Ciudad),
    FOREIGN KEY (DNI_Medico, Ciudad) REFERENCES medico_arequipa(DNI, Ciudad)
);

-- Insertar datos correspondientes a Lima y Arequipa
INSERT INTO medico_lima 
SELECT DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad 
FROM (VALUES
    ('12345678', 'Juan', 'Pérez', 'Cardiología', 'CAR001', 'Hospital Central', 'Lima'),
    ('45678901', 'Ana', 'Martínez', 'Dermatología', 'DER001', 'Centro Médico', 'Lima')
) AS datos(DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad);

INSERT INTO medico_arequipa
SELECT DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad 
FROM (VALUES
    ('23456789', 'María', 'González', 'Pediatría', 'PED001', 'Clínica San Juan', 'Arequipa')
) AS datos(DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad);

-- Insertar diagnósticos correspondientes
INSERT INTO diagnostico_lima (DNI_Paciente, DNI_Medico, Ciudad, Diagnostico, Peso, Edad, Sexo) 
VALUES
    ('11111111', '12345678', 'Lima', 'Hipertensión', 75.5, 45, 'M'),
    ('44444444', '45678901', 'Lima', 'Dermatitis', 80.0, 28, 'M');

INSERT INTO diagnostico_arequipa (DNI_Paciente, DNI_Medico, Ciudad, Diagnostico, Peso, Edad, Sexo) 
VALUES
    ('22222222', '23456789', 'Arequipa', 'Gripe', 68.0, 12, 'F');