-- ============================================================
-- Dataset: Tienda
-- Datos de prueba
-- Ejecutar DESPUÉS de tienda_schema.sql
-- ============================================================

INSERT INTO categorias (id, nombre) VALUES
    (1, 'Tecnología'),
    (2, 'Hogar'),
    (3, 'Ropa'),
    (4, 'Alimentos');

INSERT INTO proveedores (id, nombre, ciudad, telefono) VALUES
    (1, 'TecnoSupply S.A.S.',        'Bogotá',       '601-555-0101'),
    (2, 'HogarPlus Ltda.',           'Medellín',     '604-555-0102'),
    (3, 'Textiles del Caribe',       'Barranquilla', '605-555-0103'),
    (4, 'Distribuidora La Costa',    'Cartagena',    '605-555-0104'),
    (5, 'Importados Andinos',        'Cali',         '602-555-0105');

INSERT INTO productos (id, nombre, precio, stock, id_categoria, id_proveedor) VALUES
    (1,  'Laptop Pro 14',            3200000.00,  15, 1, 1),
    (2,  'Mouse Inalámbrico',           85000.00, 120, 1, 1),
    (3,  'Teclado Mecánico',           220000.00,  60, 1, 1),
    (4,  'Monitor 27 pulgadas',        950000.00,  25, 1, 5),
    (5,  'Audífonos Bluetooth',        180000.00,  80, 1, 1),
    (6,  'Silla Ergonómica',           650000.00,  30, 2, 2),
    (7,  'Escritorio de Madera',       480000.00,  18, 2, 2),
    (8,  'Lámpara LED',                 75000.00,  90, 2, 2),
    (9,  'Cafetera',                   150000.00,  40, 2, 5),
    (10, 'Juego de Sábanas',           120000.00,  55, 2, 2),
    (11, 'Camisa Casual',               65000.00, 100, 3, 3),
    (12, 'Jean Clásico',               110000.00,  70, 3, 3),
    (13, 'Chaqueta Impermeable',       240000.00,  35, 3, 3),
    (14, 'Zapatos Deportivos',         190000.00,  45, 3, 5),
    (15, 'Gorra',                       45000.00, 150, 3, 3),
    (16, 'Café Molido 500g',            28000.00, 200, 4, 4),
    (17, 'Panela 500g',                 12000.00, 300, 4, 4),
    (18, 'Arroz 5kg',                   32000.00, 180, 4, 4),
    (19, 'Aceite 1L',                   18000.00, 140, 4, 4),
    (20, 'Chocolate 500g',              22000.00, 160, 4, 4);

INSERT INTO clientes (id, nombre, apellido, email, ciudad, fecha_registro) VALUES
    (1,  'Andrés',    'Pérez',     'andres.perez@mail.com',    'Barranquilla', '2024-11-05'),
    (2,  'Camila',    'Romero',    'camila.romero@mail.com',   'Cartagena',    '2024-11-18'),
    (3,  'Daniel',    'Ospina',    'daniel.ospina@mail.com',   'Medellín',     '2024-12-02'),
    (4,  'Valentina', 'Cruz',      'valentina.cruz@mail.com',  'Santa Marta',  '2024-12-15'),
    (5,  'Sebastián', 'Lozano',    'sebastian.lozano@mail.com','Bogotá',       '2025-01-08'),
    (6,  'Isabella',  'Mendoza',   'isabella.mendoza@mail.com','Cali',         '2025-01-20'),
    (7,  'Mateo',     'Guerrero',  'mateo.guerrero@mail.com',  'Sincelejo',    '2025-02-03'),
    (8,  'Sofía',     'Herrera',   'sofia.herrera@mail.com',   'Barranquilla', '2025-02-17'),
    (9,  'Nicolás',   'Pineda',    'nicolas.pineda@mail.com',  'Montería',     '2025-03-01'),
    (10, 'Mariana',   'Salas',     'mariana.salas@mail.com',   'Valledupar',   '2025-03-14'),
    (11, 'Santiago',  'Rojas',     'santiago.rojas@mail.com',  'Bogotá',       '2025-03-28'),
    (12, 'Laura',     'Cárdenas',  'laura.cardenas@mail.com',  'Bucaramanga',  '2025-04-10'),
    (13, 'Diego',     'Fonnegra',  'diego.fonnegra@mail.com',  'Medellín',     '2025-04-22'),
    (14, 'Paula',     'Villalba',  'paula.villalba@mail.com',  'Cartagena',    '2025-05-06'),
    (15, 'Tomás',     'Ariza',     'tomas.ariza@mail.com',     'Cali',         '2025-05-19');

INSERT INTO pedidos (id, id_cliente, fecha, estado) VALUES
    (1,  1,  '2025-01-05', 'entregado'),
    (2,  2,  '2025-01-12', 'entregado'),
    (3,  1,  '2025-02-03', 'enviado'),
    (4,  3,  '2025-02-14', 'entregado'),
    (5,  4,  '2025-02-20', 'cancelado'),
    (6,  5,  '2025-03-01', 'entregado'),
    (7,  2,  '2025-03-08', 'entregado'),
    (8,  6,  '2025-03-15', 'pendiente'),
    (9,  7,  '2025-03-22', 'entregado'),
    (10, 8,  '2025-04-02', 'enviado'),
    (11, 9,  '2025-04-10', 'entregado'),
    (12, 10, '2025-04-18', 'pendiente'),
    (13, 11, '2025-04-25', 'entregado'),
    (14, 12, '2025-05-02', 'cancelado'),
    (15, 13, '2025-05-09', 'entregado'),
    (16, 14, '2025-05-16', 'enviado'),
    (17, 15, '2025-05-23', 'pendiente'),
    (18, 3,  '2025-06-01', 'entregado'),
    (19, 5,  '2025-06-07', 'entregado'),
    (20, 8,  '2025-06-12', 'pendiente');

-- El precio_unitario se toma del precio actual del producto para mantener coherencia.
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
SELECT v.id_pedido, v.id_producto, v.cantidad, p.precio
FROM (VALUES
    (1,  1,  2), (1,  2,  3),
    (2,  11, 1), (2,  12, 2), (2,  15, 1),
    (3,  4,  1), (3,  3,  1),
    (4,  6,  2), (4,  8,  2),
    (5,  9,  1),
    (6,  16, 5), (6,  17, 4), (6,  18, 3),
    (7,  14, 2), (7,  13, 1),
    (8,  1,  1), (8,  5,  2),
    (9,  19, 6), (9,  20, 4),
    (10, 2,  5), (10, 3,  2),
    (11, 6,  1), (11, 7,  1),
    (12, 11, 3), (12, 12, 2), (12, 15, 4),
    (13, 4,  2), (13, 2,  2),
    (14, 1,  1),
    (15, 16, 10),(15, 17, 8), (15, 19, 6),
    (16, 8,  3), (16, 9,  1),
    (17, 13, 2), (17, 14, 1),
    (18, 3,  2), (18, 5,  1),
    (19, 10, 2), (19, 9,  1),
    (20, 1,  1), (20, 4,  1)
) AS v(id_pedido, id_producto, cantidad)
JOIN productos p ON p.id = v.id_producto;

UPDATE pedidos p
SET total = COALESCE((
    SELECT SUM(d.cantidad * d.precio_unitario)
    FROM detalle_pedido d
    WHERE d.id_pedido = p.id
), 0);
