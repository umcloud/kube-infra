#!/bin/sh
kubectl apply -f manifests/helm-rbac.yaml
helm init --service-account tiller
