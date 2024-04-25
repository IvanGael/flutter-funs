
import 'package:flutter/material.dart';

class NewsReaderScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(
      title: 'Flutter News App',
      description: 'Building a news reader app with Flutter.',
      imageUrl: 'https://picsum.photos/250?image=27',
    ),
    Article(
      title: 'Flutter News App',
      description: 'Building a news reader app with Flutter.',
      imageUrl: 'https://picsum.photos/250?image=28',
    ),
    Article(
      title: 'Flutter News App',
      description: 'Building a news reader app with Flutter.',
      imageUrl: 'https://picsum.photos/250?image=29',
    ),
    Article(
      title: 'Flutter News App',
      description: 'Building a news reader app with Flutter.',
      imageUrl: 'https://picsum.photos/250?image=30',
    ),
  ];

  NewsReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: articles[index]);
        },
      ),
    );
  }
}

class Article {
  final String title;
  final String description;
  final String imageUrl;

  Article({required this.title, required this.description, required this.imageUrl});
}

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            article.imageUrl,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  article.description,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}