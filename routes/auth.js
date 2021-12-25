const express = require('express');
const router = express.Router();
const mysql = require('mysql');

const con = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'qlenfrlsms99', // 비밀번호
    database: 'projectDB'
});
con.connect();

router.post('/signup', function (req, res) { // 하위 링크 수정
    var email = req.body.email;
    var pwd = req.body.pwd;
    var nickname = req.body.nickname; 
    var user_name = req.body.user_name;
    var mobile = req.body.mobile;
    // addr는 프로필 설정할 때 추가

    con.query(`INSERT INTO user (email, pwd, nickname, user_name, mobile) VALUES (\'${email}\', \'${pwd}\',\'${nickname}\', \'${user_name}\', \'${mobile}\');`, (err) => {
        if (err) res.json({ success: false, msg: 'signup fail' });
        else res.json({ success: true, msg: 'signup success' });
    });
});


router.post('/signin', function (req, res) { // 하위 링크 수정
    var email = req.body.email; 
    var pwd = req.body.pwd;

    con.query(`SELECT * FROM user WHERE email='${email}' AND pwd='${pwd}';`, (err, row) => {
        if (err) {
            res.json({ success: false, msg: 'signin fail' });
        }
        else if (row.length == 0) {
            res.json({ success: false, msg: 'signin fail' });
        }
        else {
            // email, password 대조

        }
    });
});
