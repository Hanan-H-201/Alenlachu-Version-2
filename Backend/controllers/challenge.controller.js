import Mood from '../models/mood.model.js';

const dailyChallenges = {
  happy: ['Spread positivity by complimenting someone today.'],
  sad: ['Write down 3 things you’re grateful for.'],
  anxious: ['Do a 5-minute breathing exercise.'],
  angry: ['Take a walk or stretch for 10 minutes.'],
  tired: ['Take a 20-minute power nap or rest.'],
  stressed: ['Write in a journal for 5 minutes.'],
  calm: ['Listen to your favorite song.'],
  excited: ['Plan a creative activity today.'],
  neutral: ['Reflect on your feelings in a journal.']
};

const challengeCache = {}; 
export const getDailyChallenge = async (req, res) => {
  try {
    const userId = req.user?.id || req.body.userId;
    const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD

    
    if (challengeCache[userId] && challengeCache[userId].date === today) {
      return res.status(200).json({ success: true, challenge: challengeCache[userId].challenge });
    }

    const recentMood = await Mood.findOne({ userId }).sort({ createdAt: -1 });

    if (!recentMood) {
      return res.status(404).json({ success: false, message: 'No recent mood found to generate a challenge.' });
    }

    const mood = recentMood.mood;
    const challenges = dailyChallenges[mood] || ['Do something nice for yourself today.'];
    const challenge = challenges[Math.floor(Math.random() * challenges.length)];

    
    challengeCache[userId] = { date: today, challenge };

    res.status(200).json({ success: true, challenge });
  } catch (error) {
    console.error('Error generating challenge:', error);
    res.status(500).json({ success: false, message: 'Server error while generating challenge.' });
  }
};
