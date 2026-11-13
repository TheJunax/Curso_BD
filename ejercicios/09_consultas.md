# Ejercicio 09 — Consultas básicas

**Dataset:** `universidad`
**Objetivo:** dominar `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, operadores y `NULL`.

## Ejercicios

1. Muestra todos los estudiantes ordenados por apellido.
2. Muestra los 5 estudiantes más jóvenes (por `fecha_nacimiento`).
3. Lista los estudiantes que viven en `'Barranquilla'` o `'Cartagena'`, usando `IN`.
4. Lista los cursos con créditos entre 3 y 4, usando `BETWEEN`.
5. Muestra los profesores cuyo email termine en `'@universidad.edu.co'` y cuyo nombre empiece por `'L'`.
6. Muestra las matrículas cuya nota sea mayor o igual a 4.5, ordenadas de mayor a menor.
7. Muestra las matrículas con nota `NULL`. Luego muestra las que sí tienen nota.
8. Usa `COALESCE(nota, 0)` para mostrar todas las matrículas con un valor por defecto.
9. Muestra las ciudades distintas donde viven estudiantes, sin repetir.
10. Muestra los cursos cuyo nombre contenga la palabra `'Cálculo'`.
11. Muestra las matrículas del semestre `'2025-1'` con nota entre 3.0 y 4.0, ordenadas por curso y luego por nota descendente.
12. Explica por qué `WHERE nota <> 3.0` no incluye las filas con `nota = NULL`.

## Reto

Escribe una consulta que muestre:

- nombre completo del estudiante
- ciudad
- si la nota es `NULL`, mostrar `'Sin calificar'`
- nota final

Solo para matrículas del curso con `codigo = 'IS301'`.

## Criterio de aceptación

- La sintaxis de `SELECT` es correcta y ejecutable.
- Se ordena con criterios claros.
- Se maneja `NULL` correctamente.

## Checkpoint

1. ¿Qué hace `DISTINCT`?
2. ¿Qué diferencia hay entre `LIMIT` y `OFFSET`?
3. ¿Qué devuelve `NULL = NULL` en PostgreSQL?
