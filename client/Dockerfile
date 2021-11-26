FROM node:alpine as builder
WORKDIR /usr/app
# package.json 파일이 수정되었을 경우에만 의존성 설치를 하기위해, COPY 영역을 아래처럼, 나누었다.
# 즉 package.json 파일이 수정되지않았을 경우, build 시, npm i 명령은 실행되지않는다.
COPY ./package.json ./
RUN npm i --silent
COPY ./ ./
RUN npm run build

FROM nginx as nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/app/dist /usr/share/nginx/html



