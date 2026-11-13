#!/usr/bin/env bash
set -euo pipefail

BASE="${HOME}/.local/share/curso_bd"
PGBIN="/usr/lib/postgresql/16/bin"
DATA="${BASE}/data"
SOCKET="${BASE}/run"
PORT=5433
COURSE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -x "${PGBIN}/initdb" ]; then
    echo "No encuentro PostgreSQL 16 en ${PGBIN}" >&2
    echo "Instálalo con: sudo apt install -y postgresql postgresql-contrib" >&2
    exit 1
fi

if [ ! -d "$DATA" ]; then
    echo "Inicializando cluster local en ${DATA}..."
    mkdir -p "$BASE" "$SOCKET"
    "$PGBIN/initdb" -D "$DATA" -U juan \
        --auth-local=trust --auth-host=trust \
        --encoding=UTF8 --locale=C.UTF-8
fi

"$COURSE_DIR/scripts/db_start.sh"

if ! "$PGBIN/psql" -h localhost -p "$PORT" -U juan -d postgres -tAc \
        "SELECT 1 FROM pg_database WHERE datname = 'curso_bd'" | grep -q 1; then
    "$PGBIN/createdb" -h localhost -p "$PORT" -U juan curso_bd
    echo "Base curso_bd creada."
fi

for ds in universidad tienda biblioteca; do
    echo "Cargando dataset: ${ds}"
    "$PGBIN/psql" -h localhost -p "$PORT" -U juan -d curso_bd \
        -v ON_ERROR_STOP=1 -q -f "${COURSE_DIR}/datasets/${ds}_schema.sql"
    "$PGBIN/psql" -h localhost -p "$PORT" -U juan -d curso_bd \
        -v ON_ERROR_STOP=1 -q -f "${COURSE_DIR}/datasets/${ds}_seed.sql"
done

echo ""
echo "Listo. Base curso_bd en localhost:${PORT} (usuario juan, sin contraseña)."
"$PGBIN/psql" -h localhost -p "$PORT" -U juan -d curso_bd -c "\dt"
