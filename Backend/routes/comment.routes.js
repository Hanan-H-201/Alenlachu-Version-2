const express = require('express');
const router = express.Router();
const commentController = require('../controllers/comment.controllers');

// Add a comment
router.post('/addComment', commentController.addComment);

// Get comments for a post
router.get('/getComments', commentController.getComments);

// Update a comment
router.put('/updateComment/:commentId', commentController.updateComment);

// Delete a comment
router.delete('/deleteComment/:commentId', commentController.deleteComment);

module.exports = router;
