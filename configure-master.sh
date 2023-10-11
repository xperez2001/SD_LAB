#!/bin/bash

echo "Introduce el nombre del host"
read mName

#hostnamectl set-hostname $mName

echo "Introduce la IP y el nombre del nodo worker"
read wIP wName

echo "127.0.0.1    localhost
127.0.1.1    $mName

$wIP    $wName" #> etc/hosts
