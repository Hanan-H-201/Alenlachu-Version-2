import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();
const mongoUri = process.env.MONGO_URL;

const CreateDB = mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.log(err));
export { CreateDB };
export default mongoose ;


