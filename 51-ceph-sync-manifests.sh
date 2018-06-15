files="clusterrole.yaml clusterrolebinding.yaml deployment.yaml role.yaml rolebinding.yaml serviceaccount.yaml storage-class.yaml"
mkdir -p manifests/ceph
cd manifests/ceph || exit 1
rm -f *.yaml
printf "%s\n" $files | xargs -I@ wget https://raw.githubusercontent.com/ceph/ceph-container/master/examples/kubernetes/rbd-provisioner/@
