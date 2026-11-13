# Ejercicio 03 — Álgebra relacional

**Dataset:** `universidad`
**Objetivo:** traducir operaciones de álgebra relacional a SQL y viceversa.

## Recordatorio

| Álgebra | SQL |
|---|---|
| Selección σ | `WHERE` |
| Proyección π | columnas del `SELECT` |
| Unión ∪ | `UNION` |
| Intersección ∩ | `INTERSECT` |
| Diferencia − | `EXCEPT` |
| Producto cartesiano × | `CROSS JOIN` |
| Join ⋈ | `JOIN ... ON` |

## Ejercicios

1. Escribe en SQL la selección de estudiantes que viven en `'Barranquilla'`.
2. Escribe en SQL la proyección de `nombre, email` sobre `profesores`.
3. Combina selección y proyección: nombre y apellido de estudiantes nacidos después de `2003-01-01`.
4. Escribe la unión de las ciudades de `estudiantes` y las ciudades de `profesores` sin duplicados.
5. Escribe con `INTERSECT` las ciudades que aparecen tanto en `estudiantes` como en `profesores` (si no hay, explica el resultado).
6. Escribe con `EXCEPT` las ciudades donde hay estudiantes pero no profesores.
7. ¿Qué produce un `CROSS JOIN` entre `estudiantes` y `departamentos`? Calcula el número de filas sin ejecutarlo.
8. Escribe el join que muestra cada curso con el nombre de su departamento.

## Reto

Dado el conjunto A = estudiantes de `'Cartagena'` y B = estudiantes de `'Santa Marta'`, escribe:

- A ∪ B
- A ∩ B
- A − B

Ejecuta y explica cada resultado.

## Criterio de aceptación

- Reconoces qué operación del álgebra corresponde a cada cláusula SQL.
- Sabes por qué el producto cartesiano puede explotar en filas.
- Entiendes que el join es un producto cartesiano filtrado.

## Checkpoint

1. ¿Qué diferencia hay entre `UNION` y `UNION ALL`?
2. ¿La proyección elimina duplicados automáticamente en SQL? ¿Por qué?
3. ¿Qué relación hay entre producto cartesiano y `JOIN`?
