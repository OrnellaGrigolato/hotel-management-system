-- Create tables
CREATE TABLE habitacion(
    id SERIAL PRIMARY KEY,
    numerodehabitacion INTEGER NOT NULL,
    preciopornoche INTEGER NOT NULL,
    tipo VARCHAR(15) NOT NULL
);

CREATE TABLE huesped (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    documento VARCHAR(15) NOT NULL
);

CREATE TABLE reserva (
    id SERIAL PRIMARY KEY,
    fecha_de_ingreso DATE NOT NULL,
    fecha_de_salida DATE NOT NULL,
    preciototal INTEGER NOT NULL,
    habitacion INTEGER REFERENCES habitacion(id) ON DELETE CASCADE,
    huesped INTEGER REFERENCES huesped(id)  ON DELETE CASCADE
);

-- Insert sample rooms
INSERT INTO habitacion (numerodehabitacion, tipo, preciopornoche) VALUES
(101, 'Simple', 50),
(102, 'Simple', 50),
(201, 'Doble', 80),
(202, 'Doble', 80),
(301, 'Suite', 150);

-- Insert sample guests
INSERT INTO huesped (documento, nombre, telefono) VALUES
('12345678', 'Juan Pérez', '+54555350101'),
('87654321', 'María García', '+5434220102'),
('11223344', 'Carlos López', '+54115010352');

-- Insert sample reservations
INSERT INTO reserva (fecha_de_ingreso, fecha_de_salida, preciototal, habitacion, huesped) VALUES
('2025-12-01', '2025-12-05', 200, 1, 1),
('2025-12-10', '2025-12-15', 400, 3, 2);
