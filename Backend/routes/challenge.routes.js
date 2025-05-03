import express from 'express';
import { getDailyChallenge } from '../controllers/challenge.controller.js';
import { fakeUser } from '../middleware/fakeUser.js'; // or real auth if in use

const router = express.Router();

router.use(fakeUser);

router.get('/', getDailyChallenge);

export default router;
