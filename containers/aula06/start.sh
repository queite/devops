#!/bin/bash

# Inicie o MySQL
service mysql start

# Configuração do banco de dados MySQL para o WordPress
mysql -u root -e "CREATE DATABASE wordpress;"
mysql -u root -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Inicie o Apache
apache2ctl -D FOREGROUND
