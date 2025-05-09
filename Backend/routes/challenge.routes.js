import express from 'express';
import { getDailyChallenge } from '../controllers/challenge.controller.js';
import { fakeUser } from '../middleware/fakeUser.js'; 

const router = express.Router();

// Apply the fakeUser middleware to all routes in this router
// This simulates authentication and provides a req.user object
router.use(fakeUser);

// Route: GET /api/challenge/
// Returns the daily challenge for the authenticated (fake) user
router.get('/', getDailyChallenge);


export default router;
