# Ejercicio 08 — DML (INSERT / UPDATE / DELETE)

**Dataset:** `universidad`
**Objetivo:** modificar datos con integridad y sin accidentes.

> Trabaja dentro de una transacción (`BEGIN; ... ROLLBACK;`) mientras experimentas.

## Ejercicios

1. Inserta un nuevo departamento llamado `'Arquitectura'` en el edificio `'Bloque F'`. Usa `RETURNING` para ver el id generado.
2. Inserta un estudiante nuevo con todos los campos obligatorios.
3. Inserta una matrícula para ese estudiante en el curso `IS101`, semestre `'2025-2'`, sin nota.
4. Actualiza la nota de esa matrícula a `4.5`.
5. Sube 0.2 puntos la nota de todos los estudiantes del curso `IS101` en `'2025-1'`, sin pasar de 5.0.
6. Elimina las matrículas con nota `NULL` del semestre `'2024-2'`. Antes, cuenta cuántas son.
7. Intenta borrar un departamento que tiene profesores. Explica el error y qué alternativa hay.
8. Inserta un curso con un `id_profesor` inexistente. Explica el error de FK.
9. Usa `INSERT ... SELECT` para copiar a una tabla `estudiantes_backup` todos los estudiantes de `'Barranquilla'`.
10. Escribe un `UPDATE` con `WHERE` que no afecte ninguna fila. ¿Cómo saber cuántas filas se modificaron? (Pista: `RETURNING` o el mensaje de `psql`).

## Reto

Simula una matrícula completa en una transacción:

1. `BEGIN`
2. Insertar estudiante
3. Insertar matrícula
4. Actualizar nota
5. Verificar con `SELECT`
6. `ROLLBACK` y comprobar que todo quedó como antes

## Criterio de aceptación

- Nunca ejecutas `UPDATE`/`DELETE` masivo sin `WHERE` consciente.
- Entiendes el error de integridad referencial.
- Sabes usar `RETURNING`.

## Checkpoint

1. ¿Qué hace `RETURNING`?
2. ¿Qué pasa si un `INSERT` viola un `UNIQUE`?
3. ¿Por qué es peligroso `DELETE FROM tabla;` sin `WHERE`?
