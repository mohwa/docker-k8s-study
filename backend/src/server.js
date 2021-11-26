const express = require('express');
const bodyParser = require('body-parser');
const db = require('./db');

// backend 서버 포트
const PORT = 5000;

const app = express();

app.use(bodyParser.json());

app.get('/api/app_info', (req, res) => {
    db.pool.query('SELECT * FROM app_info LIMIT 1;', (error, results, fields) => {
        if (error) {
            return res.status(500).send(error);
        } else {
            const result = results?.[0] || {};

            console.log(result);

            return res.json(result);
        }
    });
});

app.post('/api/app_info', (req, res) => {
    const { bgColor } = req.body;

    db.pool.query(`REPLACE INTO app_info (id, bg_color) VALUES (1, "${bgColor}");`, (error, results, fields) => {
        if (error) {
            return res.status(500).send(error);
        } else {
            return res.json({});
        }
    });
});

app.listen(PORT, () => {
    console.log(`Running backend server`);
});