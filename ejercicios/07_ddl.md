# Ejercicio 07 — DDL (CREATE / ALTER / DROP)

**Dataset:** `universidad`
**Objetivo:** crear y modificar estructuras con restricciones correctas.

## Ejercicios

1. Crea en una base de pruebas la tabla `sedes` con: `id` autoincremental, `nombre` único y `ciudad` obligatoria.
2. Crea `salas` con FK a `sedes`, capacidad mayor que 0 y un `CHECK` de nombre no vacío.
3. Agrega a `estudiantes` una columna `telefono VARCHAR(20)`.
4. Agrega una restricción `UNIQUE` al nuevo `telefono` y explica qué pasa si hay dos `NULL`.
5. Crea una tabla `auditoria` con `id`, `tabla_afectada`, `accion`, `fecha TIMESTAMP DEFAULT now()`.
6. Cambia el tipo de `salas.capacidad` de `INT` a `SMALLINT` con `ALTER COLUMN ... TYPE`.
7. Agrega `ON DELETE CASCADE` a una FK existente usando `ALTER TABLE ... DROP CONSTRAINT` y `ADD CONSTRAINT`.
8. Borra la tabla `auditoria` con `DROP TABLE`.
9. Intenta crear una tabla con una FK a una tabla inexistente. Explica el error.
10. Diferencia `DROP TABLE` de `TRUNCATE` y de `DELETE`.

## Reto

Escribe el DDL completo de un **sistema de reservas de salas**:

- `sedes`, `salas`, `usuarios`, `reservas`
- PK, FK, `UNIQUE` para evitar doble reserva en la misma sala/fecha/hora
- `CHECK` de hora de fin mayor que hora de inicio
- índices en las FK

## Criterio de aceptación

- El script corre de principio a fin sin errores.
- Las restricciones protegen la integridad de los datos.
- Se justifica cada `CHECK`, `UNIQUE` y FK.

## Checkpoint

1. ¿Qué diferencia hay entre `CHECK`, `UNIQUE` y `NOT NULL`?
2. ¿Qué hace `ON DELETE SET NULL`?
3. ¿Cuándo usarías `TRUNCATE` en vez de `DELETE`?
