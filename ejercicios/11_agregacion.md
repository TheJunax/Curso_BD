# Ejercicio 11 — Agregación

**Datasets:** `universidad`, `tienda`
**Objetivo:** resumir datos con `GROUP BY` y `HAVING`.

## Ejercicios

1. Cuenta cuántos estudiantes hay en total.
2. Cuenta cuántos estudiantes hay por ciudad.
3. Calcula el promedio de notas por curso, mostrando `codigo` y `nombre`.
4. Calcula el promedio de notas por semestre.
5. Muestra los cursos con promedio mayor a 4.0 (`HAVING`).
6. Muestra cuántas matrículas tiene cada estudiante, incluyendo los que tienen 0.
7. Calcula la nota máxima y mínima por curso.
8. Explica la diferencia entre `COUNT(*)` y `COUNT(nota)` en la tabla `matriculas`.
9. Muestra cuántos cursos tiene cada departamento.
10. Muestra el total de créditos por departamento.
11. En `tienda`, calcula el total vendido por pedido y luego el total general de pedidos `'entregado'`.
12. En `tienda`, muestra el producto más vendido por cantidad (puedes usar orden y `LIMIT`).

## Reto

Escribe una consulta que muestre, por cada profesor:

- nombre completo
- cantidad de cursos que dicta
- promedio de créditos de sus cursos

Incluye profesores sin cursos y ordena de mayor a menor cantidad.

## Criterio de aceptación

- Toda columna del `SELECT` está agrupada o agregada.
- Se usa `HAVING` para filtrar agregados, no `WHERE`.
- Se interpretan los resultados en contexto.

## Checkpoint

1. ¿Qué diferencia hay entre `WHERE` y `HAVING`?
2. ¿Qué pasa si seleccionas una columna que no está en `GROUP BY`?
3. ¿`COUNT(columna)` cuenta los `NULL`?
