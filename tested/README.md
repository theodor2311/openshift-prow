# Archive tested prow deployment manifests
This is from archive from kubernetes/test-infra/config/prow/cluster/starter-s3.yaml with modification for OpenShift use specific.
## To deploy starter-s3.yaml
Replace *<<insert-token-here>>* with your github(bot) token.
E.g Using sed to update the manifest
```bash
sed -i 's/<<insert-token-here>>/!!!YOUR_GITHUB_TOKEN!!!/' starter-s3.yaml
```
Replace << insert-hmac-token-here >> with the Github Webhook secret, you may generate your secret with following command:
```bash
openssl rand -hex 20
```
E.g Using sed to update the manifest
```bash
sed -i 's/<< insert-hmac-token-here >>/!!!YOUR_WEBHOOK_SECRET!!!/' starter-s3.yaml
```
Replace << your-domain.com >> with your OpenShift domain, you may use the following command to get your default domain.
```bash
oc get IngressController default -n openshift-ingress-operator -ojsonpath='{.status.domain}'
```
E.g Using sed to update the manifest
```bash
sed -i "s/<< your-domain.com >>/!!!YOUR_DOMAIN!!!/" starter-s3.yaml
```
Replace << your_github_org >> with your github organization name.
E.g Using sed to update the manifest
```bash
sed -i 's/<< your_github_org >>/!!!YOUR_GITHUB_ORG!!!/' starter-s3.yaml
```
Optionally changing the Minio access and secret key.
E.g Using sed to update the manifest
```bash
sed -i 's/<<CHANGE_ME_MINIO_ACCESS_KEY>>/!!!YOUR_DESIRED_ACCESS_KEY!!!/' starter-s3.yaml
sed -i 's/<<CHANGE_ME_MINIO_SECRET_KEY>>/!!!YOUR_DESIRED_SECRET_KEY!!!/' starter-s3.yaml
```
After updated the manifest, apply the manifest to your cluster.
```bash
oc apply -f starter-s3.yaml
```
