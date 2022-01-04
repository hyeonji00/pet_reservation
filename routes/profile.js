const router = require('express').Router();
var con = require('./db.js');


router.post('/pet', function (req, res) {
    var image = req.body.image;
    var name = req.body.name;
    var type = req.body.type;
    var neutering = req.body.neutering;
    var age = req.body.age;
    var weight = req.body.weight;
    var breed = req.body.breed;

    con.query(`INSERT INTO pet (image, name, type, neutering, age, weight, breed) VALUES (\'${image}\', \'${name}\', \'${type}\', \'${neutering}\',\'${age}\',\'${weight}\',\'${breed}\',);`, (err) => {
        if (err) res.json({ success: false, msg: 'register fail' });
        else res.json({ success: true, msg: 'register success' });
    });
});

module.exports = router;