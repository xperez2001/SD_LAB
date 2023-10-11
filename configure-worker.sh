#!/bin/bash

wIP=$(hostname -I)

echo "Nombre del host"
read wName
echo "IP y nombre del nodo master (Internet)"
read mNameI mIPI
echo "IP y nombre del nodo master (Middle)"
read mName mIP


echo "Actualizando el hostname..."
hostnamectl set-hostname $wName
sleep 1


echo "Actualizando la tabla de hosts..."
echo "127.0.0.1    localhost
127.0.1.1    $wName

$mNameI    $mIPI
$mName    $mIP" > etc/hosts
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

source /etc/network/interfaces.d/*.cfg" > etc/network/interfaces


echo "Reiniciando el servicio de red..."
systemctl restart networking