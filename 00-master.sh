#!/usr/bin/bash
set -o nounset -o errexit

envsubst < /tmp/kubeadm.config.bashtpl > /tmp/kubeadm.config
kubeadm init --config /tmp/kubeadm.config
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown core:core $HOME/.kube/config
systemctl enable docker kubelet

kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

# used to join nodes to the cluster
kubeadm token create --print-join-command > /tmp/kubeadm_join
# used to setup kubectl 
chown core /etc/kubernetes/admin.conf
