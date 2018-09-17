kubectl apply -f https://storage.googleapis.com/knative-releases/serving/latest/istio.yaml
kubectl label namespace default istio-injection=enabled
