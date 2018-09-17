kubectl exec -it --namespace=kube-system kube-apiserver-kube-um-k8s-master-1 -- cat /etc/kubernetes/ssl/ca.pem > ~/public/kubernetes-ca.crt
