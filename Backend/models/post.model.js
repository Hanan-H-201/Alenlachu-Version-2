const mongoose = require('mongoose');

const { Schema } = mongoose;

const postSchema = new Schema({
  user: { 
    type: Schema.Types.ObjectId, 
    ref: 'User', 
    required: true 
  },
  content: { 
    type: String, 
    required: true 
  },
  image: { 
    type: String 
  },
  tags: [{ 
    type: String 
  }],
  privacy: { 
    type: String, 
    enum: ['public', 'private'], 
    default: 'public' 
  },
  likes: [{ 
    type: Schema.Types.ObjectId, 
    ref: 'User' 
  }],
  comments: [{ 
    type: Schema.Types.ObjectId, 
    ref: 'Comment' 
  }]
}, { 
  timestamps: true 
});

const PostModel = mongoose.model('Post', postSchema);

module.exports = PostModel;
