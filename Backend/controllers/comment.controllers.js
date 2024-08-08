const commentService = require('../services/comment.services');

exports.addComment = async (req, res) => {
  const { postId, userId } = req.query; // Fetch postId and userId from query parameters
  const { content } = req.body;

  try {
    await commentService.addComment({ postId, content, userId });
    res.status(201).send('Comment added');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.getComments = async (req, res) => {
  const { postId } = req.query; // Fetch postId from query parameters

  try {
    const comments = await commentService.getComments({ postId });
    res.json(comments);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.updateComment = async (req, res) => {
  const { commentId } = req.params;
  const { content, userId } = req.query; // Fetch userId from query parameters

  try {
    await commentService.updateComment({ commentId, content, userId });
    res.send('Comment updated');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.deleteComment = async (req, res) => {
  const { commentId } = req.params;
  const { userId } = req.query; // Fetch userId from query parameters

  try {
    await commentService.deleteComment({ commentId, userId });
    res.send('Comment deleted');
  } catch (error) {
    res.status(500).send('Server error');
  }
};
