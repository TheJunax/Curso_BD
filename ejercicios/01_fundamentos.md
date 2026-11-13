# Ejercicio 01 — Fundamentos y PostgreSQL

**Dataset:** `universidad`
**Objetivo:** familiarizarse con `psql`, las tablas, los tipos de datos y el valor `NULL`.

## Antes de empezar

Prepara el entorno (cluster local, sin sudo):

```bash
cd "/home/thejunax/Documentos/Etapa 5"
./scripts/db_start.sh
source scripts/env.sh
```

Si es la primera vez, `./scripts/db_init.sh` ya deja cargado el dataset. Para recargarlo:

```bash
psql -f datasets/universidad_schema.sql
psql -f datasets/universidad_seed.sql
psql
```

## Ejercicios

1. Lista todas las tablas de la base con `\dt`.
2. Describe la tabla `estudiantes` con `\d estudiantes`. Anota: columnas, tipos, claves e índices.
3. ¿Cuántas filas tiene cada una de las 6 tablas? Usa `SELECT COUNT(*)`.
4. Muestra las primeras 5 filas de `cursos` ordenadas por `codigo`.
5. ¿Qué tipo de dato tiene `nota` en `matriculas`? ¿Por qué se usa `NUMERIC` y no `FLOAT`?
6. Encuentra las matrículas donde la nota es `NULL`. ¿Por qué no sirve `nota = NULL`?
7. Muestra el nombre completo de los estudiantes usando concatenación (`||`) y su ciudad.
8. ¿Qué pasa si intentas insertar un estudiante con `fecha_nacimiento = '2015-01-01'`? Explica el error.

## Reto

Sin mirar el esquema, escribe las consultas para responder:

- ¿Cuántos departamentos hay y cuáles son?
- ¿Qué profesores pertenecen al departamento 1?
- ¿Cuántos cursos tienen 4 créditos?

Después verifica con `\d` y compara.

## Criterio de aceptación

- Ejecutas todo en `psql` y muestras la salida real.
- Explicas con tus palabras qué es una tabla, una fila y una columna.
- Sabes diferenciar `NULL` de `0` y de cadena vacía.

## Checkpoint

1. ¿Qué diferencia hay entre un SGBD y una base de datos?
2. ¿Para qué sirve `\d`?
3. ¿Por qué `nota = NULL` no devuelve las filas con nota nula?
