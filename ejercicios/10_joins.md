# Ejercicio 10 — JOINs

**Dataset:** `universidad` (y `tienda` para el reto)
**Objetivo:** combinar tablas correctamente y entender los tipos de join.

## Ejercicios

1. Muestra el nombre del curso y el nombre del profesor que lo dicta (`INNER JOIN`).
2. Muestra todos los profesores, incluso los que no dictan cursos (`LEFT JOIN`). ¿Quiénes quedan con curso `NULL`?
3. Muestra todos los cursos, incluso los que no tienen profesor asignado.
4. Muestra el nombre del estudiante, el nombre del curso y la nota de cada matrícula.
5. Muestra el nombre del curso y el nombre del departamento al que pertenece.
6. Muestra cada prerrequisito con el nombre del curso y el nombre del curso que exige.
7. Muestra los estudiantes que **no** tienen ninguna matrícula. Usa `LEFT JOIN ... WHERE ... IS NULL`.
8. Muestra los cursos que no tienen ningún estudiante matriculado.
9. ¿Qué diferencia hay entre poner una condición en `ON` y ponerla en `WHERE` en un `LEFT JOIN`? Demuéstralo con una consulta de profesores y cursos.
10. Escribe un `SELF JOIN` que muestre profesor y departamento usando la tabla `profesores` (aunque no aplique directamente), o explica por qué no tiene sentido aquí.
11. Calcula manualmente cuántas filas devuelve un `CROSS JOIN` entre `estudiantes` (20) y `cursos` (12). Luego verifícalo.

## Reto (dataset tienda)

Muestra para cada pedido:

- id del pedido
- nombre y apellido del cliente
- fecha
- nombre de cada producto y cantidad
- subtotal (`cantidad * precio_unitario`)

Ordena por id de pedido.

## Criterio de aceptación

- Se usa el join adecuado para cada pregunta.
- No aparecen productos cartesianos accidentales.
- Se entiende cuándo un `LEFT JOIN` trae `NULL`.

## Checkpoint

1. ¿Cuándo usarías `LEFT JOIN` en vez de `INNER JOIN`?
2. ¿Qué hace `FULL JOIN`?
3. ¿Qué pasa si olvidas la condición `ON`?
