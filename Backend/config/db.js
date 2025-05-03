import dotenv from 'dotenv';
dotenv.config();

import mongoose from 'mongoose';

const mongoUrl = process.env.MONGO_URL;

mongoose.connect(mongoUrl)
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.log(err));

export default mongoose;
