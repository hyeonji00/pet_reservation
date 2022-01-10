const router = require('express').Router();
var con = require('./db.js');


router.post('/reservation', function (req, res) { // 하위 링크 수정
    var name = req.body.name;
    var mobile = req.body.mobile;
    var addr = req.body.addr;
    var time = req.body.time;
    var type = req.body.type;

    var user_id = req.body.user_id;
    var pet_id = req.body.pet_id;
    var date = req.body.date;
    const date_time = new Date(date).toISOString().slice(0,19).replace('T', ' ');

    con.query(`INSERT INTO user_pet (user_id, pet_id) VALUES (\'${user_id}\', \'${pet_id}\');`, function(err, result) {
        if (err) res.json(err);
        else {
            // res.json({ success: true, msg: 'user-pet success' });
            let user_pet_id = result.insertId;
            con.query(`INSERT INTO service (name, mobile, addr, time, type) VALUES (\'${name}\', \'${mobile}\',\'${addr}\',\'${time}'\,\'${type}'\);`, function(err, result1) {
                if (err) res.json({ success: false, msg: 'insertion fail' });
                else{
                    let srv_no = result1.insertId; 
                    con.query(`INSERT INTO reservation (date, svc_id, client_id) VALUES (\'${date_time}\', \'${srv_no}\',\'${user_pet_id}\');`, (err) => {
                            if (err) res.json(err);
                            else res.json({ success: true, msg: 'reservation save success' });
                        });
                }
            });  
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