const express = require('express');
const path = require('path');

const app = express();

app.set('view engine', 'ejs'); 
app.set('views', './views');
app.engine('html', require('ejs').renderFile);

app.get('/', function (req, res){
    res.render("main");
})

app.listen(3000,()=>{
    console.log('connect');
})