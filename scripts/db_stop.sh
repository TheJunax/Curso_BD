#!/usr/bin/env bash
set -euo pipefail

BASE="${HOME}/.local/share/curso_bd"
PGBIN="/usr/lib/postgresql/16/bin"
DATA="${BASE}/data"

if [ ! -d "$DATA" ]; then
    echo "No existe el cluster local."
    exit 0
fi

if "$PGBIN/pg_ctl" -D "$DATA" status >/dev/null 2>&1; then
    "$PGBIN/pg_ctl" -D "$DATA" -m fast -w stop
    echo "PostgreSQL local detenido."
else
    echo "PostgreSQL local ya estaba detenido."
fi
