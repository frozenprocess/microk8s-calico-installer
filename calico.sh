#!/bin/bash

# Am i root?
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if microk8s is installed
if [ $(microk8s status | grep running | wc -l) -ne 1 ]; then
        echo "Cannot find MicorK8s"
        exit
fi

# change default cluster-cidr
if grep -qE "\-\-cluster-cidr=.*$" /var/snap/microk8s/current/args/kube-proxy; then
sed -i 's/--cluster-cidr=.*$/--cluster-cidr=192.168.0.0\/16/' /var/snap/microk8s/current/args/kube-proxy
fi

# enable ip forwarding
if [ $(cat /proc/sys/net/ipv4/ip_forward) -ne 1 ]; then
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p
fi

# Give privilege to pods
if [ $(egrep 'allow-privileged=true' /var/snap/microk8s/current/args/kube-apiserver | wc -l) -eq 0 ]; then
sed -i 's/--insecure-port/--allow-privileged=true\n--insecure-port/' /var/snap/microk8s/current/args/kube-apiserver 
fi

# change containerd default bin folder
if [ $(egrep 'bin_dir = "\$\{SNAP\}' /var/snap/microk8s/current/args/containerd-template.toml | wc -l) -ne 0 ]; then
sed -i 's/bin_dir = "${SNAP}/bin_dir = "${SNAP_DATA}/' /var/snap/microk8s/current/args/containerd-template.toml
fi

if grep -qE 'cni-bin-dir=${SNAP}' /var/snap/microk8s/current/args/kubelet ; then
sed -i 's/cni-bin-dir=${SNAP}/cni-bin-dir=${SNAP_DATA}/' /var/snap/microk8s/current/args/kubelet
fi

# Turn off flannel restart microk8s
microk8s disable flannel && microk8s stop && microk8s start

# Install Claico modified manifest
if [[ ! -z "$1" && $1 == 'master' ]]; then
# Enable DNS
microk8s enable dns

microk8s kubectl apply -f calico.yaml
fi

echo "Installation completed!"
