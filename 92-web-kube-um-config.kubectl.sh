pandoc -c github-pandoc.css ./manifests/assets/index.md > ./manifests/assets/index.html
cp -p ~/public/kubernetes-ca.crt manifests/assets/kube-um-ca.crt
kubectl create configmap --namespace=um web-kube-um \
  --from-file=manifests/assets --dry-run -oyaml | kubectl apply -f -
ASSETS_CHECKSUM=$(cat manifests/assets/*|md5sum|cut -d" " -f1)
sed s/@ASSETS_CHECKSUM@/${ASSETS_CHECKSUM}/ manifests/web-kube-um.yaml | kubectl apply -f -
