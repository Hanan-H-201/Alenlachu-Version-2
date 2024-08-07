const postService = require('../services/postService');

exports.createPost = async (req, res) => {
  const { content, tags, privacy, image } = req.body;
  const userId = req.user.id;

  try {
    await postService.createPost({ content, tags, privacy, image, userId });
    res.status(201).send('Post created');
  } catch (error) {
    console.error('Error creating post:', error);
    res.status(500).send('Server error');
  }
};

exports.getPosts = async (req, res) => {
  try {
    const posts = await postService.getPosts(req);
    res.json(posts);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.updatePost = async (req, res) => {
  const { postId } = req.params;
  const { content, image, tags, privacy } = req.body;
  const userId = req.user.id;

  try {
    await postService.updatePost({ postId, content, image, tags, privacy, userId });
    res.send('Post updated');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.deletePost = async (req, res) => {
  const { postId } = req.params;
  const userId = req.user.id;

  try {
    await postService.deletePost({ postId, userId });
    res.send('Post deleted');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.likePost = async (req, res) => {
  const { postId } = req.params;
  const userId = req.user.id;

  try {
    await postService.likePost({ postId, userId });
    res.send('Post liked/unliked');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.unlikePost = async (req, res) => {
  const { postId } = req.params;
  const userId = req.user.id;

  try {
    await postService.unlikePost({ postId, userId });
    res.send('Post unliked');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.getNumberLikes = async (req, res) => {
  const { postId } = req.params;

  try {
    const likes = await postService.getNumberLikes({ postId });
    res.json({ likes });
  } catch (error) {
    res.status(500).send('Server error');
  }
};
