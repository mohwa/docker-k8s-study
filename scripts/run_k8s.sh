#!/usr/bin/env bash

# k8s_ghcr: 쿠버네티스 secret 이름
# password 에는 ghcr 패키지용 토큰을 설정한다.
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
# https://loft.sh/blog/docker-compose-to-kubernetes-step-by-step-migration/
secret_name=$(kubectl get secret k8s-ghcr -o name 2>/dev/null)

# 반환된 secret_name 값이 있다면
if [ -n "$secret_name" ]; then
  kubectl delete secret k8s-ghcr
fi

# github token 때문에, kube secret 이 생성되지않는다.
# 이 부분도 확인해야한다.
kubectl create secret docker-registry k8s-ghcr \
--docker-server=ghcr.io \
--docker-username=mohwa \
--docker-password=$GHCR_TOKEN \
--docker-email=yanione2@gmail.com

# default serviceaccount 에 생성된 imagePullSecrets 를 추가한다.
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "k8s-ghcr"}]}'

# echo ${{ secrets.GHCR_TOKEN }} | docker login https://ghcr.io -u mohwa --password-stdin

# install kompose
curl -L https://github.com/kubernetes/kompose/releases/download/v1.24.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

cd k8s_config

kompose -f ../docker-compose.yml convert --replicas 3
# find -name "*.yaml" -exec sed -i "s/extensions\/v1beta1/apps\/v1/g" {} \;

# 상황에 따라, deployment(pods), service 를 재배포하는것이 아닌, kubectl set 으로 pod 에 포함된 container(name으로) 이미지만 Rolling 업데이트할 수 있다.

# 기존 pv 를 삭제한다.
pv_name=$(kubectl get pv mysql-data-pv-volume -o name 2>/dev/null)

# 반환된 pvc_name 값이 있다면
if [ -n "$pv_name" ]; then
  kubectl delete pv mysql-data-pv-volume
fi

# 기존 pvc 를 삭제한다.
pvc_name=$(kubectl get pvc mysql-data -o name 2>/dev/null)

# 반환된 pvc_name 값이 있다면
if [ -n "$pvc_name" ]; then
  kubectl delete pvc mysql-data
fi

# persistentVolumeClaim 생성전에 persistentVolume 을 먼저 생성한다.(또는 해야한다)
kubectl create -f mysql-data-persistentvolume.yaml
# 모든 설정들을 반영한다.
kubectl apply -f .
kubectl get svc