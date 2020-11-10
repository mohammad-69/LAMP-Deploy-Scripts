#!/bin/bash

# Update Package Index
sudo apt update

# Install Apache2, MySQL, PHP
sudo apt install apache2 mysql-server php php-mysql libapache2-mod-php php-cli

# Allow to run Apache on boot up
sudo systemctl enable apache2

# Restart Apache Web Server
sudo systemctl start apache2

# Adjust Firewall
sudo ufw allow in "Apache Full"

# Allow Read/Write for Owner
sudo chmod -R 0755 /var/www/html/

# Create info.php for testing php processing
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Open localhost in the default browser
xdg-open "http://localhost"
xdg-open "http://localhost/info.php"


sleep 1
echo "------------------------------------";
echo " --- upgrade to php 7.4 --- "
echo "------------------------------------";
# Firstly, to be able to install a certain PHP version, in this case, 7.2 you’ll need to add a certain repository to your system 
sudo apt-add-repository ppa:ondrej/php

#Update the repository index.
sudo apt update

#Install PHP 7.4 with the below command.
sudo apt install -y php7.4 php7.4-cli php7.4-common php7.4-fpm

#To install extensions run
sudo apt install -y php7.4-mysql php7.4-dom php7.4-simplexml php7.4-ssh2 php7.4-xml php7.4-xmlreader php7.4-curl  php7.4-exif  php7.4-ftp php7.4-gd  php7.4-iconv php7.4-imagick php7.4-json  php7.4-mbstring php7.4-posix php7.4-sockets php7.4-tokenizer



sleep 1
echo "------------------------------------";
echo " --- Install Composer --- "
echo "------------------------------------";
cd
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'c31c1e292ad7be5f49291169c0ac8f683499edddcfd4e42232982d0fd193004208a58ff6f353fde0012d35fdd72bc394') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv ./composer.phar /usr/local/bin/composer;
cd /usr/local/bin/
chmod -x ./composer
chmod 777 ./composer