import {
    createMood as createMoodService,
    getAllMoodsByUser,
    getMoodStats as getMoodStatsService
  } from '../services/mood.services.js';
  
  /**
   * @desc Log a new mood
   * @route POST /api/mood
   */
  export const logMood = async (req, res) => {
    try {
      const userId = req.user?.id || req.body.userId;
      const newMood = await createMoodService(userId, req.body);
      res.status(201).json({ success: true, data: newMood });
    } catch (error) {
      console.error('Error logging mood:', error);
      res.status(500).json({ success: false, message: 'Server error while logging mood' });
    }
  };
  
  /**
   * @desc Get all moods for the logged-in user
   * @route GET /api/mood
   */
  export const getAllMoods = async (req, res) => {
    try {
      const userId = req.user?.id || req.params.userId;
      const moods = await getAllMoodsByUser(userId);
      res.status(200).json({ success: true, data: moods });
    } catch (error) {
      console.error('Error fetching moods:', error);
      res.status(500).json({ success: false, message: 'Server error while fetching moods' });
    }
  };
  
  /**
   * @desc Get mood statistics
   * @route GET /api/mood/stats
   */
  export const getMoodStats = async (req, res) => {
    try {
      const userId = req.user?.id || req.params.userId;
      const stats = await getMoodStatsService(userId);
      res.status(200).json({ success: true, data: stats });
    } catch (error) {
      console.error('Error fetching mood stats:', error);
      res.status(500).json({ success: false, message: 'Server error while fetching mood stats' });
    }
  };
  