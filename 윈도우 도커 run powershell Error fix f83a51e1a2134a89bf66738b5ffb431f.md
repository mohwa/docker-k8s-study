# 윈도우 도커 run powershell Error fix

How to fix docker error invalid reference format error?

docker run -p 5000:8080 -v /usr/src/app/node_modules -v "D:/git/docker-codes/nodejs-docker-app:/usr/src/app" smileajw1004/nodes

예시
      docker run -it -p 3000:3000 -v /usr/src/app/node_modules -v ${pwd}:/usr/src/app     

      smileajw1004/docker-react-app

파워쉘에서는 현재디렉토리를 ${pwd}로 표현하고 리눅스에서는 $(pwd)로 표현해야 한다.

![https://user-images.githubusercontent.com/85863175/147849386-d17e28d9-49dd-456a-9493-72d8e260183f.png](https://user-images.githubusercontent.com/85863175/147849386-d17e28d9-49dd-456a-9493-72d8e260183f.png)

참고

[https://stackoverflow.com/questions/41485217/mount-current-directory-as-a-volume-in-docker-on-windows-10](https://stackoverflow.com/questions/41485217/mount-current-directory-as-a-volume-in-docker-on-windows-10)