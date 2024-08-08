const express = require('express');
const router = express.Router();
const postController = require('../controllers/post.controllers');

// Create a new post
router.post('/posts', postController.createPost);

// Get all posts
router.get('/posts', postController.getPosts);

// Get a post by ID
router.get('/posts/:id', postController.getPostById); // Updated to use route parameter

// Update a post
router.put('/posts/:id', postController.updatePost); // Updated to use route parameter

// Delete a post
router.delete('/posts/:id', postController.deletePost); // Updated to use route parameter

// Like a post
router.put('/posts/like', postController.likePost); // Updated to use query parameters

// Unlike a post
router.put('/posts/unlike', postController.unlikePost); // Updated to use query parameters

// Get number of likes for a post
router.get('/posts/likes', postController.getNumberLikes); // Updated to use query parameters

module.exports = router;
