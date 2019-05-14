echo "Get SLACK_TOKEN from: https://api.slack.com/custom-integrations/legacy-tokens"
set -e
: ${SLACK_TOKEN:?}
envsubst < manifests/kubewatch-values.yaml.env > secrets/kubewatch-values.yaml
helm upgrade --install --namespace kube-system kubewatch stable/kubewatch --values=secrets/kubewatch-values.yaml
