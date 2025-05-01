import mongoose from 'mongoose';

const MoodSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true
    },
    mood: {
      type: String,
      enum: [
        'happy', 'sad', 'angry', 'anxious',
        'neutral', 'excited', 'tired', 'stressed', 'calm'
      ],
      required: true
    },
    intensity: {
      type: Number,
      min: 1,
      max: 10,
      default: 5
    },
    note: {
      type: String,
      trim: true,
      default: ''
    },
    tags: {
      type: [String],
      default: []
    }
  },
  {
    timestamps: { createdAt: true, updatedAt: false }
  }
);

const Mood = mongoose.model('Mood', MoodSchema);
export default Mood;
