#!/bin/bash

# Archivo de log para la salida del script
# Cada ejecución creará un archivo de log con fecha y hora en /tmp/
LOG_FILE="/tmp/set_hyprsunset_$(date +%Y%m%d_%H%M%S).log"
# Redirige la salida estándar (stdout) y la salida de error estándar (stderr) al archivo de log
exec > "${LOG_FILE}" 2>&1

echo "Iniciando script de configuración de hyprsunset..."
echo "Fecha y hora actual: $(date)"
echo "Usuario actual: $(whoami)"
echo "PATH actual: $PATH"
echo "HYPRLAND_INSTANCE_SIGNATURE: $HYPRLAND_INSTANCE_SIGNATURE" # Variable de entorno importante para hyprctl

# Verifica si el proceso hyprsunset está corriendo antes de enviar comandos
# Esto ayuda a asegurar que el comando hyprctl tenga a dónde conectarse
# Esperamos un poco más aquí también, por si el sleep en hyprland.conf no fue suficiente
sleep 2 # Espera 2 segundos adicionales dentro del script

if pgrep hyprsunset > /dev/null; then
    echo "Proceso hyprsunset encontrado. Enviando comandos hyprctl..."
    /usr/bin/hyprctl hyprsunset temperature 4000
    echo "Comando temperature 4000 ejecutado. Código de salida: $?"
    /usr/bin/hyprctl hyprsunset gamma 90
    echo "Comando gamma 90 ejecutado. Código de salida: $?"
else
    echo "Proceso hyprsunset no encontrado. No se pueden enviar comandos hyprctl."
fi

echo "Script de configuración de hyprsunset finalizado."
