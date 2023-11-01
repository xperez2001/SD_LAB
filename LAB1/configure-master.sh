#!/bin/bash

#Para verificar que se ejecuta como super user
if [[ $EUID -ne 0 ]]; then
   echo "error: no puede realizar esta operación, a menos que sea superusuario." 
   exit 1
fi

mIP=$(hostname -I | awk '{print $2}')
mIPI=$(hostname -I | awk '{print $1}')

echo -n "Nombre del host: "
read mName
echo -n "IP y nombre del nodo worker: "
read wIP wName
sleep 1


echo "Actualizando el hostname..."
hostnamectl set-hostname $mName
sleep 1


echo "Actualizando la tabla de hosts..."
echo "127.0.0.1    localhost
127.0.1.1    $mName

$wIP    $wName" > /etc/hosts
sleep 1


echo "Activando el IP forwarding..."
sed -i '/net.ipv4.ip_forward=1/s/#//g' /etc/sysctl.conf
sleep 1


echo "Actualizando las tablas nat..."
iptables -t nat -A POSTROUTING -s 20.20.20.0/23 -o ens3 -j SNAT --to $mIPI
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
iptables -A FORWARD -i ens3 -o ens4 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ens4 -o ens3 -j ACCEPT
sleep 1


echo "Haciendo efectivo el IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
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


echo "Enviando el fichero de configuració al nodo worker..."
scp configure-worker.sh adminuser@$wName:/home/adminuser/