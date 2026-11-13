# Ejercicio 13 — Vistas, índices y funciones ventana

**Datasets:** `universidad`, `tienda`
**Objetivo:** crear vistas, entender índices con `EXPLAIN` y usar funciones ventana.

## Ejercicios

### Vistas

1. Crea una vista `v_estudiantes_barranquilla` con los estudiantes de esa ciudad.
2. Crea una vista `v_resumen_cursos` con código, nombre, créditos, profesor y cantidad de matriculados.
3. Consulta la vista como si fuera una tabla.
4. Intenta hacer un `INSERT` a través de `v_estudiantes_barranquilla`. ¿Funciona? ¿Por qué?
5. Elimina la vista con `DROP VIEW`.

### Índices

6. Ejecuta `EXPLAIN` sobre `SELECT * FROM matriculas WHERE id_estudiante = 5;` y observa si usa el índice.
7. Compara con `EXPLAIN ANALYZE` y anota el tiempo.
8. Crea un índice sobre `estudiantes(ciudad)` y vuelve a ejecutar una consulta filtrada por ciudad.
9. ¿Por qué no conviene indexar todas las columnas?
10. Consulta `\di` y explica qué índices ya existen en `matriculas`.

### Funciones ventana

11. Muestra cada matrícula con un ranking de nota por curso usando `RANK()`.
12. Muestra el número de fila (`ROW_NUMBER()`) de cada matrícula dentro de su curso, ordenado por nota descendente.
13. Muestra el promedio del curso en cada fila sin agrupar, usando `AVG(nota) OVER (PARTITION BY id_curso)`.
14. Compara `RANK`, `DENSE_RANK` y `ROW_NUMBER` en un caso con notas empatadas.

## Reto

Crea una vista `v_top_estudiantes` que muestre, por estudiante:

- nombre completo
- promedio de notas
- posición (ranking) global por promedio

Usa una función ventana dentro de la vista.

## Criterio de aceptación

- La vista simplifica una consulta recurrente.
- Se interpreta el plan de ejecución de `EXPLAIN`.
- Se distingue `RANK` de `DENSE_RANK`.

## Checkpoint

1. ¿Qué es una vista y qué no es?
2. ¿Cuándo un índice acelera y cuándo puede perjudicar?
3. ¿Qué hace `PARTITION BY` en una función ventana?
