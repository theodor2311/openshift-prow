#!/bin/bash

cat <<EOSECRET | oc apply -f -
apiVersion: v1
data:
  config: $(cat <<EOF  | base64 -w0
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: $(oc whoami --show-server)
  name: $(oc config current-context | cut -d '/' -f2)
contexts:
- context:
    cluster: $(oc config current-context | cut -d '/' -f2)
    user: system:serviceaccount:prow:prow-pipeline
  name: /$(oc config current-context | cut -d '/' -f2)/system:serviceaccount:prow:prow-pipeline
current-context: /$(oc config current-context | cut -d '/' -f2)/system:serviceaccount:prow:prow-pipeline
kind: Config
preferences: {}
users:
- name: system:serviceaccount:prow:prow-pipeline
  user:
    token: $(oc sa get-token prow-pipeline -n prow)
EOF
)
kind: Secret
metadata:
  name: kubeconfig
  namespace: prow
type: Opaque
EOSECRET