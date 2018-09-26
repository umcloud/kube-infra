#!/bin/sh
# Render index.html from index.md, using github-ish CSS
pandoc -c github-pandoc.css ./manifests/assets/index.md > ./manifests/assets/index.html

# Copy locally saved kube CA cert
cp -p ~/public/kubernetes-ca.crt manifests/assets/kube-um-ca.crt

# Create configmap with https://kube.um.edu.ar/ assets contents
kubectl create configmap --namespace=um web-kube-um \
  --from-file=manifests/assets --dry-run -oyaml | kubectl apply -f -

# "Touch" deployment by updating fake envvar ASSETS_CHECKSUM to trigger pods replacement
ASSETS_CHECKSUM=$(cat manifests/assets/*|md5sum|cut -d" " -f1)
sed s/@ASSETS_CHECKSUM@/${ASSETS_CHECKSUM}/ manifests/web-kube-um.yaml | kubectl apply -f -
