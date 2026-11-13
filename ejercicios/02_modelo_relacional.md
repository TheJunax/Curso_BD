# Ejercicio 02 — Modelo relacional y claves

**Datasets:** `universidad`, `tienda`
**Objetivo:** identificar relaciones, atributos, dominios y todos los tipos de claves.

## Ejercicios

1. Para la tabla `estudiantes`, identifica: clave primaria, claves candidatas y atributos.
2. En `matriculas`, ¿por qué la clave primaria es `id` y no `(id_estudiante, id_curso)`? ¿Qué restricción cumple esa pareja?
3. En `prerrequisitos`, la clave primaria es compuesta. ¿Cuáles columnas la forman y por qué?
4. Lista todas las claves foráneas de `universidad` y di a qué tabla/columna apuntan.
5. En `tienda`, explica la relación entre `pedidos` y `detalle_pedido`. ¿Cuál es la clave foránea?
6. ¿Qué significa `ON DELETE CASCADE` en `detalle_pedido.id_pedido`? ¿Qué pasaría al borrar un pedido?
7. ¿Qué significa `ON DELETE RESTRICT` en `pedidos.id_cliente`? Intenta borrar un cliente con pedidos y explica el error.
8. Clasifica estos atributos como simples, compuestos, multivaluados o derivados: `nombre`, `email`, `fecha_nacimiento`, una lista de teléfonos, la edad calculada desde `fecha_nacimiento`.
9. Propón una clave candidata para `profesores` distinta de `id`.

## Reto

Diseña en papel el modelo relacional de una **agenda de contactos** con:

- contactos (una persona puede tener varios teléfonos)
- etiquetas (un contacto puede tener varias etiquetas y una etiqueta varios contactos)
- empresas (una empresa tiene varios contactos, cada contacto pertenece a una empresa)

Indica PK, FK y cardinalidades.

## Criterio de aceptación

- Distingues PK, candidata, compuesta y foránea sin dudar.
- Justificas la integridad referencial con ejemplos reales.
- Entiendes por qué las relaciones N:M necesitan tabla intermedia.

## Checkpoint

1. ¿Cuándo una clave es compuesta?
2. ¿Qué diferencia hay entre `UNIQUE` y `PRIMARY KEY`?
3. ¿Qué es la integridad referencial?
