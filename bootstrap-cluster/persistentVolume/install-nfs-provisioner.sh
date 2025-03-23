#!/bin/sh
NFS_SERVER=192.168.116.128
NFS_PATH="/var/nfs/data"
sudo snap install helm --classic
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update
helm -n  nfs-provisioner install nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --create-namespace --set nfs.server=${NFS_SERVER} --set nfs.path=${NFS_PATH} --set storageClass.defaultClass=true --set replicaCount=1 --set storageClass.name=nfs --set storageClass.provisionerName=nfs-provisioner  
