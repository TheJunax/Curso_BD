-- ============================================================
-- Dataset: Biblioteca
-- Datos de prueba
-- Ejecutar DESPUÉS de biblioteca_schema.sql
-- ============================================================

INSERT INTO autores (id, nombre, nacionalidad) VALUES
    (1,  'Gabriel García Márquez', 'Colombia'),
    (2,  'Isabel Allende',         'Chile'),
    (3,  'Jorge Luis Borges',      'Argentina'),
    (4,  'Mario Vargas Llosa',     'Perú'),
    (5,  'Laura Esquivel',         'México'),
    (6,  'Julio Cortázar',         'Argentina'),
    (7,  'Pablo Neruda',           'Chile'),
    (8,  'Elena Poniatowska',      'México'),
    (9,  'Juan Rulfo',             'México'),
    (10, 'Roberto Bolaño',         'Chile');

INSERT INTO libros (id, isbn, titulo, anio, id_autor) VALUES
    (1,  '9780307474728', 'Cien años de soledad',               1967, 1),
    (2,  '9780060850524', 'La casa de los espíritus',           1982, 2),
    (3,  '9780802130303', 'Ficciones',                          1944, 3),
    (4,  '9788420480191', 'La ciudad y los perros',             1963, 4),
    (5,  '9780385721233', 'Como agua para chocolate',           1989, 5),
    (6,  '9780394720246', 'Rayuela',                            1963, 6),
    (7,  '9788437604572', 'Veinte poemas de amor y una canción desesperada', 1924, 7),
    (8,  '9789684114739', 'La noche de Tlatelolco',             1971, 8),
    (9,  '9788437604589', 'Pedro Páramo',                       1955, 9),
    (10, '9788433968657', 'Los detectives salvajes',            1998, 10),
    (11, '9780307389732', 'El amor en los tiempos del cólera',  1985, 1),
    (12, '9780060951290', 'Eva Luna',                           1987, 2),
    (13, '9780802130304', 'El Aleph',                           1949, 3),
    (14, '9788420471830', 'La fiesta del chivo',                2000, 4),
    (15, '9788437604580', 'Cien sonetos de amor',               1959, 7);

INSERT INTO ejemplares (id, id_libro, codigo, estado) VALUES
    (1,  1,  'EJ-001', 'disponible'),
    (2,  1,  'EJ-002', 'disponible'),
    (3,  2,  'EJ-003', 'disponible'),
    (4,  2,  'EJ-004', 'dañado'),
    (5,  3,  'EJ-005', 'disponible'),
    (6,  4,  'EJ-006', 'disponible'),
    (7,  5,  'EJ-007', 'disponible'),
    (8,  6,  'EJ-008', 'disponible'),
    (9,  7,  'EJ-009', 'perdido'),
    (10, 8,  'EJ-010', 'disponible'),
    (11, 9,  'EJ-011', 'disponible'),
    (12, 10, 'EJ-012', 'disponible'),
    (13, 11, 'EJ-013', 'disponible'),
    (14, 12, 'EJ-014', 'disponible'),
    (15, 13, 'EJ-015', 'disponible'),
    (16, 14, 'EJ-016', 'disponible'),
    (17, 15, 'EJ-017', 'disponible'),
    (18, 3,  'EJ-018', 'disponible'),
    (19, 6,  'EJ-019', 'disponible'),
    (20, 9,  'EJ-020', 'dañado');

INSERT INTO socios (id, nombre, apellido, email, ciudad, fecha_alta) VALUES
    (1,  'Andrés',    'Pérez',     'andres.perez@biblio.co',    'Barranquilla', '2024-02-10'),
    (2,  'Camila',    'Romero',    'camila.romero@biblio.co',   'Cartagena',    '2024-03-05'),
    (3,  'Daniel',    'Ospina',    'daniel.ospina@biblio.co',   'Medellín',     '2024-03-22'),
    (4,  'Valentina', 'Cruz',      'valentina.cruz@biblio.co',  'Santa Marta',  '2024-04-14'),
    (5,  'Sebastián', 'Lozano',    'sebastian.lozano@biblio.co','Bogotá',       '2024-05-01'),
    (6,  'Isabella',  'Mendoza',   'isabella.mendoza@biblio.co','Cali',         '2024-05-19'),
    (7,  'Mateo',     'Guerrero',  'mateo.guerrero@biblio.co',  'Sincelejo',    '2024-06-07'),
    (8,  'Sofía',     'Herrera',   'sofia.herrera@biblio.co',   'Barranquilla', '2024-06-25'),
    (9,  'Nicolás',   'Pineda',    'nicolas.pineda@biblio.co',  'Montería',     '2024-07-12'),
    (10, 'Mariana',   'Salas',     'mariana.salas@biblio.co',   'Valledupar',   '2024-08-03'),
    (11, 'Santiago',  'Rojas',     'santiago.rojas@biblio.co',  'Bogotá',       '2024-08-21'),
    (12, 'Laura',     'Cárdenas',  'laura.cardenas@biblio.co',  'Bucaramanga',  '2024-09-09'),
    (13, 'Diego',     'Fonnegra',  'diego.fonnegra@biblio.co',  'Medellín',     '2024-09-27'),
    (14, 'Paula',     'Villalba',  'paula.villalba@biblio.co',  'Cartagena',    '2024-10-15'),
    (15, 'Tomás',     'Ariza',     'tomas.ariza@biblio.co',     'Cali',         '2024-11-02'),
    (16, 'Manuela',   'Duarte',    'manuela.duarte@biblio.co',  'Pereira',      '2024-11-20'),
    (17, 'Julián',    'Bermúdez',  'julian.bermudez@biblio.co', 'Armenia',      '2024-12-08'),
    (18, 'Salomé',    'Restrepo',  'salome.restrepo@biblio.co', 'Manizales',    '2024-12-26'),
    (19, 'Emilio',    'Cárdenas',  'emilio.cardenas@biblio.co', 'Riohacha',     '2025-01-13'),
    (20, 'Antonia',   'Mejía',     'antonia.mejia@biblio.co',   'Maicao',       '2025-01-31');

INSERT INTO prestamos (id, id_ejemplar, id_socio, fecha_prestamo, fecha_devolucion, estado) VALUES
    (1,  1,  1,  '2025-01-10', '2025-01-20', 'devuelto'),
    (2,  2,  2,  '2025-02-05', NULL,         'activo'),
    (3,  3,  3,  '2025-01-15', '2025-01-25', 'devuelto'),
    (4,  5,  4,  '2025-02-10', '2025-02-18', 'devuelto'),
    (5,  6,  5,  '2025-03-01', NULL,         'activo'),
    (6,  8,  6,  '2025-01-20', '2025-01-30', 'devuelto'),
    (7,  11, 7,  '2025-02-15', NULL,         'vencido'),
    (8,  12, 8,  '2025-03-05', '2025-03-15', 'devuelto'),
    (9,  14, 9,  '2025-03-10', NULL,         'activo'),
    (10, 15, 10, '2025-01-05', '2025-01-12', 'devuelto'),
    (11, 17, 11, '2025-02-20', NULL,         'vencido'),
    (12, 18, 12, '2025-03-12', '2025-03-20', 'devuelto'),
    (13, 19, 13, '2025-03-15', NULL,         'activo'),
    (14, 1,  14, '2025-03-18', '2025-03-25', 'devuelto'),
    (15, 3,  15, '2025-03-20', '2025-03-28', 'devuelto'),
    (16, 5,  16, '2025-04-01', NULL,         'activo'),
    (17, 8,  17, '2025-04-05', '2025-04-12', 'devuelto'),
    (18, 12, 18, '2025-04-10', NULL,         'vencido'),
    (19, 15, 19, '2025-04-15', '2025-04-22', 'devuelto'),
    (20, 18, 20, '2025-04-20', NULL,         'activo'),
    (21, 1,  2,  '2025-04-25', '2025-05-05', 'devuelto'),
    (22, 3,  4,  '2025-05-01', NULL,         'activo'),
    (23, 5,  6,  '2025-05-05', '2025-05-12', 'devuelto'),
    (24, 8,  8,  '2025-05-10', NULL,         'activo'),
    (25, 12, 10, '2025-05-15', '2025-05-22', 'devuelto');

-- Sincronizar el estado de los ejemplares con préstamos activos o vencidos.
UPDATE ejemplares e
SET estado = 'prestado'
WHERE e.estado = 'disponible'
  AND EXISTS (
      SELECT 1
      FROM prestamos p
      WHERE p.id_ejemplar = e.id
        AND p.estado IN ('activo', 'vencido')
  );
