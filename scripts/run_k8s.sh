#!/usr/bin/env bash

# https://acet.pe.kr/19

# k8s_ghcr: 쿠버네티스 secret 이름
# password 에는 ghcr 패키지용 토큰을 설정한다.
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
# https://loft.sh/blog/docker-compose-to-kubernetes-step-by-step-migration/
function delete_all_service() {
  # delete deploy
  # delete pods(deploy 가 삭제되면 바인딩된 모든 pod 들도 같이 삭제(terminate)되지만, 명시적으로 삭제해주는것이 순서 보장에 좋을듯하다)
  # delete svc
  # pvc / pv 를 삭제하기위해, 위 과정처럼, 바인딩된 deploy, service 를 먼저 지워줘야한다(이는 임시방편이고, 롤링 업데이트 방식으로 바꿔야한다)
  # delete pvc
  # delete pv
  kubectl delete deployment client backend mysql nginx
  kubectl delete svc client backend mysql nginx
  # pvc < pv 순서로 삭제해야한다.
  kubectl delete pvc mysql-data
  kubectl delete pv mysql-data-pv-volume
  kubectl delete sc mysql-data
}

kubectl delete secret k8s-ghcr
# github token 때문에, kube secret 이 생성되지않는다.
# 이 부분도 확인해야한다.
kubectl create secret docker-registry k8s-ghcr \
--docker-server=ghcr.io \
--docker-username=mohwa \
--docker-password=$GHCR_TOKEN \
--docker-email=yanione2@gmail.com

# install kompose
curl -L https://github.com/kubernetes/kompose/releases/download/v1.24.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

cd k8s_config

# kompose convert
# https://kompose.io/user-guide/
kompose -f ../docker-compose.yml convert --replicas 3

client_service_name=$(kubectl get service client -o name 2>/dev/null)

if [ -n "$client_service_name" ]; then
  # 롤링 업데이트
  kubectl set image deployment client client=$CLIENT_IMAGE_NAME --record
  kubectl set image deployment backend backend=$BACKEND_IMAGE_NAME --record
  kubectl set image deployment mysql mysql=$MYSQL_IMAGE_NAME --record
  kubectl set image deployment nginx nginx=$NGINX_IMAGE_NAME --record
else
  delete_all_service

  # persistentVolumeClaim 생성전에 persistentVolume 을 먼저 생성해야한다.
  kubectl apply -f mysql-data-storage-class.yaml
  kubectl apply -f mysql-data-persistentvolume.yaml
  kubectl apply -f .
fi

kubectl get svc
kubectl get deployment
kubectl get pod
kubectl get pvc
kubectl get pv
