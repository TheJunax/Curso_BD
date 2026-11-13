#!/usr/bin/env bash
set -euo pipefail

BASE="${HOME}/.local/share/curso_bd"
PGBIN="/usr/lib/postgresql/16/bin"
DATA="${BASE}/data"

if [ ! -d "$DATA" ]; then
    echo "Cluster local no inicializado. Corre: scripts/db_init.sh"
    exit 1
fi

"$PGBIN/pg_ctl" -D "$DATA" status || true
