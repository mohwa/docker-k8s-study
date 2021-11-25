# docker-compose-dev.yml 파일이 존재하는 곳으로 이동한다.
# $(dirname $0): 실행된 sh 파일의 상대 디렉토리(root 디렉토리에서 실행된 경우, ./scirpts 경로가 반환된다)
BASE_PATH=$(cd $(dirname $0) && pwd)
EXEC_PATH=$(cd $BASE_PATH/.. && pwd)

chmod +x $BASE_PATH/k8s_env_build.sh
chmod +x $BASE_PATH/k8s_pkg_cfg.sh
chmod +x $BASE_PATH/master_node.sh
chmod +x $BASE_PATH/work_nodes.sh

vagrant up