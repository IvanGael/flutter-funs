import 'package:flutter/material.dart';

class CarouselItemData {
  final String title;
  final String imageUrl;

  CarouselItemData({required this.title, required this.imageUrl});
}

class ContinueWatchingItemData {
  final String title;
  final String imageUrl;

  ContinueWatchingItemData({required this.title, required this.imageUrl});
}

class RecommendationItemData {
  final String title;
  final String imageUrl;

  RecommendationItemData({required this.title, required this.imageUrl});
}

class TvAppScreen extends StatefulWidget {
  const TvAppScreen({super.key});

  @override
  State<TvAppScreen> createState() => _TvAppScreenState();
}

class _TvAppScreenState extends State<TvAppScreen> {
  final List<CarouselItemData> carouselData = [
    CarouselItemData(
        title: 'Show 1', imageUrl: 'https://picsum.photos/250?image=15'),
    CarouselItemData(
        title: 'Show 2', imageUrl: 'https://picsum.photos/250?image=16'),
    CarouselItemData(
        title: 'Show 3', imageUrl: 'https://picsum.photos/250?image=17'),
  ];

  final List<ContinueWatchingItemData> continueWatchingData = [
    ContinueWatchingItemData(
        title: 'Episode 4', imageUrl: 'https://picsum.photos/250?image=18'),
    ContinueWatchingItemData(
        title: 'Episode 7', imageUrl: 'https://picsum.photos/250?image=19'),
    ContinueWatchingItemData(
        title: 'Episode 10', imageUrl: 'https://picsum.photos/250?image=20'),
  ];

  final List<RecommendationItemData> mostViewedData = [
    RecommendationItemData(
        title: 'Movie A', imageUrl: 'https://picsum.photos/250?image=21'),
    RecommendationItemData(
        title: 'Show B', imageUrl: 'https://picsum.photos/250?image=22'),
    RecommendationItemData(
        title: 'Documentary C', imageUrl: 'https://picsum.photos/250?image=23'),
  ];

  final List<RecommendationItemData> recentlyAddedData = [
    RecommendationItemData(
        title: 'Show X', imageUrl: 'https://picsum.photos/250?image=24'),
    RecommendationItemData(
        title: 'Movie Y', imageUrl: 'https://picsum.photos/250?image=25'),
    RecommendationItemData(
        title: 'Documentary Z', imageUrl: 'https://picsum.photos/250?image=26'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildControls(),
              const SizedBox(height: 16.0),
              _buildCarousel(),
              const SizedBox(height: 16.0),
              _buildContinueWatching(),
              const SizedBox(height: 16.0),
              _buildRecommendations('Most Viewed', mostViewedData),
              const SizedBox(height: 16.0),
              _buildRecommendations('Recently Added', recentlyAddedData),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            // Implement volume control logic
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            // Implement favorites logic
          },
        ),
        IconButton(
          icon: const Icon(Icons.closed_caption),
          onPressed: () {
            // Implement closed captions logic
          },
        ),
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            // Implement language selection logic
          },
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carouselData.length,
        itemBuilder: (context, index) {
          return _buildCarouselItem(carouselData[index]);
        },
      ),
    );
  }

  Widget _buildCarouselItem(CarouselItemData data) {
    return Container(
      width: 150.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(data.imageUrl, height: 120.0, fit: BoxFit.cover),
          const SizedBox(height: 8.0),
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueWatching() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Continue Watching',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 120.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: continueWatchingData.length,
            itemBuilder: (context, index) {
              return _buildContinueWatchingItem(continueWatchingData[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContinueWatchingItem(ContinueWatchingItemData data) {
    return Container(
      width: 80.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(data.imageUrl, height: 80.0, fit: BoxFit.cover),
          const SizedBox(height: 8.0),
          Text(data.title),
        ],
      ),
    );
  }

  Widget _buildRecommendations(
      String title, List<RecommendationItemData> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 120.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _buildRecommendationItem(data[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(RecommendationItemData data) {
    return Container(
      width: 100.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(data.imageUrl, height: 80.0, fit: BoxFit.cover),
          const SizedBox(height: 8.0),
          Expanded(
            child: Text(
              data.title,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
