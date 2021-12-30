const express = require('express');
const router = express.Router();
const mysql = require('mysql');

router.get('/diary', function(req, res){ // 다이어리 페이지 주소로 수정
    con.query(`INSERT INTO diary (diary_date, diary_title, diary_context, diary_img) VALUES (\'${diary_date}\', \'${diary_title}\',\'${diary_context}\', \'${diary_img}\');`, (err) => {
        // DB: diary 테이블에 image 추가
        // front: 제목 입력부분 추가
        // 작성자 어떻게 추가?
        
        if (err) {
            console.log('diary add fail')
        }
        else{
            console.log('diary add success')
        }
    });
})