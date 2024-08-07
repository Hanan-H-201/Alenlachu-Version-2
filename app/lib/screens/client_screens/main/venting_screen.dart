import 'package:flutter/material.dart';

class VentingScreen extends StatelessWidget {
  const VentingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venting Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with the actual number of posts
                itemBuilder: (context, index) {
                  return PostCard(
                    username: 'User $index',
                    content: 'This is the content of post $index',
                    imageUrl:
                        'https://via.placeholder.com/150', // Replace with actual image URL
                    tags: ['tag1', 'tag2'],
                    isLiked: false,
                    likes: 5,
                    postId: '$index',
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create post screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String username;
  final String content;
  final String imageUrl;
  final List<String> tags;
  final bool isLiked;
  final int likes;
  final String postId;

  const PostCard({
    super.key,
    required this.username,
    required this.content,
    required this.imageUrl,
    required this.tags,
    required this.isLiked,
    required this.likes,
    required this.postId,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  int _likes = 0;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _likes = widget.likes;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likes++ : _likes--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),
                const SizedBox(width: 10),
                Text(widget.username,
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.content),
            const SizedBox(height: 10),
            if (widget.imageUrl.isNotEmpty) Image.network(widget.imageUrl),
            const SizedBox(height: 10),
            Text(widget.tags.join(', '),
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: _toggleLike,
                ),
                Text('$_likes likes'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {
                    // Handle comment navigation
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            CommentSection(postId: widget.postId),
          ],
        ),
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final String postId;

  const CommentSection({super.key, required this.postId});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  List<String> comments = [
    'This is a comment 0',
    'This is a comment 1',
    'This is a comment 2'
  ];
  bool _showAllComments = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add a comment',
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      comments.add(value);
                    });
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // Handle add comment button
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...(_showAllComments ? comments : comments.take(1)).map((comment) {
          int index = comments.indexOf(comment);
          return ListTile(
            title: Text('Commenter $index'),
            subtitle: Text(comment),
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
        if (comments.length > 1)
          TextButton(
            onPressed: () {
              setState(() {
                _showAllComments = !_showAllComments;
              });
            },
            child: Text(_showAllComments ? 'View Less' : 'View More'),
          ),
      ],
    );
  }
}
