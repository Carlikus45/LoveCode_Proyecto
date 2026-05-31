#!/bin/bash
# arranque.sh - arranca MariaDB y el servidor Java de LoveCode

JAR="$HOME/lovecode/backend/target/demo-1.0-SNAPSHOT.jar"
LOG="$HOME/lovecode/servidor.log"

echo "Arrancando LoveCode..."

echo "1. Comprobando MariaDB..."
if systemctl is-active --quiet mariadb; then
    echo "   MariaDB ya esta corriendo"
else
    echo "   Arrancando MariaDB..."
    sudo systemctl start mariadb
    sleep 2
    if systemctl is-active --quiet mariadb; then
        echo "   MariaDB arrancada"
    else
        echo "   ERROR: no arranco MariaDB"
        exit 1
    fi
fi

echo "2. Comprobando conexion a la BD..."
mysql -h 192.168.133.128 -u carlos -p1234 -e "USE LoveCode;" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   Conexion OK"
else
    echo "   ERROR: no se puede conectar a la BD"
    exit 1
fi

echo "3. Arrancando servidor Java (Spring Boot)..."
if [ ! -f "$JAR" ]; then
    echo "   ERROR: no se encuentra el JAR en $JAR"
    echo "   Primero haz: cd backend && mvn package"
    exit 1
fi

PID_VIEJO=$(pgrep -f "demo-1.0-SNAPSHOT.jar")
if [ -n "$PID_VIEJO" ]; then
    echo "   Parando servidor anterior (PID $PID_VIEJO)..."
    kill "$PID_VIEJO"
    sleep 1
fi

nohup java -jar "$JAR" >> "$LOG" 2>&1 &
PID=$!
sleep 2

if kill -0 "$PID" 2>/dev/null; then
    echo "   Servidor arrancado (PID $PID)"
else
    echo "   ERROR: el servidor no arranco, mira el log: $LOG"
    exit 1
fi

echo ""
echo "LoveCode funcionando!"
echo "Backend:  http://localhost:8080"
echo "Frontend: abre frontend/index.html en el navegador"
