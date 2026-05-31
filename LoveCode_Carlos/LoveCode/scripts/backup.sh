#!/bin/bash
# backup.sh - copia de seguridad de la base de datos LoveCode
# Misma IP y usuario que Carlos tenia en Main.java

HOST="192.168.133.128"
USUARIO="carlos"
PASSWORD="1234"
BASE="LoveCode"

CARPETA="$HOME/backups_lovecode"
FECHA=$(date +"%Y%m%d_%H%M%S")
ARCHIVO="$CARPETA/backup_$FECHA.sql"

mkdir -p "$CARPETA"
echo "Haciendo backup de LoveCode..."

mysqldump --host="$HOST" --user="$USUARIO" --password="$PASSWORD" \
          --routines --triggers "$BASE" > "$ARCHIVO"

if [ $? -eq 0 ]; then
    echo "Backup guardado en: $ARCHIVO"
else
    echo "ERROR: no se pudo hacer el backup"
    exit 1
fi

find "$CARPETA" -name "backup_*.sql" -mtime +7 -delete
echo "Backups viejos borrados (mas de 7 dias)"
