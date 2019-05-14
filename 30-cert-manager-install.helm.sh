# From https://docs.cert-manager.io/en/latest/getting-started/install.html
kubectl label namespace kube-system certmanager.k8s.io/disable-validation="true" --overwrite
helm repo add jetstack https://charts.jetstack.io || true
helm repo update
helm upgrade --install --namespace kube-system cert-manager jetstack/cert-manager --version v0.7.2
