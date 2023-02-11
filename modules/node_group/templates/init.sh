#!/bin/bash

apt-get -yq update
apt-get install -yq \
    ca-certificates \
    curl \
    ntp

node_internal_ip=$(ifconfig ens10 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p') 


# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} K3S_URL=https://${master_ipv4}:6443 K3S_TOKEN=${k3s_token} sh -s - \
    --kubelet-arg 'cloud-provider=external' --node-ip ${node_internal_ip}
