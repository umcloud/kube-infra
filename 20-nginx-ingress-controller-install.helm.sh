#helm install stable/nginx-ingress --name nginx-ingress --set rbac.create=true --namespace ingress-nginx --set controller.hostNetwork=true --set controller.kind=DaemonSet
helm install stable/nginx-ingress --name nginx-ingress --set rbac.create=true --namespace ingress-nginx
