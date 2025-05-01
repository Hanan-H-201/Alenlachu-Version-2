import Mood from '../models/mood.model.js';

/**
 * @desc Create a new mood entry
 * @param {String} userId
 * @param {Object} moodData
 * @returns {Promise<Mood>}
 */
export const createMood = async (userId, moodData) => {
  const { mood, note = '', tags = [], intensity } = moodData;

  const newMood = new Mood({
    userId,
    mood,
    note,
    tags,
    intensity
  });

  return await newMood.save();
};

/**
 * @desc Get all moods for a specific user (latest first)
 * @param {String} userId
 * @returns {Promise<Array>}
 */
export const getAllMoodsByUser = async (userId) => {
  return await Mood.find({ userId }).sort({ createdAt: -1 });
};

/**
 * @desc Generate mood statistics
 * @param {String} userId
 * @returns {Promise<Object>}
 */
export const getMoodStats = async (userId) => {
  const moods = await Mood.find({ userId });

  if (moods.length === 0) {
    return {
      totalEntries: 0,
      mostFrequentMood: null,
      averageIntensity: null,
      moodBreakdown: {}
    };
  }

  const moodCounts = {};
  let totalIntensity = 0;
  let intensityCount = 0;

  moods.forEach(entry => {
    moodCounts[entry.mood] = (moodCounts[entry.mood] || 0) + 1;

    if (typeof entry.intensity === 'number') {
      totalIntensity += entry.intensity;
      intensityCount++;
    }
  });

  const averageIntensity = intensityCount > 0
    ? parseFloat((totalIntensity / intensityCount).toFixed(2))
    : null;

  const mostFrequentMood = Object.entries(moodCounts)
    .sort((a, b) => b[1] - a[1])[0]?.[0] || null;

  return {
    totalEntries: moods.length,
    mostFrequentMood,
    averageIntensity,
    moodBreakdown: moodCounts
  };
};
