const mysql  = require('mysql');

const pool = mysql.createPool({
    connectionLimit: 10,
    // docker-compose.yml 에서 정의한 mysql service 이름을 정의한다.
    host: 'mysql',
    port: 3306,
    user: 'root',
    password: 'password',
    database: 'myapp',
});

exports.pool = pool;