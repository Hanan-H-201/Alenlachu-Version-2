import dotenv from 'dotenv';
dotenv.config();

import mongoose from 'mongoose';

const mongoUri = process.env.MONGO_URL;

mongoose.connect(mongoUri)
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.log(err));

export default mongoose;
