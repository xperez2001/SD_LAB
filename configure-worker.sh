#!/bin/bash

echo "Introduce el nombre del host"
read wName

#hostnamectl set-hostname $wName

echo "\nIntroduce la IP y el nombre de la interfaz de Internet del nodo master"
read mNameI mIPI
echo "\nIntroduce la IP y el nombre de la interfaz Middle del nodo master"
read mName mIP

echo "127.0.0.1    localhost
127.0.1.1    $wName

$mNameI    $mIPI
$mName    $mIP" #> etc/hosts
