
import 'package:flutter/material.dart';

class PostLoginHomeScreen3 extends StatelessWidget {
  const PostLoginHomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Creative Home Screen'),
              background: Image.network(
                'https://picsum.photos/250?image=10', 
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const ListTile(
                  title: Text('Welcome to our App!'),
                  subtitle: Text('Explore and enjoy the experience.'),
                ),
                const ListTile(
                  title: Text('Feature 1'),
                  subtitle: Text('Description of feature 1.'),
                ),
                const ListTile(
                  title: Text('Feature 2'),
                  subtitle: Text('Description of feature 2.'),
                ),
                // Add more list items as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}