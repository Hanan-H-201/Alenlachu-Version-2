const Post = require('../models/post.model');
const fs = require('fs');
const path = require('path');

exports.createPost = async ({ content, tags = '', privacy, image, userId }) => {
  const post = new Post({
    user: userId,
    content,
    tags: tags ? tags.split(',').map(tag => tag.trim()) : [],
    privacy,
  });

  if (image) {
    const imageBuffer = Buffer.from(image, 'base64');
    const uploadsDir = path.join(__dirname, '..', 'uploads');
    if (!fs.existsSync(uploadsDir)) {
      fs.mkdirSync(uploadsDir);
    }
    const imagePath = path.join(uploadsDir, `${Date.now()}.png`);
    fs.writeFileSync(imagePath, imageBuffer);
    post.image = path.basename(imagePath);
  }

  await post.save();
};

exports.getPosts = async (req) => {
  const posts = await Post.find()
    .populate('user', 'username')
    .sort({ createdAt: -1 })
    .exec();

  return posts.map(post => ({
    ...post._doc,
    image: post.image ? `${req.protocol}://${req.get('host')}/uploads/${post.image}` : null,
  }));
};

exports.updatePost = async ({ postId, content, image, tags, privacy, userId }) => {
  const post = await Post.findOne({ _id: postId, user: userId });
  if (!post) throw new Error('Post not found');

  post.content = content || post.content;
  post.image = image || post.image;
  post.tags = tags || post.tags;
  post.privacy = privacy || post.privacy;

  await post.save();
};

exports.deletePost = async ({ postId, userId }) => {
  const post = await Post.findOneAndDelete({ _id: postId, user: userId });
  if (!post) throw new Error('Post not found');
};

exports.likePost = async ({ postId, userId }) => {
  const post = await Post.findById(postId);
  if (!post) throw new Error('Post not found');

  if (post.likes.includes(userId)) {
    post.likes = post.likes.filter(id => id.toString() !== userId.toString());
  } else {
    post.likes.push(userId);
  }

  await post.save();
};

exports.unlikePost = async ({ postId, userId }) => {
  const post = await Post.findById(postId);
  if (!post) throw new Error('Post not found');

  if (!post.likes.includes(userId)) {
    throw new Error('Post not liked');
  }

  post.likes = post.likes.filter(id => id.toString() !== userId.toString());
  await post.save();
};

exports.getNumberLikes = async ({ postId }) => {
  const post = await Post.findById(postId);
  if (!post) throw new Error('Post not found');

  return post.likes.length;
};
