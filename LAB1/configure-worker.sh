#!/bin/bash

#Para verificar que se ejecuta como super user
if [[ $EUID -ne 0 ]]; then
   echo "error: no puede realizar esta operación, a menos que sea superusuario." 
   exit 1
fi

wIP=$(hostname -I)

echo -n "Nombre del host: "
read wName
echo -n "IP y nombre del nodo master (Internet): "
read mIPI mNameI
echo -n "IP y nombre del nodo master (Middle): "
read mIP mName 


echo "Actualizando el hostname..."
hostnamectl set-hostname $wName
sleep 1


echo "Actualizando la tabla de hosts..."
echo "127.0.0.1    localhost
127.0.1.1    $wName

$mIPI    $mNameI    
$mIP    $mName" > /etc/hosts
sleep 1


echo "Actualizando el Gateway..."
echo "auto lo
iface lo inet loopback

auto ens3
iface ens3 inet static
  address $wIP
  network 20.20.20.0
  netmask 255.255.254.0
  gateway $mIP

source /etc/network/interfaces.d/*.cfg" > /etc/network/interfaces
sleep 1


echo "Reiniciando el servicio de red..."
systemctl restart networking


echo "Creando un nuevo usuario..."
echo -n "Nombre: "
read newUser

adduser $newUser
sleep 1


echo "Editando los permisos del usuario..."
echo "$newUser ALL=(ALL:ALL) ALL" >> /etc/sudoers
sleep 1