#! /bin/bash

#Debe mostrar tiempo total de conexión(horas minutos)  del usuario dado en el periodo de tiempo indicado, conexión con el mayor tiempo de duración y  desde que dirección IP se produjo.
#Argumentos: -ficheroConexiones(la ruta al fichero que contiene los datos de conexión al server) y user(nombre). mes(opcional) 

if [ $# -gt 3 -o $# -lt 2 ]; then
    echo "Modo de uso: $0 ficheroConexiones user [ mes ]"
fi
dir=$1
user=$2
if ! [ -d "$dir" ]; then
    echo "Ruta $dir no existe o bien no corresponde a un fichero"
    exit 0
elif [ -f "$dir" ]; then
    echo "Ruta $dir no existe o bien no corresponde a un fichero"
    exit 0
fi

if [ $user = "reboot" ]; then
    echo "Usuario no válido: $user"
    exit 0
fi

if [ $3 != "Jan" -a $3 != "Feb" -a $3 != "Mar" -a $3 != "Apr" -a $3 != "May" -a $3 != "Jun" -a $3 != "Jul" -a $3 != "Aug" -a $3 != "Sep" -a $3 != "Oct" -a $3 != "Nov" -a $3 != "Dec" ];then
    echo "Eso no es un mes"
    
if [ $# -eq 3 ]; then
    tiempoMes="True"
elif [ $# -eq 2 ]; then
    tiempoMes="False"
fi
    
temp=$(mktemp)
cat $dir > $temp

totalHoras=0
totalMinutos=0
horasMax=0
minMax=0

while read nombreUsuario d2 d3 month d5 d6 d7 d8 totalTime ip
do
    if [ $tiempoMes = "True" ];then
        if [ $nombreUsuario = $user ];then
            horas_u=${totalTime%"\*:"}
            minutos_u=${totalTime#"\:*"}
            
            let totalHoras=totalHoras+horas_u
            let totalMinutos=totalMinutos+minutos_u
            
            if [ $horas_u -gt $horasMax ];then 
                $horasMax=$horas_u
                $minMax=$min_u
            elif [ $horas_u -eq $horasMax ]; then
                if [ $min_u -gt $minMax ]; then
                    $horasMax=$horas_u
                    $minMax=$min_u
                fi
            fi
    fi
    else
        if [ $tiempoMes = "False" ];then
            if [ $nombreUsuario = $user ];then
                horas_u=${totalTime%"\*:"}
                minutos_u=${totalTime#"\:*"}
                
                let totalHoras=totalHoras+horas_u
                let totalMinutos=totalMinutos+minutos_u
                
                if [ $horas_u -gt $horasMax ];then 
                    $horasMax=$horas_u
                    $minMax=$min_u
                elif [ $horas_u -eq $horasMax ]; then
                    if [ $min_u -gt $minMax ]; then
                        $horasMax=$horas_u
                        $minMax=$min_u
                    fi
                fi
        fi
    fi
    
done 
rm $temp

echo "El usuario $user ha estado conectado un total de:\n\t * $totalHoras horas y $totalMinutos minutos\n\n Tiempo máximo de conexión: $horasMax horas y $minMax minutos desde $ip"

exit 0














