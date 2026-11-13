# Curso de Bases de Datos — PostgreSQL

Material del curso de bases de datos relacionales con PostgreSQL. El tutor `tutor-bd` lee `RUTA_BD.md` al inicio de cada sesión y actualiza el progreso al final.

## Requisitos

- Ubuntu 24.04
- PostgreSQL 16 (servidor + cliente `psql`)
- Terminal

## 1. Estado de la instalación

PostgreSQL 16 ya está instalado en este equipo. Para el curso se usa un **cluster local sin sudo**, escuchando en `localhost:5433` (el servicio del sistema queda aparte).

## 2. Iniciar el entorno del curso

```bash
cd "/home/thejunax/Documentos/Etapa 5"

# Primera vez: inicializa el cluster, crea la base y carga los datasets
./scripts/db_init.sh

# En sesiones posteriores (o tras reiniciar el equipo)
./scripts/db_start.sh

# Cargar variables para usar psql sin escribir host/puerto/usuario
source scripts/env.sh
```

Después de `source scripts/env.sh`, `psql` ya queda apuntando a `curso_bd` como `juan` en `localhost:5433`.

| Script | Qué hace |
|---|---|
| `scripts/db_init.sh` | Inicializa el cluster (si falta), crea `curso_bd` y carga los 3 datasets |
| `scripts/db_start.sh` | Inicia el servidor local |
| `scripts/db_stop.sh` | Detiene el servidor local |
| `scripts/db_status.sh` | Muestra si está corriendo |
| `scripts/env.sh` | Exporta `PGHOST`, `PGPORT`, `PGUSER`, `PGDATABASE` |

- Datos del cluster: `~/.local/share/curso_bd/data`
- Log: `~/.local/share/curso_bd/postgres.log`
- Usuario: `juan` (superusuario local, sin contraseña, solo en localhost)
- Puerto: `5433`

> La autenticación es `trust` y solo escucha en `localhost`; es un entorno de práctica local, no expuesto a la red.

### Alternativa: servicio del sistema (requiere sudo)

Si prefieres el servicio de Ubuntu:

```bash
sudo systemctl start postgresql
sudo -u postgres psql -c "CREATE ROLE juan LOGIN PASSWORD 'tu_clave';"
sudo -u postgres createdb -O juan curso_bd
```

En ese caso usa `psql -h localhost -p 5432 -U juan -d curso_bd`.

## 3. Cargar los datasets

`db_init.sh` ya los carga. Para recargarlos manualmente:

```bash
cd "/home/thejunax/Documentos/Etapa 5"
source scripts/env.sh

# Universidad (dataset principal)
psql -f datasets/universidad_schema.sql
psql -f datasets/universidad_seed.sql

# Tienda (práctica extra)
psql -f datasets/tienda_schema.sql
psql -f datasets/tienda_seed.sql

# Biblioteca (práctica extra)
psql -f datasets/biblioteca_schema.sql
psql -f datasets/biblioteca_seed.sql
```

Los scripts de esquema hacen `DROP TABLE IF EXISTS ... CASCADE` al inicio, así que se pueden recargar sin problema. **Esto borra los datos** de ese dataset y los vuelve a crear.

## 4. Comandos útiles de `psql`

| Comando | Qué hace |
|---|---|
| `\l` | Lista las bases de datos |
| `\c curso_bd` | Conecta a una base |
| `\dt` | Lista las tablas |
| `\d nombre_tabla` | Describe columnas, claves e índices |
| `\di` | Lista los índices |
| `\dv` | Lista las vistas |
| `\df` | Lista las funciones |
| `\timing` | Muestra el tiempo de cada consulta |
| `\x` | Resultados en formato expandido |
| `\q` | Salir |

Ejecutar una consulta directa sin entrar a `psql`:

```bash
source scripts/env.sh
psql -c "SELECT * FROM estudiantes LIMIT 5;"
```

## 5. Estructura del curso

```
Etapa 5/
├── RUTA_BD.md                     # ruta y bitácora de progreso
├── README.md                      # este archivo
├── scripts/
│   ├── db_init.sh                 # inicializa cluster + base + datasets
│   ├── db_start.sh                # inicia el servidor local
│   ├── db_stop.sh                 # detiene el servidor local
│   ├── db_status.sh               # muestra el estado
│   └── env.sh                     # variables PGHOST/PGPORT/PGUSER/PGDATABASE
├── datasets/
│   ├── universidad_schema.sql
│   ├── universidad_seed.sql
│   ├── tienda_schema.sql
│   ├── tienda_seed.sql
│   ├── biblioteca_schema.sql
│   └── biblioteca_seed.sql
├── ejercicios/
│   ├── 01_fundamentos.md
│   ├── 02_modelo_relacional.md
│   ├── 03_algebra_relacional.md
│   ├── 04_er.md
│   ├── 05_mapeo_er.md
│   ├── 06_normalizacion.md
│   ├── 07_ddl.md
│   ├── 08_dml.md
│   ├── 09_consultas.md
│   ├── 10_joins.md
│   ├── 11_agregacion.md
│   ├── 12_subconsultas_cte.md
│   ├── 13_indices_vistas.md
│   └── 14_transacciones.md
└── proyectos/
    └── proyecto_final.md
```

## 6. Datasets

### Universidad (principal)

- `departamentos`: áreas académicas
- `profesores`: docentes adscritos a un departamento
- `estudiantes`: alumnos con ciudad y fecha de nacimiento
- `cursos`: asignaturas con créditos, profesor y departamento
- `prerrequisitos`: cursos que se deben aprobar antes de otros
- `matriculas`: inscripción de un estudiante a un curso con nota

### Tienda (práctica extra)

- `categorias`, `proveedores`, `productos`
- `clientes`, `pedidos`, `detalle_pedido`

### Biblioteca (práctica extra)

- `autores`, `libros`, `ejemplares`
- `socios`, `prestamos`

## 7. Flujo de una sesión con el tutor

1. El tutor lee `RUTA_BD.md`.
2. Eliges: avanzar, repasar, práctica, revisar SQL, checkpoint o proyecto.
3. Ciclo: concepto → ejemplo ejecutado → ejercicio → revisión → checkpoint.
4. El tutor actualiza `RUTA_BD.md` con lo aprendido y los pendientes.

## 8. Solución de problemas

**`psql: error: connection refused`**
El cluster local no está corriendo:

```bash
cd "/home/thejunax/Documentos/Etapa 5"
./scripts/db_start.sh
```

**`FATAL: role "juan" does not exist` o no conecta**
Asegúrate de cargar las variables y de estar en el puerto correcto:

```bash
source scripts/env.sh
echo "$PGHOST $PGPORT $PGUSER $PGDATABASE"
```

**`permission denied for table ...`**
En el cluster local `juan` es superusuario, así que no debería pasar. Si estás usando el servicio del sistema, otorga permisos:

```bash
sudo -u postgres psql -d curso_bd -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO juan;"
sudo -u postgres psql -d curso_bd -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO juan;"
```

**Quiero empezar de cero**
Vuelve a cargar el esquema del dataset: hace `DROP` y `CREATE` de sus tablas.

```bash
source scripts/env.sh
psql -f datasets/universidad_schema.sql
psql -f datasets/universidad_seed.sql
```

## 9. Referencias

- PostgreSQL 16: https://www.postgresql.org/docs/16/
- `psql`: https://www.postgresql.org/docs/16/app-psql.html
- SQL: https://www.postgresql.org/docs/16/sql.html
