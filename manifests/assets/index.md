---
title: UMCloud Kubernetes ![](/umcloud.png){#id .class width=32 height=32}
---

## Usando UMCloud Kubernetes desde tu laptop
1. Instalar kubectl desde <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
2. Preparar la siguiente data
  - _GH\_USER_ : Tu usuario de github
  - _GH\_TOKEN_ : Token generado siguiendo [Generar GITHUB TOKEN](#generar-github-token)
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
kubectl get node
kubectl get pod
kubectl get pod --all-namespaces
```

## Generar GITHUB TOKEN

Loggeado en _GitHUB_, desde <https://github.com/settings/tokens>

1. **[ Generate new token ]** ->
2. Completar:

```
  Token description:
      kube-um       ( NOTA: ejemplo, puede ser cualquier description )

  Select scopes:    ( NOTA: son *3* scopes )
  :
      admin:org
        [x] read:org       Read org and team membership
  :
  :
      user
        [x] read:user      Read all user profile data
        [x] user:email     Access user email addresses (read-only)
```
3. **[ Generate token ]** ->
4. Copiarlo y tenerlo a mano (archivo, etc)

## Referencias

* Kubernetes Github auth _touchEs_ by <https://twitter.com/xjjo> at <https://github.com/jjo/kubernetes-github-authn> ;)
