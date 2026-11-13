# Proyecto Final — Diseño e Implementación de una Base de Datos

**Curso:** Bases de Datos (PostgreSQL)
**Modalidad:** individual
**Cierre de la ruta:** obligatorio para completar el tema 15

## Objetivo

Diseñar, normalizar e implementar una base de datos relacional completa para un dominio real, demostrando dominio de modelado, DDL, DML, consultas, índices y transacciones.

## Dominio

Elige **uno** de estos escenarios (o propón otro y justifícalo):

1. **Sistema de ventas** para una tienda de tecnología: clientes, productos, categorías, proveedores, pedidos, pagos.
2. **Gestión académica** para una universidad: estudiantes, profesores, cursos, matrículas, prerrequisitos, sedes.
3. **Biblioteca** pública: socios, libros, ejemplares, préstamos, sanciones, reservas.
4. **Sistema de salud**: pacientes, médicos, especialidades, citas, diagnósticos, recetas.
5. **Reservas de hotel**: huéspedes, habitaciones, tipos, reservas, pagos, servicios.

## Entregables

Crea una carpeta `proyectos/mi_proyecto/` con estos archivos:

### 1. `diseno.md` — Documento de diseño

- Descripción del dominio y reglas de negocio (mínimo 10 reglas)
- Diagrama ER (imagen o enlace a dbdiagram.io/draw.io)
- Explicación de cardinalidades y participación
- Modelo relacional resultante (tablas, columnas, PK, FK)
- Justificación de la normalización (1FN → 3FN/BCNF)
- Supuestos y decisiones de diseño

### 2. `schema.sql` — DDL completo

- `DROP` en orden seguro
- `CREATE TABLE` con tipos adecuados
- PK, FK, `UNIQUE`, `NOT NULL`, `CHECK`, `DEFAULT`
- `ON DELETE` justificado en cada FK
- Al menos 3 índices adicionales, con comentario del porqué
- Al menos 1 vista
- Compatible con PostgreSQL 16

### 3. `seed.sql` — Datos de prueba

- Mínimo 8 filas por tabla principal
- Datos coherentes con las FK
- Casos que permitan probar: `NULL`, duplicados evitados, fechas, estados
- Sin IDs hardcodeados que rompan las secuencias (o ajuste de secuencias al final)

### 4. `consultas.sql` — 15 consultas de negocio

Incluye al menos:

- 3 consultas básicas (`WHERE`, `ORDER BY`, `LIMIT`)
- 3 con `JOIN`
- 3 con agregación (`GROUP BY`, `HAVING`)
- 2 con subconsultas
- 2 con CTE (`WITH`)
- 2 con funciones ventana

Cada consulta debe tener un comentario con la pregunta de negocio que responde.

### 5. `transacciones.sql` — 2 transacciones

- Una transacción exitosa (`COMMIT`) que afecte varias tablas
- Una transacción que falle y haga `ROLLBACK` (demuestra consistencia)
- Al menos un `SAVEPOINT`

## Fases de trabajo (con el tutor)

| Fase | Entregable | Checkpoint |
|---|---|---|
| 1 | Dominio + reglas de negocio | Revisión de alcance |
| 2 | Diagrama ER | Cardinalidades correctas |
| 3 | Modelo relacional + normalización | 3FN/BCNF justificada |
| 4 | `schema.sql` | Corre sin errores en PostgreSQL |
| 5 | `seed.sql` | Datos coherentes |
| 6 | `consultas.sql` | 15 consultas correctas |
| 7 | `transacciones.sql` + índices | ACID demostrado |
| 8 | Defensa final | Explicación oral |

## Rúbrica (100 puntos)

| Criterio | Puntos |
|---|---|
| Modelado ER correcto y completo | 15 |
| Normalización justificada (3FN/BCNF) | 15 |
| DDL con restricciones e integridad | 15 |
| Datos de prueba coherentes | 10 |
| Consultas correctas y legibles | 20 |
| Índices y vistas bien usados | 10 |
| Transacciones y manejo de consistencia | 10 |
| Documentación y defensa | 5 |

**Aprobación:** 70/100.

## Defensa final

El tutor hará preguntas como:

1. ¿Por qué esta tabla y no otra?
2. ¿Dónde quedaría esta nueva regla de negocio en tu modelo?
3. ¿Qué pasa si dos usuarios hacen esto al mismo tiempo?
4. ¿Qué consulta sería lenta y qué índice propondrías?
5. ¿Cómo demuestras que tu modelo está en 3FN?

## Recomendaciones

- Empieza simple y ve agregando reglas; no diseñes 20 tablas de una.
- Prueba cada script desde cero antes de entregar.
- Usa `BEGIN; ... ROLLBACK;` para experimentar sin miedo.
- Documenta mientras diseñas, no al final.
