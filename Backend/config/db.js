const mongoose = require('mongoose');

const mongoUri = process.env.MONGO_URL;

mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
.then(()=>console.log("MongoDB Connected"))
.catch((err)=>console.log(err));
