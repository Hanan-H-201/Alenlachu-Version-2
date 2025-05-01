import express from 'express';
import { logMood, getAllMoods, getMoodStats } from '../controllers/mood.controllers.js';
import { fakeUser } from '../middleware/fakeUser.js';

const router = express.Router();

router.use(fakeUser);

router.post('/', logMood);
router.get('/', getAllMoods);
router.get('/stats', getMoodStats);

export default router;
