const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const app = express();

var cors = require('cors');
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:false}));
app.use(logger('dev'));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.set('view engine', 'jade');



const profile = require('./profile');
app.use('/profile', profile);

const auth = require('./auth');
app.use('/auth', auth);

const diary = require('./diary');
app.use('/diary', diary);

const reservation = require('./reservation');
app.use('/reservation', reservation);

app.listen(3000, () => {
    console.log('server connected');
});