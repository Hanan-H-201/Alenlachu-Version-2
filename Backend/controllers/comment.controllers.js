const commentService = require('../services/comment.services');

exports.addComment = async (req, res) => {
  const { postId } = req.params;
  const { content } = req.body;
  const userId = req.user.id;

  try {
    await commentService.addComment({ postId, content, userId });
    res.status(201).send('Comment added');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.getComments = async (req, res) => {
  const { postId } = req.params;

  try {
    const comments = await commentService.getComments({ postId });
    res.json(comments);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.updateComment = async (req, res) => {
  const { commentId } = req.params;
  const { content } = req.body;
  const userId = req.user.id;

  try {
    await commentService.updateComment({ commentId, content, userId });
    res.send('Comment updated');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.deleteComment = async (req, res) => {
  const { commentId } = req.params;
  const userId = req.user.id;

  try {
    await commentService.deleteComment({ commentId, userId });
    res.send('Comment deleted');
  } catch (error) {
    res.status(500).send('Server error');
  }
};
