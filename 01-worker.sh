#!/usr/bin/bash
set -o nounset -o errexit

eval $(cat /tmp/kubeadm_join)
systemctl enable docker kubelet
