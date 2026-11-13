#!/usr/bin/env bash
# Variables de entorno del curso.
# Uso: source scripts/env.sh

export PGHOST=localhost
export PGPORT=5433
export PGUSER=juan
export PGDATABASE=curso_bd
export PATH="/usr/lib/postgresql/16/bin:$PATH"
# Evita que psql abra el paginador (less) y se quede en (END)
export PAGER=cat
export PSQL_PAGER=cat
