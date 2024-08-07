const express = require('express');
const router = express.Router();

const{createPost, getPosts, getPostById, updatePost, deletePost, likePost, unlikePost, getNumberLikes} = require('../controllers/post.controllers');

router.post('/createPost', createPost);
router.get('/getPosts', getPosts);
router.post('/getPostById', getPostById);
router.put('/updatePost', updatePost);
router.delete('/deletePost', deletePost);
router.put('/likePost', likePost);
router.put('/unlikePost', unlikePost);
router.post('/getNumberLikes', getNumberLikes);
