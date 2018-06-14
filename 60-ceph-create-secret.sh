test -f secrets/ceph-rbd-kube.yaml -a  -f secrets/ceph-secret-admin.yaml || {
echo "# At the ceph mon run:"
echo "ceph auth get client.admin 2>&1 |sed -n 's/.*key.=.//p' # KEY1" 
echo "ceph auth get-or-create client.kube mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=kube' -o ceph.client.kube.keyring"
echo "sed -n 's/.*key.=.//p' ceph.client.kube.keyring  # KEY2'
echo "# Here:
echo "kubectl --namespace=ceph create secret generic ceph-secret-admin --from-literal=key=KEY1 --type=kubernetes.io/rbd --dry-run -o yaml > secrets/ceph-secret-admin.yaml"
echo "kubectl --namespace=ceph create secret generic ceph-rbd-kube     --from-literal=key=KEY2 --type=kubernetes.io/rbd --dry-run -o yaml > secrets/ceph-rbd-kube.yaml"
exit 1
} || exit 1
set -x
kubectl apply -f secrets/ceph-secret-admin.yaml
kubectl apply -f secrets/ceph-rbd-kube.yaml
