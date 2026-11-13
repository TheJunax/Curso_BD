# Ejercicio 12 — Subconsultas y CTEs

**Datasets:** `universidad`, `tienda`
**Objetivo:** resolver consultas complejas con subconsultas, `EXISTS` y `WITH`.

## Ejercicios

1. Muestra los estudiantes cuya nota sea mayor que el promedio general de notas.
2. Muestra los cursos cuyo promedio de notas sea mayor que el promedio general.
3. Muestra los estudiantes que están matriculados en el curso `IS301`, usando `IN` con subconsulta.
4. Repite el ejercicio anterior con `EXISTS`. ¿Cuál te parece más claro?
5. Muestra los estudiantes que **no** tienen matrículas usando `NOT EXISTS`.
6. Muestra los cursos que tienen al menos un prerrequisito, con `EXISTS`.
7. Muestra los cursos que **no** son prerrequisito de ningún otro curso.
8. Muestra el estudiante con la nota más alta (sin `LIMIT`, usando subconsulta).
9. Usa una subconsulta correlacionada para mostrar, por cada curso, cuántas matrículas tiene.
10. Reescribe el ejercicio 9 con un `LEFT JOIN` y `GROUP BY`. Compara resultados.
11. Crea una CTE `promedios_curso` y úsala para listar cursos con promedio mayor a 4.0.
12. Crea dos CTEs encadenadas: una con el promedio por estudiante y otra que filtre los mayores a 4.0.

## Reto (dataset tienda)

Con una CTE, calcula:

- total comprado por cliente (solo pedidos `'entregado'`)
- nombre del cliente
- clasifícalo como `'VIP'` si gastó más de 1.000.000, `'Frecuente'` si gastó más de 300.000, y `'Ocasional'` en otro caso

## Criterio de aceptación

- Las subconsultas devuelven el tipo correcto (escalar, fila o conjunto).
- Se entiende `NOT IN` vs `NOT EXISTS` con `NULL`.
- La CTE mejora la legibilidad.

## Checkpoint

1. ¿Qué es una subconsulta correlacionada?
2. ¿Por qué `NOT IN` puede fallar si la subconsulta devuelve `NULL`?
3. ¿Qué ventaja tiene una CTE frente a una subconsulta anidada?
