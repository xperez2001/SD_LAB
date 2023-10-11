#!/bin/bash

mIP=$(hostname -I | awk '{print $2}')
mIPI=$(hostname -I | awk '{print $1}')

echo "Nombre del host"
read mName
echo "IP y nombre del nodo worker"
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


echo "Reiniciando el servicio de red..."
systemctl restart networking