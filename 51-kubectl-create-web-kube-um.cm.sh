pandoc -c github-pandoc.css ./manifests/assets/index.md > ./manifests/assets/index.html
cp -p ~/public/kubernetes-ca.crt manifests/assets/kube-um-ca.crt
kubectl create configmap --namespace=kube-system web-kube-um \
  --from-file=manifests/assets --dry-run -oyaml | kubectl apply -f -
kubectl delete pod --namespace=kube-system -l app=web-kube-um
