# Ejercicio 06 — Normalización

**Dataset:** `universidad`
**Objetivo:** detectar anomalías y llevar una tabla hasta 3FN/BCNF.

## Tabla de partida (ejemplo)

```text
matricula_plana(id_estudiante, nombre_estudiante, ciudad_estudiante,
                id_curso, nombre_curso, creditos, nombre_profesor,
                id_profesor, semestre, nota)
```

## Ejercicios

1. Identifica todas las dependencias funcionales de `matricula_plana`.
2. ¿Está en 1FN? Justifica. ¿Hay atributos multivaluados o grupos repetidos?
3. ¿Está en 2FN? Encuentra dependencias parciales respecto de la clave.
4. ¿Está en 3FN? Encuentra dependencias transitivas.
5. Propón el conjunto de tablas normalizado hasta 3FN. Escribe el esquema con PK y FK.
6. Describe una anomalía de inserción, una de actualización y una de borrado en la tabla plana.
7. En el dataset real, ¿por qué `matriculas` no guarda el nombre del estudiante ni el nombre del curso?
8. ¿Qué tabla del dataset está en 3FN pero podría no estar en BCNF? Analiza `cursos` con `id_profesor` y `id_departamento`.
9. Normaliza este caso: `pedido(id_pedido, fecha, id_cliente, nombre_cliente, ciudad_cliente, id_producto, nombre_producto, precio, cantidad)`.

## Reto

Toma un formulario de factura en papel (o inventa uno) con datos del cliente, productos y totales. Pásalo a tablas en 3FN y explica cada paso: 1FN, 2FN, 3FN.

## Criterio de aceptación

- Cada forma normal se justifica con las dependencias funcionales.
- No se normaliza de más: las tablas resultantes son útiles y no absurdas.
- Se explican las anomalías con ejemplos concretos.

## Checkpoint

1. ¿Qué prohíbe la 1FN?
2. ¿Qué es una dependencia parcial?
3. ¿Qué es una dependencia transitiva?
