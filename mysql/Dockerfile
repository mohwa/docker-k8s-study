FROM mysql:5.7

# 호스트와 연결될 포트 번호를 설정한다.
EXPOSE 3306
ADD ./sqls /docker-entrypoint-initdb.d
ADD ./my.cnf /etc/mysql/conf.d/my.cnf
