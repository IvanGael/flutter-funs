import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

// BlogPostEvent and BlogPostBloc are for state management
enum BlogPostEvent { editContent, addComment }

class BlogPostBloc extends Bloc<BlogPostEvent, bool> {
  BlogPostBloc() : super(false);

  Stream<bool> mapEventToState(BlogPostEvent event) async* {
    if (event == BlogPostEvent.editContent) {
      // Implement your edit content logic here
      yield true; // Simulating a successful edit
    } else if (event == BlogPostEvent.addComment) {
      // Implement your add comment logic here
      yield true; // Simulating a successful comment addition
    }
  }
}


class BlogPostScreen extends StatelessWidget {
  const BlogPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Post Header
            const Text(
              'Title of the Blog Post',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Row(
              children: [
                CircleAvatar(
                  // Author Avatar
                  radius: 16.0,
                  backgroundImage: NetworkImage('https://example.com/author_avatar.jpg'),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Author Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Published on: Date',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Blog Post Content
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Additional Features for Author
            // For example, an Edit button
            // You can conditionally show these based on the user role
            ElevatedButton(
              onPressed: () {
                // Handle edit functionality
              },
              child: const Text('Edit Content'),
            ),
            const SizedBox(height: 16.0),

            // Comments Section
            const Text(
              'Comments',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Display comments here

            // Add Comment Button
            ElevatedButton(
              onPressed: () {
                // Handle adding a new comment
              },
              child: const Text('Add Comment'),
            ),
          ],
        ),
      ),
    );
  }
}