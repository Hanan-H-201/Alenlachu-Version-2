import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:app/services/common/post_service.dart';
import 'package:app/services/common/comment_service.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VentingScreen extends StatelessWidget {
  const VentingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venting Posts'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: TimelinePage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<dynamic> posts = [];
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      final response = await _postService.getAllPosts();
      setState(() {
        posts = json.decode(response.body);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: posts.map((post) {
        return Post(
          profileImage: post['profileImage'],
          name: post['name'],
          timeAgo: post['timeAgo'],
          text: post['text'],
          postImage: post['postImage'],
          postId: post['postId'],
        );
      }).toList(),
    );
  }
}

class Post extends StatefulWidget {
  final String profileImage;
  final String name;
  final String timeAgo;
  final String text;
  final String postImage;
  final String postId;

  const Post({
    required this.profileImage,
    required this.name,
    required this.timeAgo,
    required this.text,
    required this.postImage,
    required this.postId,
    super.key,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;
  int likes = 0;
  bool showAllComments = false;
  List<String> comments = [];
  final PostService _postService = PostService();
  final CommentService _commentService = CommentService();

  @override
  void initState() {
    super.initState();
    fetchLikesAndComments();
  }

  void fetchLikesAndComments() async {
    // Fetch likes and comments count here if available
  }

  void toggleLike() async {
    final userId = context.read<AuthenticationCubit>().state
            is AuthenticatedAsClient
        ? (context.read<AuthenticationCubit>().state as AuthenticatedAsClient)
            .client
            .id
        : null;

    if (userId == null) {
      print('User is not authenticated');
      return;
    }

    try {
      final response = isLiked
          ? await _postService.unlikePost(widget.postId, userId)
          : await _postService.likePost(widget.postId, userId);

      if (response.statusCode == 200) {
        setState(() {
          isLiked = !isLiked;
          isLiked ? likes++ : likes--;
        });
      } else {
        print('Failed to like/unlike post');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void addComment(String comment) async {
    final userId = context.read<AuthenticationCubit>().state
            is AuthenticatedAsClient
        ? (context.read<AuthenticationCubit>().state as AuthenticatedAsClient)
            .client
            .id
        : null;

    if (userId == null) {
      print('User is not authenticated');
      return;
    }

    try {
      // Call the service method and wait for it to complete
      await _commentService.addComment(
        widget.postId,
        userId,
        comment,
      );

      // No result to check, just update the state
      setState(() {
        comments.add(comment);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.profileImage),
              ),
              title: Text(
                widget.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              subtitle: Text(widget.timeAgo),
              trailing: const Icon(Icons.more_vert),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.text),
            ),
            if (widget.postImage.isNotEmpty) Image.network(widget.postImage),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined),
                  onPressed: toggleLike,
                  color: isLiked ? Colors.blue : null,
                ),
                Text('$likes likes'),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {
                    // Handle comment navigation
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed: () {
                    // Handle share
                  },
                ),
              ],
            ),
            CommentSection(
              postId: widget.postId,
              comments: comments,
              showAllComments: showAllComments,
              toggleShowAllComments: () {
                setState(() {
                  showAllComments = !showAllComments;
                });
              },
              addComment: addComment,
            ),
          ],
        ),
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final String postId;
  final List<String> comments;
  final bool showAllComments;
  final VoidCallback toggleShowAllComments;
  final Function(String) addComment;

  const CommentSection({
    required this.postId,
    required this.comments,
    required this.showAllComments,
    required this.toggleShowAllComments,
    required this.addComment,
    super.key,
  });

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  late List<String> _comments;
  late bool _showAllComments;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comments = widget.comments;
    _showAllComments = widget.showAllComments;
  }

  @override
  Widget build(BuildContext context) {
    final visibleComments =
        _showAllComments ? _comments : _comments.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Comments',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ...visibleComments.map((comment) => ListTile(title: Text(comment))),
        if (_comments.length > 3)
          TextButton(
            onPressed: widget.toggleShowAllComments,
            child: Text(_showAllComments ? 'Show Less' : 'Show More'),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration:
                      const InputDecoration(hintText: 'Add a comment...'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  widget.addComment(_commentController.text);
                  _commentController.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _privacyController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final PostService _postService = PostService();
  bool _isLoading = false;
  String? _errorMessage;

  void _createPost() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final userId = context.read<AuthenticationCubit>().state
            is AuthenticatedAsClient
        ? (context.read<AuthenticationCubit>().state as AuthenticatedAsClient)
            .client
            .id
        : null;

    if (userId == null) {
      setState(() {
        _errorMessage = 'User is not authenticated';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final content = _contentController.text;
    final tags = _tagsController.text;
    final privacy = _privacyController.text;
    final image = _imageController.text;

    try {
      final response = await _postService.createPost(
        content: content,
        tags: tags,
        privacy: privacy,
        image: image,
        userId: userId,
      );
      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = 'Failed to create post';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Content cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  hintText: 'Enter tags (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _privacyController,
                decoration: const InputDecoration(
                  hintText: 'Privacy setting',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  hintText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _createPost,
                  child: const Text('Post'),
                ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
