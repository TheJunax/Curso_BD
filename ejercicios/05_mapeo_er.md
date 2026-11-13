# Ejercicio 05 — Mapeo ER → modelo relacional

**Dataset:** `universidad`
**Objetivo:** convertir un diagrama ER en tablas con claves correctas.

## Reglas base

- Entidad → tabla.
- Relación 1:N → FK en el lado N.
- Relación N:M → tabla intermedia con PK compuesta.
- Relación 1:1 → FK con `UNIQUE` en uno de los lados.
- Entidad débil → tabla con PK compuesta que incluye la FK de la entidad fuerte.

## Ejercicios

1. Dibuja un ER mínimo con `departamentos` 1:N `profesores` y mapéalo a tablas. ¿Dónde va la FK?
2. Mapéalo ahora con `estudiantes` N:M `cursos` (matrículas). ¿Por qué no se puede poner una FK directa?
3. En `prerrequisitos`, ¿qué tipo de relación del ER representa? Justifica la PK compuesta.
4. Diseña el mapeo de una relación 1:1 entre `profesor` y `oficina`. ¿En cuál tabla pondrías la FK y qué restricción agregarías?
5. Toma el ER que hiciste en el ejercicio 04 (gestión académica) y escribe el esquema relacional completo.
6. Para cada tabla resultante, marca PK y FK.
7. ¿Qué pasa con una relación N:M que además tiene atributos propios (por ejemplo, fecha de matrícula)? ¿Dónde van esos atributos?
8. Modela una jerarquía `persona` → `estudiante` y `profesor` de dos formas: tabla única con discriminador y tablas separadas. Da una ventaja y una desventaja de cada una.

## Reto

Toma el caso de la **red social** (usuarios que se siguen) y escribe el DDL del mapeo. Incluye:

- tabla `usuarios`
- tabla de seguimiento con PK compuesta
- una restricción para que un usuario no se siga a sí mismo

## Criterio de aceptación

- Cada relación del ER tiene su reflejo en tablas.
- No hay datos repetidos innecesariamente.
- Las PK y FK están justificadas.

## Checkpoint

1. ¿Dónde va la clave foránea en una relación 1:N?
2. ¿Cómo se mapea una relación N:M?
3. ¿Qué restricción se usa en un 1:1 para evitar duplicados?
