---
title: UMCloud Kubernetes
---
## Usando UMCloud Kubernetes desde tu laptop
1. Instalar kubectl desde <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
2. Preparar la siguiente data
  - _GH\_USER_ : Tu usuario de github
  - _GH\_TOKEN_ : Token generado siguiendo [la diapo](https://docs.google.com/presentation/d/1qWkmqWtxkbcneU799xzcYnb-AmmnWPUVq2ZjQBJeInM/edit#slide=id.g3b77f3a8c0_0_107)
3. En un shell, ejecutar

```
# Setear manualmente las siguientes variables:
GH_USER="TU_USUARIO_DE_GITHUB"
GH_TOKEN="EL_TOKEN"

# Ejecutar
echo ${GH_USER:?} ${GH_TOKEN:?}
wget https://www.kube.um.edu.ar/kube-um-ca.crt
kubectl config set-cluster --certificate-authority=$PWD/kube-um-ca.crt \
  --server https://api.kube.um.edu.ar:6443 kube-um
kubectl config set-context --cluster=kube-um --user=um-${GH_USER} \
  --namespace=${GH_USER} kube-um-${GH_USER}
kubectl config set-credentials um-${GH_USER} --token ${GH_TOKEN}
kubectl config use-context kube-um-${GH_USER}
kubectl config view

# Probar
kubectl get pod
kubectl get pod --all-namespaces
```
