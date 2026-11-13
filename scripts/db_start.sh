#!/usr/bin/env bash
set -euo pipefail

BASE="${HOME}/.local/share/curso_bd"
PGBIN="/usr/lib/postgresql/16/bin"
DATA="${BASE}/data"
SOCKET="${BASE}/run"
PORT=5433

if [ ! -d "$DATA" ]; then
    echo "No existe el cluster local. Corre primero: scripts/db_init.sh" >&2
    exit 1
fi

mkdir -p "$SOCKET"

if "$PGBIN/pg_ctl" -D "$DATA" status >/dev/null 2>&1; then
    echo "PostgreSQL local ya está corriendo en localhost:${PORT}"
    exit 0
fi

"$PGBIN/pg_ctl" -D "$DATA" \
    -l "${BASE}/postgres.log" \
    -o "-p ${PORT} -k ${SOCKET} -c listen_addresses=localhost" \
    -w start

echo "PostgreSQL local iniciado en localhost:${PORT}"
