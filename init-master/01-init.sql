-- Habilitar las extensiones necesarias
CREATE EXTENSION postgres_fdw;
CREATE EXTENSION dblink;

-- Crear los servidores foráneos
CREATE SERVER worker1_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'postgres-worker1', port '5432', dbname 'distribuida_db');

CREATE SERVER worker2_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'postgres-worker2', port '5432', dbname 'distribuida_db');

-- Crear los user mappings
CREATE USER MAPPING FOR postgres
SERVER worker1_server
OPTIONS (user 'postgres', password 'mysecretpassword');

CREATE USER MAPPING FOR postgres
SERVER worker2_server
OPTIONS (user 'postgres', password 'mysecretpassword');

-- Crear los esquemas
CREATE SCHEMA worker1;
CREATE SCHEMA worker2;