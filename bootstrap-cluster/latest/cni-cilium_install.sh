#!/bin/sh
# Source: https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/

echo "### INSTALL CILIUM CLI ###"

CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

CILIUM_VERSION=1.17.2
echo "### INSTALL CILIUM ${CILIUM_VERSION} TO CLUSTER"
cilium install --version ${CILIUM_VERSION}

echo "EXECUTE: cilium status --wait"
cilium status --wait

echo "CHECK NODES ARE READY STATE"
kubectl get node
