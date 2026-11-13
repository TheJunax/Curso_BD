# Ruta de Aprendizaje - Bases de Datos (PostgreSQL)

> Bitácora del curso. El tutor lee este archivo al inicio de cada sesión y lo actualiza al final.
> Nunca asumir el estado: leer lo que diga aquí.

## Estado General

- Temas completados: 6/15
- Última sesión: 2026-11-13
- Siguiente tema: 7. DDL
- Motor: PostgreSQL 16 (Ubuntu 24.04)
- Enfoque: práctico, con proyecto integrador
- Base de datos del curso: `curso_bd`
- Cluster local: `localhost:5433` (usuario `juan`, sin contraseña, sin sudo)
- Arranque: `./scripts/db_start.sh` y `source scripts/env.sh`

## Leyenda

- ⬜ Pendiente
- 🟢 En progreso
- ✅ Completado y aprobado
- 🟡 Visto pero con dudas
- 🔁 Necesita repaso

## Reglas del curso

1. Intentar resolver los ejercicios antes de pedir la solución.
2. Los errores son aprendizaje: se documentan en 🐛, no se ocultan.
3. No avanzar si un concepto fundamental no está claro.
4. Los checkpoints miden comprensión, no memoria.
5. Se puede adelantar sin cambiar el orden oficial.
6. Cada fase termina con práctica real ejecutada en PostgreSQL.
7. Todo ejemplo se ejecuta con `psql` y se muestra la salida real.
8. Explicar el "por qué" antes de la sintaxis.
9. Usar `NUMERIC` para dinero, nunca `FLOAT`.
10. El proyecto final es obligatorio para cerrar la ruta.

## Temas

### Fase 1 — Fundamentos y modelo relacional

#### 1. Fundamentos y PostgreSQL ✅
- [x] Qué es una base de datos y un SGBD
- [x] Tabla, fila, columna, tipo de dato, `NULL`
- [x] Instalar/verificar PostgreSQL y el servicio
- [x] Crear usuario, base de datos y entrar con `psql`
- [x] Diferencia entre SQL declarativo y código imperativo (C/C++)
- Checkpoint: aprobado 2026-11-09 (4/5, pregunta 1 corregida en re-chequeo)
- Notas: `psql` = cliente; PostgreSQL = SGBD; `curso_bd` = base de datos. `\dt`, `\d tabla`, `\q`. `SELECT`/`FROM`/`ORDER BY`/`LIMIT`. `NULL` se compara con `IS NULL`. `COUNT(*)` cuenta filas; `COUNT(columna)` ignora `NULL`.

#### 2. Modelo relacional y claves ✅
- [x] Relación, tupla, atributo, dominio
- [x] Clave primaria, candidata, compuesta y foránea
- [x] Integridad de entidad, referencial y de dominio
- [x] Identificar claves en un caso real
- Checkpoint: aprobado 2026-11-09 (5/5 + re-chequeo de FK)
- Notas: relación = tabla, tupla = fila, atributo = columna, dominio = tipo. Candidata = superclave mínima; primaria = candidata elegida; alterna = candidata no elegida. Compuestas: `(id_pedido,id_producto)` y `(id_curso,id_prerrequisito)`. FK + integridad referencial. `CASCADE` borra hijos, `RESTRICT` bloquea, `SET NULL` deja la FK nula.

#### 3. Álgebra relacional ✅
- [x] Selección (σ) ↔ `WHERE`
- [x] Proyección (π) ↔ columnas del `SELECT`
- [x] Unión, intersección, diferencia
- [x] Producto cartesiano y join
- Checkpoint: aprobado 2026-11-10 (4/5 directo + P4 corregida en vivo: joins mal emparejados por `id=id`)
- Notas: σ = `WHERE`; π = columnas del `SELECT` (el `FROM` no es ninguna de las dos). `UNION` elimina duplicados (conjuntos), `UNION ALL` los conserva (bolsas). `CROSS JOIN` = ×; `JOIN ... ON` = σ(×) (theta-join). `EXCEPT` = diferencia de conjuntos. JOIN combina horizontal, UNION apila vertical. Relación N:M se consulta por la tabla puente. Regla de oro del join: FK ↔ PK, nunca id=numérico coincidente.

### Fase 2 — Diseño

#### 4. Modelado Entidad-Relación (ER/EER) ✅
- [x] Entidades fuertes y débiles
- [x] Atributos simples, compuestos, multivaluados y derivados
- [x] Relaciones y cardinalidad 1:1, 1:N, N:M
- [x] Participación total/parcial
- [x] Dibujar un diagrama ER completo
- Checkpoint: aprobado 2026-11-11 (2/3 + re-chequeo de multivaluado y N:M)
- Notas: dominio biblioteca: SOCIO, LIBRO, AUTOR, EJEMPLAR. PRESTA = N:M SOCIO↔EJEMPLAR con atributos (fecha_prestamo, fecha_devolucion, estado) — mismo molde que `matriculas` y `detalle_pedido` (dos 1:N que se cruzan en el puente). LIBRO 1:N EJEMPLAR; EJEMPLAR es débil por identidad (id_libro + copia), pero el barcode UNIQUE lo vuelve fuerte al implementar. AUTOR 1:N LIBRO por decisión de dominio (colección de autor único); N:M costaría tabla puente extra. El `id` de las tablas puente es artificio de implementación, no atributo de la relación. `precio_unitario` en detalle = histórico congelado (demostrado con BEGIN/ROLLBACK). FK nullable ↔ participación parcial; FK NOT NULL ↔ total; el modelo manda sobre la foto de datos del momento (el estudiante no cayó en la trampa). Atributos: multivaluado = tabla aparte (puente escondido); derivado = no se guarda, se calcula (redundancia → tema 6).
- ER universidad (sesión 5): DEPARTAMENTO, PROFESOR, ESTUDIANTE, CURSO, TELÉFONO (débil, clave parcial `número`, PK `(id_estudiante, número)`). 1:N: DEPARTAMENTO→PROFESOR y PROFESOR→CURSO (FK en el lado N); N:M: ESTUDIANTE↔CURSO con atributos (semestre, nota, fecha) y CURSO↔CURSO recursiva (prerrequisitos). Participación: FK `NOT NULL` ↔ total, nullable ↔ parcial. MATRÍCULA y PRERREQUISITO son RELACIONES, no entidades; la tabla puente es consecuencia del mapeo. Cardinalidad se escribe por lado (1 o N); N:M = N en ambos lados (la M solo distingue el lado).

#### 5. Mapeo ER → modelo relacional ✅
- [x] Entidad → tabla
- [x] Relación 1:N → FK en el lado N
- [x] Relación N:M → tabla intermedia
- [x] Relación 1:1 → FK con `UNIQUE`
- [x] Jerarquías: tabla única vs tablas separadas
- Checkpoint: aprobado 2026-11-12 (3/3 en opción múltiple + P5 correcta; P4 falló y se re-chequeó: la N:M se había colapsado en 1:N y la PK del puente usaba una sola coordenada)
- Notas: entidad fuerte → tabla con PK; débil → PK compuesta (dueño + clave parcial); compuesto → se aplana (una columna por parte, sin duplicar las que ya existen); multivaluado → tabla aparte; derivado → no se guarda (edad se calcula con `AGE()`). 1:N → FK en el lado N (si no, tocaría una lista en una columna → viola 1FN); participación total ↔ `NOT NULL`, parcial ↔ nullable. N:M → puente con **PK = par de FKs** y los atributos del rombo adentro; el `id` artificial es opcional y solo si otra tabla necesita referenciar la línea. 1:1 → FK + `UNIQUE` **en un solo lado** (duplicarla crea FK circular y dos fuentes de verdad que se contradicen). Jerarquías: tabla única con discriminador (pocos atributos propios) vs supertipo + subtipos con PK=FK (muchos atributos o roles solapados: un profe que también es estudiante). Patrón general: PK artificial para relacionar + `UNIQUE` natural para la regla del negocio (`isbn`, `codigo`, `email`). Precio histórico: `productos.precio` = catálogo de hoy, `detalle_pedido.precio_unitario` = precio congelado de la venta. Índice único **parcial** ≠ compuesto: `UNIQUE (id_ejemplar) WHERE estado='activo'` permite histórico y bloquea doble préstamo activo.

#### 6. Normalización ✅
- [x] Dependencias funcionales
- [x] 1FN: valores atómicos
- [x] 2FN: sin dependencias parciales
- [x] 3FN: sin dependencias transitivas
- [x] BCNF
- [x] Detectar anomalías de inserción, actualización y borrado
- Checkpoint: aprobado 2026-11-13 (3/3 opción múltiple; Q4/Q5 correctas, Q4 con un ejemplo mal etiquetado y corregido)
- Notas: DF = "si sé X, sé un único Y"; el determinante va a la IZQUIERDA (`id_estudiante → nombre`, no al revés: dos "Ana Torres" en Bogotá rompen `(nombre, ciudad) → id`). Clave de `matricula_plana` = `(id_estudiante, id_curso, semestre)` — el semestre entra porque un estudiante puede repetir el curso. DFs: `id_estudiante → nombre_estudiante, ciudad_estudiante`; `id_curso → nombre_curso, creditos, id_profesor`; `id_profesor → nombre_profesor`; `(id_estudiante, id_curso, semestre) → nota`. 1FN = valores atómicos: la tabla plana YA está en 1FN (el problema no es la celda, es la repetición de filas). 2FN = sin dependencia parcial (un no-clave depende de PARTE de una clave compuesta; imposible violarla con PK de una sola columna). 3FN = sin dependencia transitiva (no-clave → no-clave; cadena `clave → no-clave → atributo`). BCNF = todo determinante debe ser superclave; es la 3FN sin la excepción del atributo primo; 3FN y BCNF solo difieren cuando las claves candidatas se solapan (demo `practica.tutorias`: `profesor → curso` con `curso` primo → 3FN sí, BCNF no). Anomalías con Camila (tienda): inserción (cliente sin pedido), actualización (ciudad en 5 filas → 2 ciudades), borrado (borrar el pedido 16 → se va Paula). Descomposición del ejercicio = el esquema real: `estudiantes`, `profesores`, `cursos`(id_profesor FK), `matriculas`/`historial`(PK trío). Dato repetido → fila fantasma (16 filas para 15 clientes).

### Fase 3 — SQL

#### 7. DDL ⬜
- [ ] `CREATE TABLE` y tipos de datos de PostgreSQL
- [ ] `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `CHECK`, `DEFAULT`
- [ ] `ALTER TABLE` y `DROP TABLE`
- [ ] `ON DELETE CASCADE` vs `RESTRICT`
- Checkpoint: —
- Notas: —

#### 8. DML ⬜
- [ ] `INSERT` (y `RETURNING`)
- [ ] `UPDATE` con `WHERE`
- [ ] `DELETE` con `WHERE`
- [ ] Integridad referencial en la práctica
- Checkpoint: —
- Notas: —

#### 9. Consultas básicas ⬜
- [ ] `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `OFFSET`
- [ ] `DISTINCT`
- [ ] Operadores `=`, `<>`, `>`, `<`, `BETWEEN`, `LIKE`, `IN`
- [ ] `NULL`: `IS NULL`, `IS NOT NULL`, `COALESCE`
- Checkpoint: —
- Notas: —

#### 10. JOINs ⬜
- [ ] `INNER JOIN`
- [ ] `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`
- [ ] `CROSS JOIN`
- [ ] `SELF JOIN`
- [ ] Filtrar en `ON` vs filtrar en `WHERE`
- Checkpoint: —
- Notas: —

#### 11. Agregación ⬜
- [ ] `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- [ ] `GROUP BY`
- [ ] `HAVING`
- [ ] `COUNT(*)` vs `COUNT(columna)`
- [ ] Agrupar por varias columnas
- Checkpoint: —
- Notas: —

#### 12. Subconsultas y CTEs ⬜
- [ ] Subconsultas escalares
- [ ] `IN`, `NOT IN`, `EXISTS`, `NOT EXISTS`
- [ ] Subconsultas correlacionadas
- [ ] `WITH` (CTE) y CTEs múltiples
- Checkpoint: —
- Notas: —

#### 13. Vistas, índices y funciones ventana ⬜
- [ ] `CREATE VIEW` y vistas materializadas
- [ ] Índices B-tree: cuándo sí y cuándo no
- [ ] `EXPLAIN` y `EXPLAIN ANALYZE`
- [ ] `ROW_NUMBER`, `RANK`, `DENSE_RANK`
- [ ] `OVER (PARTITION BY ... ORDER BY ...)`
- Checkpoint: —
- Notas: —

#### 14. Transacciones y concurrencia ⬜
- [ ] ACID
- [ ] `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`
- [ ] Niveles de aislamiento
- [ ] Bloqueos y deadlocks
- [ ] Ejemplo: transferencia bancaria
- Checkpoint: —
- Notas: —

### Fase 4 — Cierre

#### 15. Proyecto integrador ⬜
- [ ] Diseño ER del dominio elegido
- [ ] Normalización justificada (3FN/BCNF)
- [ ] Script DDL completo
- [ ] Datos de prueba (`seed`) coherentes
- [ ] 15 consultas de negocio
- [ ] Al menos 3 vistas y 3 índices justificados
- [ ] Al menos 2 transacciones
- [ ] Documentación y defensa
- Checkpoint: —
- Notas: —

## Recursos

- Documentación oficial PostgreSQL 16: https://www.postgresql.org/docs/16/
- Datasets del curso: `datasets/`
- Ejercicios: `ejercicios/`
- Proyecto: `proyectos/proyecto_final.md`
- Guía de instalación y uso: `README.md`

## Sesiones anteriores

### Sesión 1 — 2026-11-09
- Tema: 1. Fundamentos y PostgreSQL
- Qué se hizo: teoría de DB/SGBD/cliente, tabla/fila/columna/tipo, `NULL`, SQL declarativo vs C; práctica con `\dt`, `\d`, `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `COUNT`.
- Checkpoint: 4/5; falló la diferencia DB/SGBD y se corrigió con re-chequeo.
- Pendientes: empezar tema 2 (modelo relacional y claves).

### Sesión 2 — 2026-11-09
- Tema: 2. Modelo relacional y claves
- Qué se hizo: vocabulario relacional, claves candidata/primaria/alterna/compuesta/foránea, integridad de entidad/referencial/dominio; práctica con `\d detalle_pedido`, `\d cursos`, demos de FK y `ON DELETE`.
- Checkpoint: 5/5; falló `SET NULL` vs `CASCADE` y se corrigió con re-chequeo.
- Pendientes: empezar tema 3 (álgebra relacional).

### Sesión 3 — 2026-11-09
- Tema: 3. Álgebra relacional
- Qué se hizo: selección/proyección, `DISTINCT`, `UNION`/`INTERSECT`/`EXCEPT`, producto cartesiano y `JOIN ... ON`; práctica con estudiantes, cursos y profesores.
- Checkpoint: pendiente (no se alcanzó a responder).
- Pendientes: responder checkpoint del tema 3 y seguir con tema 4 (modelo ER/EER).

### Sesión 4 — 2026-11-10
- Tema: 3. Álgebra relacional (repaso + checkpoint) y 4. Modelado ER (entidades, cardinalidad, participación)
- Qué se hizo: repaso socrático de σ/π, `UNION` vs `UNION ALL`, producto cartesiano (predijo 96 = 12×8) y `JOIN ... ON` = σ(×); checkpoint de 5 preguntas: P3 `EXCEPT` (socios − clientes → 5 ciudades), P4 join N:M por `matriculas` con filtro de nota, P5 equivalencia `CROSS JOIN`+`WHERE` ↔ `JOIN ... ON` (ambas dieron 60 filas); debugging en vivo de la P4 mal emparejada por `id=id`. Tema 4: modelado de la biblioteca (entidades, cardinalidades, relación con atributos, entidad débil EJEMPLAR, participación total/parcial) con evidencia en datos reales; clase de tipos de atributos (simples, compuestos, multivaluados, derivados).
- Checkpoint: 4/5 directo; P4 falló por emparejar `id=id` y filtrar sin la tabla puente; se corrigió en vivo a FK↔PK con verificación de contenido (Villalba sí, Ospina no). Aprobado.
- Extras: se resolvió acceso a `psql` desde la casa del usuario (error "rol thejunax no existe" → hay que hacer `source scripts/env.sh` en cada terminal nueva; el cluster vive en 5433, no 5432). Se creó `guias/guia_select_from.md` (guía de bolsillo con recetas, mapa de datasets corregido, errores propios y 13 ejercicios). Se instaló pgAdmin 4 (flatpak --user, `org.pgadmin.pgadmin4`): conectar con host localhost, puerto 5433, usuario juan, sin contraseña, base curso_bd. Demos de preview: BEGIN/ROLLBACK (tema 14) y LEFT JOIN (tema 10).
- Pendientes: responder ejercicio de atributos; dibujar el diagrama ER completo (dominio a elegir por el estudiante, base para Fase 3 y proyecto final) y checkpoint del tema 4.

### Sesión 5 — 2026-11-11
- Tema: 4. Modelado ER (cierre: atributos, diagrama y checkpoint)
- Qué se hizo: calentamiento de dominios 3/3 (tienda/biblioteca/universidad, cierra el 🔁 de la sesión 4); ejercicio de atributos (5/6: `ciudad` simple, dirección compuesta, teléfonos multivaluado, edad derivado, `fecha_devolucion` simple; falló `nombre_completo` "simple" sin ver el problema de ordenar/buscar por apellido, corregido). Revisión del ER de universidad: modeló MATRÍCULA y PRERREQUISITO como entidades, puso "1:1" por lado y invirtió la participación en PROFESOR↔DEPARTAMENTO y PROFESOR↔CURSO; dirección "todo en uno" como simple. Se entregó el ER completo de universidad con el mapeo adelantado (1:N → FK en el lado N, N:M → puente, multivaluado → tabla aparte, débil → PK compuesta).
- Checkpoint: 2/3 (multivaluado confundido con N:M: "estudiante con varios cursos"); re-chequeo: correos como multivaluado (un curso es entidad, no valor) y N:M = N en ambos lados del rombo. Aprobado.
- Pendientes: tema 5 (mapeo ER → relacional), arrancando con el repaso de participación ↔ FK (`NOT NULL` = total).
- Extras: se creó `guias/temas_clave.html` — página de referencia con los 15 temas (concepto, puntos clave, trampas, ejemplo SQL), estado de la ruta, ER de universidad, los 15 🐛 en tabla, comandos/datasets y checklist del proyecto. Buscador con atajo `/` (ignora tildes) y filtros por estado.

### Sesión 6 — 2026-11-12
- Tema: 5. Mapeo ER → modelo relacional
- Qué se hizo: calentamiento del 🔁 de participación (2/2: PROFESOR total, CURSO parcial). Regla 1 con evidencia real: se agregaron `calle`/`numero` a `estudiantes` (sin duplicar `ciudad`), se creó `telefonos` con PK `(id_estudiante, numero)` y `correos` con PK `correo` + `UNIQUE (id_estudiante, tipo)`; se demostraron los tres rechazos (UNIQUE del par, PK del correo, FK de estudiante inexistente). Regla 2 con `departamentos`/`profesores`/`cursos` y el `LEFT JOIN` de cursos sin profe. Regla 3 con `matriculas` (PK surrogate + UNIQUE natural). Regla 4 con demo de FK circular (deadlock de inserción) y de dos FKs contradiciéndose (`prof 1 → oficina 1` vs `oficina 1 → prof 2`). Regla 5 con demo de Ana como estudiante y profesora a la vez (supertipo + subtipos con PK=FK). Ejercicio de biblioteca: fichas de `socios`, `autores`, `libros`, `ejemplares`, `prestamos`.
- Checkpoint: 3/3 opción múltiple + P5 correcta (índice único parcial). P4 falló: mapeó la N:M de tienda como una sola tabla `pedido` con `id_producto`, y luego dejó `id_producto` en `pedidos` **y** `detalle_pedido` a la vez, con `PK (id_pedido)` en el puente. Re-chequeo con demo: las 3 líneas del pedido 2 mueren con `PK id_pedido` (`Key (id_pedido)=(2) already exists`); se explicó el par como coordenada de A×B y la contradicción de dos fuentes de verdad. Aprobado.
- Extras: se cargaron los seeds de universidad, biblioteca y tienda. `curso_bd` quedó con cambios de práctica: columnas `calle`/`numero` en `estudiantes`, tablas `telefonos` y `correos` (se pierden al recargar `universidad_schema.sql`). Demo de precio congelado: al subir 5.000 el precio de catálogo, la factura vieja no se movió.
- Pendientes: tema 6 (normalización), entrando por dependencias funcionales y anomalías; usar el caso `pedidos`/`detalle_pedido` como ejemplo vivo.

### Sesión 7 — 2026-11-13
- Tema: 6. Normalización (completo) + repaso de PK del puente
- Qué se hizo: arranque desde las anomalías con la tienda (tabla plana simulada `practica.factura_plana`, 42 filas para 15 clientes): demostración en vivo de la anomalía de actualización (UPDATE parcial → Camila en Medellín y Cartagena, sin error) y contraste con el diseño bueno (`UPDATE 1` en `clientes` y todos los pedidos ven la ciudad nueva). Se destapó el tercer problema: la identidad por nombre (dos Camila Romero). Dependencias funcionales: dirección de la flecha (el determinante va a la izquierda), superclave/clave. 1FN con la tabla plana (ya cumplía). 2FN: se partió `factura_plana` en `practica.paso2_pedidos` (20) + `practica.paso2_detalle` (42); Camila bajó de 5 a 2 filas. 3FN: dependencia transitiva y el "fantasma" (16 filas para 15 clientes por la ciudad desincronizada). BCNF con la tabla `practica.tutorias` (3FN sí, BCNF no). Ejercicio 06: el estudiante identificó las DFs de `matricula_plana` (tras corregir la dirección), la clave triple, las parciales (2FN) y la transitiva (3FN), y armó las 4 tablas (`estudiantes`, `profesores`, `cursos`, `historial`) = el esquema real.
- Checkpoint: aprobado 2026-11-13 — 3/3 en opción múltiple; Q4 (parcial vs transitiva) con un ejemplo mal etiquetado y corregido; Q5 (caso `empleado_proyecto`) correcta: clave `(id_empleado, id_proyecto)` y violación de 2FN.
- Extras: tablas de práctica creadas en el esquema `practica` (`factura_plana`, `paso2_pedidos`, `paso2_detalle`, `tutorias`); la demo de `detalle_malo` (PK `(id_pedido)`) mostró el error `duplicate key ... (2) already exists` y quedó revertida por el rollback del error. Recordatorio: `practica` es andamio, se puede borrar con `DROP SCHEMA practica CASCADE`.
- Pendientes: tema 7 (DDL), arrancando con el repaso de nombres singular vs plural (`\dt` antes de escribir SQL); usar `CREATE TABLE` con los tipos de PostgreSQL y las restricciones.

## Errores importantes 🐛

- [Fundamentos] Confundía base de datos con SGBD y `psql` con el SGBD → la base de datos son los datos (`curso_bd`), el SGBD es PostgreSQL y `psql` es solo el cliente.
- [NULL] Decía que `COUNT(*)` "no da todos los datos" → `COUNT(*)` cuenta todas las filas; `COUNT(nota)` cuenta solo las notas no nulas.
- [FK] Pensaba que `cursos.id_profesor` era `ON DELETE CASCADE` → es `SET NULL`: los cursos siguen existiendo y `id_profesor` queda `NULL`.
- [JOIN] `JOIN` sin `ON` da error de sintaxis → para producto cartesiano usar `CROSS JOIN`; para unir por clave usar `JOIN ... ON`.
- [JOIN/Checkpoint] Emparejaba tablas por `id = id` (coincidencia numérica) en vez de FK↔PK → consulta sin error pero con datos falsos (estudiantes con cursos que nunca tomaron; 2 filas de 12). Lección: un JOIN mal hecho no falla, miente; verificar contenido, no solo el conteo.
- [Sintaxis] Escribió `CROSS JOIN ... ON` (ilegal: CROSS no lleva condición) y `estudiante` en vez de `estudiantes` → revisar nombres exactos con `\dt` antes de escribir.
- [σ/π] Decía que σ/π se mapeaban a "SELECT y FROM" → σ es el `WHERE`; π es la lista de columnas del `SELECT`.
- [JOIN vs UNION] Decía que JOIN era "unión con condición" → JOIN combina horizontalmente (σ sobre ×); UNION apila filas verticalmente.
- [Entorno] Ejecutaba `psql` sin cargar `scripts/env.sh` → intentaba entrar al puerto 5432 como rol `thejunax` y fallaba; el cluster del curso es `localhost:5433` usuario `juan`.
- [ER] Se le cruzan los dominios entre datasets (dijo "socio - detalle_pedido" en la tienda y "estudiantes con libros" en la biblioteca) → antes de hablar de cardinalidad, fijar en qué dominio está parado. Ocurrió 2 veces en la sesión 4.
- [ER/claves] Identificaba por nombre ("por el nombre del libro") y usó el número global del barcode como discriminador ("copia 18") → la clave de la débil se compone con id del dueño + clave parcial que REINICIA por dueño (EJ-018 = libro 3, copia 2).
- [ER/entidades] Modeló MATRÍCULA y PRERREQUISITO como entidades, con `id_estudiante`/`id_curso` como "atributos" → son relaciones N:M (rombo); las FK no son atributos del ER y la tabla puente es consecuencia del mapeo, no del modelo. Es justo la trampa de "N:M dibujada como 1:N".
- [ER/multivaluado] Dijo que "un estudiante con varios cursos" era atributo multivaluado → CURSO es entidad (relación N:M); multivaluado son varios valores del mismo tipo sin otra entidad (teléfonos, correos, títulos). Corregido en re-chequeo.
- [ER/participación] Invirtió la participación en PROFESOR↔DEPARTAMENTO y PROFESOR↔CURSO → regla: FK `NOT NULL` ↔ total, nullable ↔ parcial; el lado sin restricción es parcial.
- [ER/diagrama] Puso "1:1" por lado en la cardinalidad → cada lado lleva un solo símbolo (1 o N); N:M = N en ambos lados.
- [Mapeo/1:1] Puso la FK en **las dos** tablas del 1:1 ("hay que saber para cada lado") → una relación = una FK; duplicarla crea FK circular (no se puede insertar nada sin `DEFERRABLE`) y dos fuentes de verdad que se contradicen sin que ninguna restricción chille. Se consulta en ambos sentidos con un JOIN, no duplicando.
- [Mapeo/N:M] Colapsó la N:M de tienda en una sola tabla `pedido` con `id_producto` (volvió un 1:N) → un pedido con 3 productos repetiría `id_cliente`/`fecha`/`total` en 3 filas (anomalía de actualización). Después dejó `id_producto` en `pedidos` **y** `detalle_pedido` a la vez → contradicción: el encabezado dice un producto, el detalle dice tres.
- [Mapeo/PK puente] Usó `PK (id_pedido)` en `detalle_pedido` ("se identifica con el id_pedido") → identifica el pedido, no la línea; con esa PK el pedido 2 no admite sus 3 líneas (`duplicate key ... (2) already exists`). La PK del puente es el **par de FKs** `(id_pedido, id_producto)`; una relación N:M es un subconjunto de A×B y un par necesita sus dos coordenadas.
- [Mapeo/PK mínima] Repitió la trampa de la PK no mínima dos veces en la misma sesión (`(id, id_libro)` en ejemplares, `(id_ejemplar, id_libro)` en préstamos) → si existe una columna `id` artificial, la PK es `id`; lo natural va en `UNIQUE`.
- [Mapeo/índices] Confundió **compuesto** con **parcial**: propuso `UNIQUE (id_ejemplar, estado)` para el préstamo activo → también prohíbe repetir `devuelto` (probado: `(12, devuelto)` duplicado). La regla condicional se expresa con índice único **parcial** (`WHERE estado='activo'`).
- [Nombres] Escribió las tablas en singular (`estudiante`, `ejemplar`, `pedido`, `producto`) → los nombres reales son plurales; PostgreSQL los trata como tablas distintas y la FK falla con "relation does not exist".
- [Normalización/DF] Escribió las dependencias funcionales **al revés** (`(nombre, ciudad) → id`, `(semestre, nota) → id_estudiante`) → el determinante (lo que se conoce) va a la IZQUIERDA: `id_estudiante → nombre_estudiante`. Un nombre+ciudad no determina un id (dos "Ana Torres" en Bogotá con ids distintos); `email` sí porque tiene `UNIQUE` y `nombre` no.
- [Normalización/2FN-3FN] Llamó "transitiva" a una **dependencia parcial** (en `prestamos`, `titulo_libro` depende solo de `id_libro`, que es parte de la clave) → parcial = depende de PARTE de una clave compuesta; transitiva = no-clave → no-clave (cadena `clave → no-clave → atributo`). Su otro ejemplo (`id_curso → id_estudiante → nombre`) sí era transitivo.

## Repasos pendientes 🔁

- [ER/participación] ✅ resuelto 2026-11-12: calentamiento 2/2 (PROFESOR total por `NOT NULL`, CURSO parcial por nullable).
- [ER/dominios] ✅ resuelto 2026-11-11: calentamiento 3/3 (tienda/biblioteca/universidad).
- [Mapeo/PK] ✅ resuelto 2026-11-13: en el tema 6 identificó bien la clave triple de `matricula_plana` y la PK `(id_pedido, id_producto)` del puente; usó el trío de FKs como PK en `historial`.
- [Nombres] Repasar al arrancar el tema 7 (DDL): singular vs plural de las tablas; verificar con `\dt` antes de escribir SQL.

## Checkpoints aprobados

- Sesión 1 — Tema 1 Fundamentos — 4/5 + re-chequeo — 2026-11-09
- Sesión 2 — Tema 2 Modelo relacional y claves — 5/5 + re-chequeo — 2026-11-09
- Sesión 4 — Tema 3 Álgebra relacional — 4/5 + corrección de P4 en vivo — 2026-11-10
- Sesión 5 — Tema 4 Modelado ER — 2/3 + re-chequeo (multivaluado, N:M) — 2026-11-11
- Sesión 6 — Tema 5 Mapeo ER → relacional — 3/3 + P5 correcta; P4 con re-chequeo (N:M y PK del puente) — 2026-11-12
- Sesión 7 — Tema 6 Normalización — 3/3 opción múltiple; Q4 (parcial vs transitiva) con un ejemplo mal etiquetado y corregido; Q5 correcta — 2026-11-13
