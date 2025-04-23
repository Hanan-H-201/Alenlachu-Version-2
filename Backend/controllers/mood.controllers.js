import { logMood as logMoodService, getMoods as getMoodsService } from '../services/mood.services.js';

export const logMood = async (req, res) => {
    try {
        const { mood, note } = req.body;
        const userId = req.user.id;
        const newMood = await logMoodService(userId, mood, note);
        res.status(201).json({ success: true, data: newMood });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

export const getMoods = async (req, res) => {
    try {
        const userId = req.user.id;
        const moods = await getMoodsService(userId);
        res.status(200).json({ success: true, data: moods });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};