#!/bin/bash

# Shutdown firewall
systemctl disable firewalld
systemctl stop firewalld

# Install wget
if ! rpm -qa | grep wget; then
  yum -y install wget
fi

chown -R vagrant:vagrant /home/vagrant

#if [ ! -d "/home/vagrant/certs" ]; then
#  mkdir /home/vagrant/certs
#fi

# Download Chef Server RPM
wget https://packages.chef.io/files/stable/chef-server/12.17.33/el/7/chef-server-core-12.17.33-1.el7.x86_64.rpm -P /home/vagrant

if ! grep -q "192.168.123.10 chef-server" /etc/hosts; then
cat >> /etc/hosts <<EOL
192.168.123.10 chef-server
192.168.123.11 node1
192.168.123.12 node2
192.168.123.13 node3
EOL
fi
