-- ============================================================
-- Dataset: Universidad
-- Datos de prueba
-- Ejecutar DESPUÉS de universidad_schema.sql
-- ============================================================

INSERT INTO departamentos (id, nombre, edificio) VALUES
    (1, 'Ingeniería de Sistemas', 'Bloque A'),
    (2, 'Matemáticas',            'Bloque B'),
    (3, 'Física',                 'Bloque C'),
    (4, 'Ingeniería Industrial',  'Bloque D'),
    (5, 'Lingüística',            'Bloque E');

INSERT INTO profesores (id, nombre, apellido, email, id_departamento) VALUES
    (1, 'Carlos', 'Mendoza',  'carlos.mendoza@universidad.edu.co',  1),
    (2, 'Laura',  'Gómez',    'laura.gomez@universidad.edu.co',    1),
    (3, 'Andrés', 'Torres',   'andres.torres@universidad.edu.co',  2),
    (4, 'María',  'Fernández','maria.fernandez@universidad.edu.co',2),
    (5, 'Jorge',  'Ramírez',  'jorge.ramirez@universidad.edu.co',  3),
    (6, 'Diana',  'Castro',   'diana.castro@universidad.edu.co',   4),
    (7, 'Luis',   'Navarro',  'luis.navarro@universidad.edu.co',   5),
    (8, 'Paula',  'Ríos',     'paula.rios@universidad.edu.co',     1);

INSERT INTO estudiantes (id, nombre, apellido, email, fecha_nacimiento, ciudad) VALUES
    (1,  'Andrés',    'Pérez',     'andres.perez@correo.edu.co',    '2003-04-12', 'Barranquilla'),
    (2,  'Camila',    'Romero',    'camila.romero@correo.edu.co',   '2002-11-03', 'Cartagena'),
    (3,  'Daniel',    'Ospina',    'daniel.ospina@correo.edu.co',   '2004-01-25', 'Medellín'),
    (4,  'Valentina', 'Cruz',      'valentina.cruz@correo.edu.co',  '2003-07-19', 'Santa Marta'),
    (5,  'Sebastián', 'Lozano',    'sebastian.lozano@correo.edu.co','2002-09-08', 'Bogotá'),
    (6,  'Isabella',  'Mendoza',   'isabella.mendoza@correo.edu.co','2004-03-30', 'Cali'),
    (7,  'Mateo',     'Guerrero',  'mateo.guerrero@correo.edu.co',  '2003-12-14', 'Sincelejo'),
    (8,  'Sofía',     'Herrera',   'sofia.herrera@correo.edu.co',   '2002-05-22', 'Barranquilla'),
    (9,  'Nicolás',   'Pineda',    'nicolas.pineda@correo.edu.co',  '2004-08-06', 'Montería'),
    (10, 'Mariana',   'Salas',     'mariana.salas@correo.edu.co',   '2003-02-17', 'Valledupar'),
    (11, 'Santiago',  'Rojas',     'santiago.rojas@correo.edu.co',  '2002-10-29', 'Bogotá'),
    (12, 'Laura',     'Cárdenas',  'laura.cardenas@correo.edu.co',  '2004-06-11', 'Bucaramanga'),
    (13, 'Diego',     'Fonnegra',  'diego.fonnegra@correo.edu.co',  '2003-09-02', 'Medellín'),
    (14, 'Paula',     'Villalba',  'paula.villalba@correo.edu.co',  '2002-12-21', 'Cartagena'),
    (15, 'Tomás',     'Ariza',     'tomas.ariza@correo.edu.co',     '2004-04-09', 'Cali'),
    (16, 'Manuela',   'Duarte',    'manuela.duarte@correo.edu.co',  '2003-01-15', 'Pereira'),
    (17, 'Julián',    'Bermúdez',  'julian.bermudez@correo.edu.co', '2004-07-27', 'Armenia'),
    (18, 'Salomé',    'Restrepo',  'salome.restrepo@correo.edu.co', '2002-03-05', 'Manizales'),
    (19, 'Emilio',    'Cárdenas',  'emilio.cardenas@correo.edu.co', '2003-11-23', 'Riohacha'),
    (20, 'Antonia',   'Mejía',     'antonia.mejia@correo.edu.co',   '2002-08-16', 'Maicao');

INSERT INTO cursos (id, codigo, nombre, creditos, id_profesor, id_departamento) VALUES
    (1,  'IS101',  'Introducción a la Programación', 4, 1, 1),
    (2,  'IS201',  'Estructuras de Datos',           4, 2, 1),
    (3,  'IS301',  'Bases de Datos',                 4, 1, 1),
    (4,  'IS401',  'Redes de Computadores',          3, 8, 1),
    (5,  'MAT101','Cálculo I',                       4, 3, 2),
    (6,  'MAT201','Cálculo II',                      4, 4, 2),
    (7,  'MAT301','Álgebra Lineal',                  3, 3, 2),
    (8,  'FIS101','Física I',                        4, 5, 3),
    (9,  'FIS201','Física II',                       4, 5, 3),
    (10, 'IND201','Investigación de Operaciones',    3, 6, 4),
    (11, 'IND301','Gestión de Proyectos',            3, 6, 4),
    (12, 'LEN101','Comunicación Oral y Escrita',     2, 7, 5);

INSERT INTO prerrequisitos (id_curso, id_prerrequisito) VALUES
    (2, 1),   -- Estructuras de Datos requiere Introducción a la Programación
    (3, 2),   -- Bases de Datos requiere Estructuras de Datos
    (3, 5),   -- Bases de Datos requiere Cálculo I
    (4, 2),   -- Redes requiere Estructuras de Datos
    (6, 5),   -- Cálculo II requiere Cálculo I
    (7, 5),   -- Álgebra Lineal requiere Cálculo I
    (9, 8),   -- Física II requiere Física I
    (10, 6);  -- Investigación de Operaciones requiere Cálculo II

INSERT INTO matriculas (id_estudiante, id_curso, semestre, nota, fecha_matricula) VALUES
    (1, 1, '2025-1', 4.2, '2025-01-20'),
    (1, 2, '2025-1', 3.8, '2025-01-20'),
    (1, 5, '2025-1', 4.0, '2025-01-20'),
    (2, 1, '2025-1', 3.5, '2025-01-20'),
    (2, 2, '2025-1', 4.5, '2025-01-20'),
    (2, 6, '2025-1', 3.0, '2025-01-20'),
    (3, 1, '2025-1', 2.8, '2025-01-21'),
    (3, 3, '2025-1', 4.1, '2025-01-21'),
    (3, 5, '2025-1', 3.2, '2025-01-21'),
    (4, 2, '2025-1', 4.8, '2025-01-21'),
    (4, 3, '2025-1', 3.9, '2025-01-21'),
    (4, 6, '2025-1', 4.4, '2025-01-21'),
    (5, 1, '2025-1', 3.0, '2025-01-22'),
    (5, 4, '2025-1', 3.7, '2025-01-22'),
    (5, 7, '2025-1', 4.6, '2025-01-22'),
    (6, 2, '2025-1', 2.5, '2025-01-22'),
    (6, 4, '2025-1', 3.1, '2025-01-22'),
    (6, 8, '2025-1', 3.6, '2025-01-22'),
    (7, 3, '2025-1', 4.9, '2025-01-23'),
    (7, 5, '2025-1', 4.0, '2025-01-23'),
    (7, 9, '2025-1', 3.3, '2025-01-23'),
    (8, 4, '2025-1', 3.4, '2025-01-23'),
    (8, 6, '2025-1', 4.7, '2025-01-23'),
    (8, 10,'2025-1', 4.2, '2025-01-23'),
    (9, 5, '2025-1', 2.9, '2025-01-24'),
    (9, 7, '2025-1', 3.8, '2025-01-24'),
    (9, 11,'2025-1', 4.5, '2025-01-24'),
    (10,6, '2025-1', 4.1, '2025-01-24'),
    (10,8, '2025-1', 3.5, '2025-01-24'),
    (10,12,'2025-1', 4.8, '2025-01-24'),
    (11,1, '2024-2', 3.3, '2024-07-22'),
    (11,2, '2024-2', 4.0, '2024-07-22'),
    (11,5, '2024-2', 3.9, '2024-07-22'),
    (12,1, '2024-2', 4.6, '2024-07-22'),
    (12,3, '2024-2', 3.2, '2024-07-22'),
    (12,6, '2024-2', 4.4, '2024-07-22'),
    (13,2, '2024-2', 2.7, '2024-07-23'),
    (13,3, '2024-2', 3.6, '2024-07-23'),
    (13,7, '2024-2', 4.1, '2024-07-23'),
    (14,2, '2024-2', 4.3, '2024-07-23'),
    (14,4, '2024-2', 3.8, '2024-07-23'),
    (14,8, '2024-2', 4.9, '2024-07-23'),
    (15,3, '2024-2', 3.0, '2024-07-24'),
    (15,4, '2024-2', 4.2, '2024-07-24'),
    (15,9, '2024-2', 3.7, '2024-07-24'),
    (16,5, '2024-2', 4.7, '2024-07-24'),
    (16,6, '2024-2', 3.4, '2024-07-24'),
    (16,10,'2024-2', 4.0, '2024-07-24'),
    (17,7, '2024-2', 3.1, '2024-07-25'),
    (17,8, '2024-2', 4.5, '2024-07-25'),
    (17,11,'2024-2', 3.9, '2024-07-25'),
    (18,9, '2024-2', 4.8, '2024-07-25'),
    (18,10,'2024-2', 3.6, '2024-07-25'),
    (18,12,'2024-2', 4.3, '2024-07-25'),
    (19,1, '2024-2', 3.9, '2024-07-26'),
    (19,5, '2024-2', NULL, '2024-07-26'),
    (19,9, '2024-2', 4.2, '2024-07-26'),
    (20,2, '2024-2', NULL, '2024-07-26'),
    (20,6, '2024-2', 3.5, '2024-07-26'),
    (20,10,'2024-2', NULL, '2024-07-26');
