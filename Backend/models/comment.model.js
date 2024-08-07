const mongoose = require('mongoose');

const { Schema } = mongoose;

const commentSchema = new Schema({
  user: { 
    type: Schema.Types.ObjectId, 
    ref: 'User', 
    required: true 
  },
  post: { 
    type: Schema.Types.ObjectId, 
    ref: 'Post', 
    required: true 
  },
  content: { 
    type: String, 
    required: true 
  }
}, { 
  timestamps: true 
});

const CommentModel = mongoose.model('Comment', commentSchema);

module.exports = CommentModel;
