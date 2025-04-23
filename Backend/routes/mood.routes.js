import express from 'express';
import { logMood, getMoods } from '../controllers/mood.controllers.js';
import { fakeUser } from '../middleware/fakeUser.js';
const router = express.Router();


router.use(fakeUser);

router.post('/', logMood);
router.get('/', getMoods);

export default router;
