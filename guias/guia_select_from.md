# Guía de bolsillo — SELECT y FROM

> Referencia rápida de Juan para consultar y practicar.
> Solo contiene lo visto hasta el tema 3 (álgebra relacional). Todo se ejecuta contra `curso_bd`.

## 1. Pa' entrar SIEMPRE (terminal nueva = repetir esto)

```bash
cd "/home/thejunax/Documentos/Etapa 5"
./scripts/db_start.sh        # solo si el servidor está apagado
source scripts/env.sh         # carga puerto 5433, usuario juan, base curso_bd
psql                          # entra al prompt: curso_bd=#
```

Sin el `source` te va a dar el error **"rol thejunax does not exist"**
(porque intenta entrar al 5432 con tu usuario de Linux; el cluster del curso vive en **5433**).

## 2. Comandos mágicos de psql (no son SQL, son del cliente)

| Comando | Qué hace |
|---|---|
| `\dt` | lista todas las tablas |
| `\d estudiantes` | describe una tabla: columnas, tipos, PK, FK, constraints |
| `\q` | salir de psql |
| `\timing` | muestra cuánto tarda cada consulta (para rendimiento) |

## 3. La idea mental (álgebra relacional ↔ SQL)

| SQL | Álgebra | Qué escoge |
|---|---|---|
| `FROM` | — | **de qué tabla** se lee |
| `WHERE` | σ (selección) | **filas** |
| lista de columnas del `SELECT` | π (proyección) | **columnas** |

Ojo: la palabra `SELECT` de SQL NO es la selección del álgebra — esa es el `WHERE`.
El `SELECT` hace la proyección por su lista de columnas.

## 4. El orden en que PostgreSQL PIENSA tu consulta

Tú la escribes en un orden, el motor la ejecuta en otro:

```
1. FROM          → agarra la tabla
2. JOIN ... ON   → la pega con otras tablas (FK ↔ PK)
3. WHERE         → filtra filas (σ)
4. SELECT        → escoge columnas y calcula (π)
5. ORDER BY      → ordena
6. LIMIT         → recorta al final
```

Por eso puedes usar en `ORDER BY` un alias definido en el `SELECT`
(el SELECT ya "ocurrió"), pero NO puedes usar un alias del SELECT dentro del `WHERE`.

## 5. Recetas (copiar, pegar, ejecutar)

```sql
-- Todas las columnas
SELECT * FROM estudiantes;

-- Solo algunas columnas (π)
SELECT nombre, ciudad FROM estudiantes;

-- Alias de columna (AS)
SELECT nombre AS estu, ciudad AS donde_vive FROM estudiantes;

-- Concatenar texto con || (nombre completo)
SELECT nombre || ' ' || apellido AS nombre_completo FROM estudiantes;

-- Valores sin repetir
SELECT DISTINCT ciudad FROM estudiantes;

-- Filtrar filas (σ)
SELECT nombre, precio FROM productos WHERE precio > 50000;

-- Ordenar (ASC por defecto, DESC pa' bajar)
SELECT nombre, precio FROM productos ORDER BY precio DESC;

-- Los primeros N resultados
SELECT nombre, precio FROM productos ORDER BY precio DESC LIMIT 5;

-- Contar filas
SELECT COUNT(*) FROM estudiantes;

-- Contar valores distintos (sin NULL)
SELECT COUNT(DISTINCT ciudad) FROM socios;

-- JOIN por la tabla puente (regla de oro: FK ↔ PK, nunca id = id)
SELECT e.nombre, c.nombre AS curso
FROM estudiantes e
JOIN matriculas m ON m.id_estudiante = e.id
JOIN cursos c     ON c.id = m.id_curso;

-- Operaciones de conjuntos (vertical, apilan filas)
SELECT ciudad FROM socios    UNION      SELECT ciudad FROM clientes; -- sin duplicados
SELECT ciudad FROM socios    UNION ALL  SELECT ciudad FROM clientes; -- con duplicados
SELECT ciudad FROM socios    EXCEPT     SELECT ciudad FROM clientes; -- socios - clientes

-- Producto cartesiano (×): TODO contra TODO, solo pa' entender el concepto
SELECT COUNT(*) FROM estudiantes CROSS JOIN matriculas;
```

## 6. El mapa de las 3 casas (datasets en curso_bd)

| Casa | Tablas |
|---|---|
| 🎓 Universidad | `estudiantes`, `profesores`, `departamentos`, `cursos`, `matriculas` (puente), `prerrequisitos` (puente) |
| 📚 Biblioteca | `socios`, `autores`, `libros`, `ejemplares`, `prestamos` (puente) |
| 🛒 Tienda | `clientes`, `pedidos`, `detalle_pedido` (puente), `productos`, `proveedores`, `categorias` |

Cada FK se llama igual que su destino: `id_estudiante` → `estudiantes.id`.

## 7. Tus errores 🐛 (para no repetirlos)

1. **`JOIN` sin `ON`** → error de sintaxis. Producto cartesiano es `CROSS JOIN` (sin ON).
2. **`CROSS JOIN ... ON`** → ilegal. CROSS no lleva condición.
3. **Emparejar por `id = id`** → ¡el más peligroso! No da error pero devuelve datos falsos.
   Regla de oro: FK ↔ PK. Verifica CONTENIDO, no solo el conteo.
4. **`estudiante` vs `estudiantes`** → revisa nombres exactos con `\dt` antes de escribir.
5. **Comillas**: `'texto'` para VALORES, `"nombre"` para columnas/tablas. Nunca al revés.
6. **Sin `;` al final** → psql se queda esperando y no ejecuta nada.

## 8. Ejercicios pa' practicar solo (en orden, sin saltos)

1. Columnas `nombre` y `stock` de todos los productos.
2. Ciudades distintas de `socios`, ordenadas.
3. Los 5 libros más viejos de la biblioteca (por `anio`).
4. Nombre y precio de los 3 productos más caros.
5. Estudiantes de Maicao, ordenados por apellido.
6. Nombre completo de los clientes de Bogotá (concatenado, con alias `cliente`).
7. ¿Cuántos ejemplares hay en total?
8. ¿Cuántas ciudades distintas hay entre los clientes?
9. Título y año de los libros publicados desde 2010, del más nuevo al más viejo.
10. JOIN: título del libro junto al nombre de su autor (`libros` con `autores`).
11. JOIN: nombre del producto junto al nombre de su categoría (`productos` con `categorias`).
12. Reto: ciudades donde hay clientes pero NO hay socios (el EXCEPT al revés del checkpoint).
13. Reto: nombre completo de socios que tienen ejemplares con estado `'prestado'`
    (hay que cruzar `prestamos` → `ejemplares` → `libros`... no, piensa bien el camino: el socio está en `prestamos`).

> Cuando los tengas, pégalos en una sesión con el tutor y se revisan juntos.

## 9. Lo que viene (aún NO lo uses en la guía, es del tema 9+)

`LIKE`, `BETWEEN`, `IN`, `IS NULL`/`COALESCE`, `OFFSET`, `SUM`/`AVG`, `GROUP BY`,
subconsultas, vistas, índices... Ejercicios completos en `ejercicios/09_consultas.md`
cuando lleguemos a ese tema. Uno a la vez, que la ruta sabe lo que hace.
