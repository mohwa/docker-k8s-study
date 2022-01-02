ARG USER_NAME=app
ARG HOME=/home/$USER_NAME
ARG MY_APP=$HOME/my-app

# 각 커맨드들의 사용 방법을 알 수 있다.
# http://pyrasis.com/docker.html

# 버전 차이로 인한 여러 문제를 방지하기위해, 앱 개발 시, 사용된 버전을 명확히 명시한다.
FROM node:16.13.0 AS builder

# FROM 안에서 재 선언한다.
# https://stackoverflow.com/questions/53681522/share-variable-in-multi-stage-dockerfile-arg-before-from-not-substituted
ARG USER_NAME
ARG HOME
ARG MY_APP

# app 유저를 추가한다.(/home/app 폴더도 같이 생성된다)
# /bin/false 에 대한 글
# https://faq.hostway.co.kr/Linux_ETC/1624
RUN useradd --user-group --create-home --shell /bin/false $USER_NAME
# my_app 디렉토리를 추가한다.
# app 유저 권한을 $HOME 디렉토리에 하위에 모두 추가한다.
RUN mkdir -p $MY_APP &&\
    chown -R $USER_NAME:$USER_NAME $HOME/*

WORKDIR $MY_APP

# RUN, CMD, ENTRYPOINT 명령이 수행될 유저를 설정한다.
# http://pyrasis.com/book/DockerForTheReallyImpatient/Chapter07/12
USER $USER_NAME
# 호스트와 연결될 포트 번호를 설정한다.
EXPOSE 5000

# ADD / COPY 시, 아래처럼 소유자 및 그룹을 설정할 수 있다.
# https://github.com/moby/moby/issues/6119#issuecomment-338920866
COPY --chown=$USER_NAME:$USER_NAME package.json $MY_APP

# 인스톨에의해 생성되는 모든 파일/디렉토리들은 USER 명령에 의해, app 유저 권한을 갖게된다.
# 도커는 package.json 파일이 변경된 경우에만, npm i 명령을 다시 실행한다.
RUN npm i

# 이미지 생성 시, 컨텍스트안의 파일 및 디렉토리들을 이미지에 복사한다.
COPY --chown=$USER_NAME:$USER_NAME . $MY_APP

# 이지미 생성 시, npm 패키지들을 설치한다.
RUN npm run build

FROM nginx as nginx

ARG USER_NAME
ARG MY_APP

EXPOSE 3000

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder --chown=$USER_NAME:$USER_NAME $MY_APP/dist /usr/share/nginx/html



