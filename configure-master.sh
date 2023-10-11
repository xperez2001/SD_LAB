#!/bin/bash

echo "Introduce el nombre del host"
read name

hostnamectl set-hostname $name