import express from 'express';
import { logMood, getAllMoods, getMoodStats } from '../controllers/mood.controllers.js';
import { fakeUser } from '../middleware/fakeUser.js';

const router = express.Router(); 
// Use the fakeUser middleware for all mood routes
// This provides a mock req.user object so we can simulate logged-in behavior
router.use(fakeUser);

// Route: POST /api/mood
router.post('/', logMood);

// Route: GET /api/mood
//  Retrieves all mood entries associated with the user
router.get('/', getAllMoods);

// Route: GET /api/mood/stats
// Returns aggregated statistics for the user's mood history
router.get('/stats', getMoodStats);

export default router;
