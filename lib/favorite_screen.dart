import 'package:flutter/material.dart';

class FavoriteItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  FavoriteItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<FavoriteItem> favoriteItems = [
    FavoriteItem(
      title: 'The Great Gatsby',
      subtitle: 'Classic novel by F. Scott Fitzgerald',
      imageUrl: 'https://placekitten.com/200/30', 
    ),
    FavoriteItem(
      title: 'The Legend of Zelda: Breath of the Wild',
      subtitle: 'Action-adventure video game',
      imageUrl: 'https://placekitten.com/200/31', 
    ),
    FavoriteItem(
      title: 'Serial',
      subtitle: 'True crime podcast',
      imageUrl: 'https://placekitten.com/201/33', 
    ),
    FavoriteItem(
      title: 'Netflix',
      subtitle: 'Streaming service for movies and TV shows',
      imageUrl: 'https://placekitten.com/201/34', 
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return FavoriteCard(favoriteItem: favoriteItems[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final FavoriteItem favoriteItem;

  const FavoriteCard({
    Key? key,
    required this.favoriteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              favoriteItem.imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoriteItem.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  favoriteItem.subtitle,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}