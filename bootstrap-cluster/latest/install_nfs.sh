#!/bin/sh
# Source: https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04

sudo apt update
sudo apt install nfs-kernel-server
sudo mkdir /var/nfs/data -p
sudo chown nobody:nogroup /var/nfs/data
# Allow all RFC-1912
echo "/var/nfs/data 192.168.0.0/16(rw,sync,no_root_squash,no_subtree_check)" | sudo tee /etc/exports
echo "/var/nfs/data 172.16.0.0/12(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
echo "/var/nfs/data 10.0.0.0/8(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports

sudo systemctl restart nfs-kernel-server
