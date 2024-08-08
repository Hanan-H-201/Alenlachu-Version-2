const postService = require('../services/post.services');

exports.createPost = async (req, res) => {
  const { content, tags, privacy, image, userId } = req.body;

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
    const posts = await postService.getPosts();
    res.json(posts);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.getPostById = async (req, res) => {
  const { id } = req.query; // Changed to query parameter
  try {
    const post = await postService.getPostById(id);
    res.json(post);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.updatePost = async (req, res) => {
  const { id } = req.query; // Changed to query parameter
  const { content, image, tags, privacy, userId } = req.body;

  try {
    await postService.updatePost(id, { content, image, tags, privacy, userId });
    res.send('Post updated');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.deletePost = async (req, res) => {
  const { id } = req.query; // Changed to query parameter
  try {
    await postService.deletePost(id);
    res.send('Post deleted');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.likePost = async (req, res) => {
  const { id, userId } = req.query; // Changed to query parameter
  try {
    await postService.likePost(id, userId);
    res.send('Post liked');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.unlikePost = async (req, res) => {
  const { id, userId } = req.query; // Changed to query parameter
  try {
    await postService.unlikePost(id, userId);
    res.send('Post unliked');
  } catch (error) {
    res.status(500).send('Server error');
  }
};

exports.getNumberLikes = async (req, res) => {
  const { id } = req.query; // Changed to query parameter
  try {
    const likes = await postService.getNumberLikes(id);
    res.json({ numberOfLikes: likes });
  } catch (error) {
    res.status(500).send('Server error');
  }
};
