kubectl apply -f manifests/openebs-storageclasses.yaml
kubectl patch storageclass openebs-standalone -p '{"metadata":{"annotations": {"storageclass.beta.kubernetes.io/is-default-class": "true"}}}'
