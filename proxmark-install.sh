#!/bin/bash

#Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
morado="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gris="\e[0;37m\033[1m"
fin="\033[0m\e[0m"

#Variable del usuario
USUARIO=${SUDO_USER:-$USER}

#Instalar dependencias
sudo apt update && sudo apt upgrade -y

sudo apt-get install -y git ca-certificates build-essential pkg-config libreadline-dev gcc-arm-none-eabi libnewlib-dev qtbase5-dev libbz2-dev libbluetooth-dev libpython3-dev libssl-dev make cmake gcc

#Instalar depencia para evitar posible error
sudo apt install -y libpcsclite-dev

#Clonar repositorio
git -C /home/$USUARIO/ clone https://github.com/Proxmark/proxmark3.git

#Acceder alrepositorio y compilar
cd /home/$USUARIO/proxmark3/
make clean 
make all 

#Descargar diccionario para fuerzabruta
cd /home/$USUARIO/proxmark3/client/
wget https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/mfc_default_keys.dic
sleep 2
diccionario=$(readlink -e mfc_default_keys.dic)


#Respuesta al usuario
RUTA_PROXMARK=$(readlink -e proxmark3)
echo -e "${amarillo}Hola${fin} ${verde}$USUARIO${fin}"
echo -e "${amarillo}Ejecuta${fin} ${verde}./proxmark3 ${amarillo}en la ruta ->${fin} ${turquesa}$RUTA_PROXMARK${fin}"
echo -e "${amarillo}Tambien se a descargado un diccionaro mas completo en la ruta ->${fin} ${turquesa}$diccionario${fin}"
exit
