
import 'package:flutter/material.dart';

class LinkedinFeedScreen extends StatelessWidget {
  const LinkedinFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LinkedIn Feed'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PostCard(
              username: 'John Doe',
              userImage: 'assets/avatar2.png',
              postText:
                  'Excited to start my new job as a Flutter developer! 🚀 #NewBeginnings',
              postImage: 'assets/make_or_join.jpg', 
              timestamp: '2h ago',
              likes: 120,
              comments: 8,
            ),
            PostCard(
              username: 'John Doe',
              userImage: 'assets/avatar2.png',
              postText:
                  'Excited to start my new job as a Flutter developer! 🚀 #NewBeginnings',
              postImage: 'assets/make_or_join.jpg', 
              timestamp: '2h ago',
              likes: 120,
              comments: 8,
            ),
            PostCard(
              username: 'John Doe',
              userImage: 'assets/avatar2.png',
              postText:
                  'Excited to start my new job as a Flutter developer! 🚀 #NewBeginnings',
              postImage: 'assets/make_or_join.jpg', 
              timestamp: '2h ago',
              likes: 120,
              comments: 8,
            ),
            PostCard(
              username: 'John Doe',
              userImage: 'assets/avatar2.png',
              postText:
                  'Excited to start my new job as a Flutter developer! 🚀 #NewBeginnings',
              postImage: 'assets/make_or_join.jpg', 
              timestamp: '2h ago',
              likes: 120,
              comments: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String userImage;
  final String postText;
  final String postImage;
  final String timestamp;
  final int likes;
  final int comments;

  const PostCard({super.key, 
    required this.username,
    required this.userImage,
    required this.postText,
    required this.postImage,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(userImage),
            ),
            title: Text(username),
            subtitle: Text(timestamp),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(postText),
          ),
          Image.asset(
            postImage,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up),
                    const SizedBox(width: 4.0),
                    Text('$likes Likes'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment),
                    const SizedBox(width: 4.0),
                    Text('$comments Comments'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}