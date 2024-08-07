const Comment = require('../models/comment.model');
const Post = require('../models/post.model');

exports.addComment = async ({ postId, content, userId }) => {
  const comment = new Comment({ user: userId, post: postId, content });
  await comment.save();

  const post = await Post.findById(postId);
  post.comments.push(comment._id);
  await post.save();
};

exports.getComments = async ({ postId }) => {
  const comments = await Comment.find({ post: postId })
    .populate('user', 'username')
    .exec();
  return comments;
};

exports.updateComment = async ({ commentId, content, userId }) => {
  const comment = await Comment.findOne({ _id: commentId, user: userId });
  if (!comment) throw new Error('Comment not found');

  comment.content = content || comment.content;
  await comment.save();
};

exports.deleteComment = async ({ commentId, userId }) => {
  const comment = await Comment.findOneAndDelete({ _id: commentId, user: userId });
  if (!comment) throw new Error('Comment not found');

  const post = await Post.findById(comment.post);
  post.comments = post.comments.filter(id => id.toString() !== commentId.toString());
  await post.save();
};
