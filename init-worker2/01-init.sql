-- Configurar para aceptar conexiones
ALTER SYSTEM SET listen_addresses = '*';

-- Crear las tablas para las ciudades de Trujillo y Cusco
CREATE TABLE medico_trujillo (
    DNI VARCHAR(8),
    Nombre VARCHAR(50),
    Apellidos VARCHAR(100),
    Especialidad VARCHAR(50),
    NumColegiado VARCHAR(20),
    CentroSalud VARCHAR(100),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Trujillo'),
    PRIMARY KEY (DNI, Ciudad)
);

CREATE TABLE medico_cusco (
    DNI VARCHAR(8),
    Nombre VARCHAR(50),
    Apellidos VARCHAR(100),
    Especialidad VARCHAR(50),
    NumColegiado VARCHAR(20),
    CentroSalud VARCHAR(100),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Cusco'),
    PRIMARY KEY (DNI, Ciudad)
);

CREATE TABLE diagnostico_trujillo (
    Id SERIAL,
    DNI_Paciente VARCHAR(8),
    DNI_Medico VARCHAR(8),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Trujillo'),
    Diagnostico TEXT,
    Peso DECIMAL(5,2),
    Edad INTEGER,
    Sexo CHAR(1),
    PRIMARY KEY (Id, Ciudad),
    FOREIGN KEY (DNI_Medico, Ciudad) REFERENCES medico_trujillo(DNI, Ciudad)
);

CREATE TABLE diagnostico_cusco (
    Id SERIAL,
    DNI_Paciente VARCHAR(8),
    DNI_Medico VARCHAR(8),
    Ciudad VARCHAR(50) CHECK (Ciudad = 'Cusco'),
    Diagnostico TEXT,
    Peso DECIMAL(5,2),
    Edad INTEGER,
    Sexo CHAR(1),
    PRIMARY KEY (Id, Ciudad),
    FOREIGN KEY (DNI_Medico, Ciudad) REFERENCES medico_cusco(DNI, Ciudad)
);

-- Insertar datos correspondientes a Trujillo y Cusco
INSERT INTO medico_trujillo 
SELECT DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad 
FROM (VALUES
    ('34567890', 'Carlos', 'Rodríguez', 'Neurología', 'NEU001', 'Hospital Regional', 'Trujillo')
) AS datos(DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad);

INSERT INTO medico_cusco
SELECT DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad 
FROM (VALUES
    ('56789012', 'Pedro', 'López', 'Oftalmología', 'OFT001', 'Clínica Visual', 'Cusco')
) AS datos(DNI, Nombre, Apellidos, Especialidad, NumColegiado, CentroSalud, Ciudad);

-- Insertar diagnósticos correspondientes
INSERT INTO diagnostico_trujillo (DNI_Paciente, DNI_Medico, Ciudad, Diagnostico, Peso, Edad, Sexo) 
VALUES
    ('33333333', '34567890', 'Trujillo', 'Migraña', 70.2, 35, 'F');

INSERT INTO diagnostico_cusco (DNI_Paciente, DNI_Medico, Ciudad, Diagnostico, Peso, Edad, Sexo) 
VALUES
    ('55555555', '56789012', 'Cusco', 'Conjuntivitis', 65.5, 50, 'M');