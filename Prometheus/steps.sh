curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack
kubectl get ds
kubectl patch ds prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'

# Updatated formatting

kubectl get deploy

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
prometheus-grafana                    1/1     1            1           2m7s
prometheus-kube-prometheus-operator   1/1     1            1           2m7s
prometheus-kube-state-metrics         1/1     1            1           2m7s
sample-node-app-deploy                3/3     3            3           23h


kubectl get statefulset

NAME                                                   READY   AGE
alertmanager-prometheus-kube-prometheus-alertmanager   1/1     2m12s
prometheus-prometheus-kube-prometheus-prometheus       1/1     2m12s

# The prometheus instance is using a ClusterIP service called prometheus-kube-prometheus-prometheus, 
# which means it is only accessible within the cluster, and we can’t access the UI by default.

export KUBE_EDITOR="code --wait"

kubectl edit svc prometheus-kube-prometheus-prometheus

# Make some changes in this service. 
# Change type: ClusterIP to type: NodePort and 
# add nodePort: 30111 under - name: http-web.


kubectl get svc 

# Verify if it is updated to NodePort

kubectl get nodes -o wide

# FInd the IP and go to ip:30111 to check Prometheus server

# Now, configure an ingress to forward traffic to the prometheus service.

kubectl apply -f ingress.yaml

kubectl apply -f api-deploy.yaml

kubectl apply -f api-service.yml