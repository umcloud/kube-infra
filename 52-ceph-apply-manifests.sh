MONITORS="172.16.16.64 172.16.16.65 172.16.16.66"
typeset -i n=1
# https://github.com/kubernetes-incubator/external-storage/issues/778#issuecomment-397339040
## UNUSED since 2018-10-31, monitors via xio.io
for mon in ${MONITORS:?}; do
  kubectl apply -f - << EOF
kind: Service
apiVersion: v1
metadata:
  name: ceph-mon-${n:?}
  namespace: ceph
spec:
  type: ExternalName
  externalName: ${mon:?}.xip.io
EOF
  n=$((n+1))
done
(
cd manifests/ceph || exit 1
sed -i 's,image: .*,image: "quay.io/external_storage/rbd-provisioner:latest",' deployment.yaml
#sed -i -e "s/monitors: .*/monitors: ceph-mon-1.ceph.svc.cluster.local./" storage-class.yaml
#sed -i -e "s/monitors: .*/monitors: ceph-mon-1.ceph.svc.cluster.local.:6789,ceph-mon-2.ceph.svc.cluster.local.:6789,ceph-mon-3.ceph.svc.cluster.local.:6789/" storage-class.yaml
sed -i -e "s/monitors: .*/monitors: 172.16.16.64.xip.io:6789,172.16.16.65.xip.io:6789,172.16.16.66.xip.io:6789/" storage-class.yaml
)
kubectl delete storageclass rbd
kubectl apply -f manifests/ceph
kubectl patch storageclass rbd -p '{"metadata":{"annotations": {"storageclass.beta.kubernetes.io/is-default-class": "true"}}}'
kubectl create rolebinding --namespace=ceph --clusterrole=edit --serviceaccount=ceph:rbd-provisioner ceph-jjo-extra-rb
