
import 'package:flutter/material.dart';

class PostLoginHomeScreen13 extends StatelessWidget {
  const PostLoginHomeScreen13({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Collapsing App Bar'),
              background: Image.network(
                'https://picsum.photos/250?image=18', // Add your background image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.star),
                    title: Text('Item $index'),
                    subtitle: Text('Description of item $index'),
                    onTap: () {
                      // Add functionality for each list item
                    },
                  ),
                );
              },
              childCount: 10, // Number of list items
            ),
          ),
        ],
      ),
    );
  }
}