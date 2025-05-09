import mongoose from 'mongoose';

const MoodSchema = new mongoose.Schema(
  {
    // The ID of the user who logged this mood (reference to user, though ref is omitted for now)
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      required: true                // Required to associate each mood with a specific user
    },

    // The mood type selected by the user from predefined options
    mood: {
      type: String,
      enum: [
        'happy', 'sad', 'angry', 'anxious',
        'neutral', 'excited', 'tired', 'stressed', 'calm' // Accepted mood types
      ],
      required: true               // Mood must be provided
    },

    // Intensity level of the mood, on a scale of 1–10
    intensity: {
      type: Number,
      min: 1,
      max: 10,
      default: 5                   // Defaults to a medium intensity if not provided
    },

    // Optional note explaining the reason or context of the mood
    note: {
      type: String,
      trim: true,                 
      default: ''
    },

    // Optional tags for categorizing or filtering mood entries
    tags: {
      type: [String],
      default: []
    }
  },
  {
    // Automatically adds createdAt timestamp; updatedAt is disabled
    timestamps: { createdAt: true, updatedAt: false }
  }
);

const Mood = mongoose.model('Mood', MoodSchema);
export default Mood;
