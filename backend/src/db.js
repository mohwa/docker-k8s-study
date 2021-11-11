const mysql  = require('mysql');

const {
    MYSQL_HOST,
    MYSQL_PORT,
    MYSQL_ROOT_USER,
    MYSQL_ROOT_PASSWORD,
    MYSQL_DATABASE,
} = process.env;

console.log(MYSQL_HOST);

const pool = mysql.createPool({
    connectionLimit: 10,
    // docker-compose.yml 에서 정의한 mysql service 이름을 정의한다.
    host: MYSQL_HOST,
    port: MYSQL_PORT,
    user: MYSQL_ROOT_USER,
    password: MYSQL_ROOT_PASSWORD,
    database: MYSQL_DATABASE,
});

exports.pool = pool;