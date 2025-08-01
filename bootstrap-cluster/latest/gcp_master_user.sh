#!/bin/sh
mkdir -p ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config

### finished
echo
echo "### COMMAND TO ADD A WORKER NODE ###"
kubeadm token create --print-join-command --ttl 0

### kubectl completion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
sudo chmod a+r /etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
source ~/.bashrc
