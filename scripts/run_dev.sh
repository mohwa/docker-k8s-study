#!/usr/bin/env bash

# docker-compose-dev.yml 파일이 존재하는 곳으로 이동한다.
# $(dirname $0): 실행된 sh 파일의 상대 디렉토리(root 디렉토리에서 실행된 경우, ./scirpts 경로가 반환된다)
BASE_PATH=$(cd $(dirname $0) && pwd)
EXEC_PATH=$(cd $BASE_PATH/.. && pwd)

echo $BASE_PATH

chmod +x $BASE_PATH/run.sh

# docker project name 이 "/" 문자를 허용하지않아, 해당 문자를 "-" 로 대치시켰다.
# 대문자를 모두 소문자로 대치시켰다.
# 전체 문자부터 반환한다.
PROJECT_NAME=$(echo $EXEC_PATH | sed 's/\//-/g' | tr '[A-Z]' '[a-z]' | awk '{ print substr($0, 2) }')-dev

COMMAND="cd $EXEC_PATH && docker-compose -f docker-compose-dev.yml -p $PROJECT_NAME up --force-recreate -d"

if [[ "$#" -ge 1 ]]; then
  while (("$#")); do
    case "$1" in
      --no-build)
         echo $COMMAND && eval $COMMAND
        shift
        ;;
      *)
        COMMAND+=" --build"

         echo $COMMAND && eval $COMMAND
        shift
        ;;
    esac
  done
else
  COMMAND+=" --build"

   echo $COMMAND && eval $COMMAND
fi