import Mood from '../models/mood.model.js';

export const logMood = async (userId, mood, note) => {
    const newMood = new Mood({ userId, mood, note });
    return await newMood.save();
};

export const getMoods = async (userId) => {
    return await Mood.find({ userId }).sort({ createdAt: -1 });
};