#!/bin/bash

# Update the system
apt-get update && apt-get upgrade -y

# Install necessary packages
apt-get install -y fail2ban ufw

# Configure SSH
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Enable UFW firewall
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Mark the script as completed
touch /var/log/hardening_done.log
