# CI 영역
FROM node:alpine as builder
WORKDIR /usr/src/app
COPY ./ ./
RUN npm install
CMD ["npm", "run", "build"]

# CD 영역
FROM nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html



