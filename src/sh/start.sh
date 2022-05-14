#!/bin/bash

echo root:$ROOT_PASSWORD| chpasswd
sh -c "/bin/echo -e "y" | ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -P '' -N ''"
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
/etc/init.d/ssh restart

export ROOT_PASSWORD=not_password
ROOT_PASSWORD=not_password

php -S 0.0.0.0:80 -t /var/www/html/