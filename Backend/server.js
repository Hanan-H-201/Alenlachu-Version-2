const bodyParser = require("body-parser");
const express = require("express");
const dotenv = require('dotenv').config();
const db = require("./config/db");



const port = process.env.PORT || 3000;
const app = express();

app.use(bodyParser.json());

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
  });

 
app.listen(port, ()=>{
    console.log(`Server is running on port ${port}`)
});