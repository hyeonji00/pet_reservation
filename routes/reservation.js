const router = require('express').Router();
var con = require('./db.js');


router.post('/reservation', function (req, res) { // 하위 링크 수정
    var name = req.body.name;
    var mobile = req.body.mobile;
    var addr = req.body.addr;
    var time = req.body.time;
    var type = req.body.type;

    var user_id = req.body.user_id;
    var date = new Date(req.body.date);


    con.query(`INSERT INTO service (name, mobile, addr, time, type) VALUES (\'${name}\', \'${mobile}\',\'${addr}\',\'${time}'\,\'${type}'\);`, function(err, result1, field) {
        if (err) res.json(err);
        else{
            if (err) console.log('insert service error');
            else{
                tmp_service = result1[0].insertId;
                con.query(`INSERT INTO reservation (date, svc_id, client_id) VALUES (\'${date}\', \'${temp_service}\',\'${user_id}\');`, (err) => {
                if (err) res.json({ success: false, msg: 'reservation save fail' });
                else res.json({ success: true, msg: 'reservation save success' });
            });
        }
        }
    });    
});

router.post('/review', function (req, res) { // 하위 링크 수정
    var review_id = req.body.review_id;
    var score = req.body.score;
    var svc_id = req.body.svc_id;
    var context = req.body.context;
    con.query(`INSERT INTO review (score, context) VALUES (\'${score}\', \'${context}\');`, (err) => {
        if (err) res.json({ success: false, msg: 'res fail' });
        else res.json({ success: true, msg: 'res success' });
    });
});

module.exports = router;