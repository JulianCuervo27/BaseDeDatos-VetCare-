DROP DATABASE IF EXISTS vetcare;
CREATE DATABASE vetcare;
USE vetcare;
CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(15) UNIQUE,
  direccion VARCHAR(150)
);
CREATE TABLE mascotas (
  id_mascota INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especie VARCHAR(50) NOT NULL,
  raza VARCHAR(50),
  edad INT,
  id_cliente INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE veterinarios (
  id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especialidad VARCHAR(100),
  telefono VARCHAR(15)
);
CREATE TABLE citas (
  id_cita INT AUTO_INCREMENT PRIMARY KEY,
  id_mascota INT NOT NULL,
  id_veterinario INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  motivo VARCHAR(150),
  FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  tipo VARCHAR(50),
  precio DECIMAL(10,2) NOT NULL CHECK (precio > 0)
);
CREATE TABLE ventas (
  id_venta INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  fecha DATE DEFAULT (CURRENT_DATE),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE detalle_venta (
  id_venta INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT DEFAULT 1 CHECK (cantidad > 0),
  PRIMARY KEY (id_venta, id_producto),
  FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
INSERT INTO clientes (nombre, telefono, direccion) VALUES
('Laura Gómez', '3101234567', 'Calle 10 #5-20'),
('Andrés Ruiz', '3129876543', 'Carrera 45 #23-15'),
('Sofía López', '3009988776', 'Av. Central #45-60'),
('Carlos Díaz', '3116677889', 'Calle 80 #10-33'),
('Valentina Rojas', '3005566778', 'Carrera 7 #65-12');
INSERT INTO mascotas (nombre, especie, raza, edad, id_cliente) VALUES
('Luna', 'Perro', 'Golden Retriever', 3, 1),
('Milo', 'Gato', 'Siames', 2, 2),
('Rocky', 'Perro', 'Bulldog', 5, 3),
('Nala', 'Gato', 'Persa', 4, 4),
('Toby', 'Perro', 'Beagle', 1, 5);
INSERT INTO veterinarios (nombre, especialidad, telefono) VALUES
('Dr. Fernando Pérez', 'Medicina General', '3151122334'),
('Dra. Catalina Torres', 'Cirugía', '3105566778');
INSERT INTO citas (id_mascota, id_veterinario, fecha, hora, motivo) VALUES
(1, 1, '2025-10-09', '10:00:00', 'Vacunación anual'),
(2, 2, '2025-10-10', '11:30:00', 'Esterilización'),
(3, 1, '2025-10-11', '09:00:00', 'Chequeo general'),
(4, 1, '2025-10-12', '14:00:00', 'Control de peso'),
(5, 2, '2025-10-13', '15:30:00', 'Corte de uñas');
INSERT INTO productos (nombre, tipo, precio) VALUES
('Concentrado Premium', 'Alimento', 85000),
('Juguete Pelota', 'Accesorio', 15000),
('Collar Antipulgas', 'Medicina', 25000),
('Cama Pequeña', 'Accesorio', 60000),
('Shampoo Canino', 'Higiene', 22000);
INSERT INTO ventas (id_cliente, fecha) VALUES
(1, '2025-10-09'),
(2, '2025-10-09'),
(3, '2025-10-10'),
(4, '2025-10-10'),
(5, '2025-10-11');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 1),
(4, 5, 3),
(5, 1, 1);
-- Verificar conteo de registros
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(*) AS total_mascotas FROM mascotas;
SELECT COUNT(*) AS total_citas FROM citas;
SELECT COUNT(*) AS total_productos FROM productos;
SELECT COUNT(*) AS total_ventas FROM ventas;

-- Mostrar primeros registros
SELECT * FROM clientes LIMIT 5;
SELECT * FROM mascotas LIMIT 5;
SELECT * FROM citas LIMIT 5;

SELECT 
  c.id_cita,
  m.nombre AS mascota,
  cl.nombre AS cliente,
  v.nombre AS veterinario,
  c.fecha,
  c.hora,
  c.motivo
FROM citas c
JOIN mascotas m ON c.id_mascota = m.id_mascota
JOIN clientes cl ON m.id_cliente = cl.id_cliente
JOIN veterinarios v ON c.id_veterinario = v.id_veterinario;

SELECT 
  v.id_venta,
  cl.nombre AS cliente,
  p.nombre AS producto,
  d.cantidad,
  p.precio,
  (p.precio * d.cantidad) AS total_producto
FROM ventas v
JOIN clientes cl ON v.id_cliente = cl.id_cliente
JOIN detalle_venta d ON v.id_venta = d.id_venta
JOIN productos p ON d.id_producto = p.id_producto;
SELECT 
  cl.nombre AS cliente,
  SUM(p.precio * d.cantidad) AS total_gastado
FROM clientes cl
JOIN ventas v ON cl.id_cliente = v.id_cliente
JOIN detalle_venta d ON v.id_venta = d.id_venta
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY cl.nombre
ORDER BY total_gastado DESC;

