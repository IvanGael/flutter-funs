
import 'package:flutter/material.dart';

class ParallaxScrollingDemo extends StatefulWidget {
  const ParallaxScrollingDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParallaxScrollingDemoState createState() => _ParallaxScrollingDemoState();
}

class _ParallaxScrollingDemoState extends State<ParallaxScrollingDemo> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Parallax Scrolling'),
              background: Image.asset(
                'assets/db_bg2.jpg', 
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ParallaxLayer(
                  imageAsset: 'assets/db_bg3.jpg', 
                  scrollController: _scrollController,
                  scrollSpeed: 0.5,
                );
              },
              childCount: 5, // Number of parallax layers
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return ListTile(
          //         title: Text('Item $index'),
          //       );
          //     },
          //     childCount: 50,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ParallaxLayer extends StatelessWidget {
  final String imageAsset;
  final ScrollController scrollController;
  final double scrollSpeed;

  const ParallaxLayer({super.key, 
    required this.imageAsset,
    required this.scrollController,
    required this.scrollSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, scrollController.offset * scrollSpeed),
      child: Image.asset(
        imageAsset,
        fit: BoxFit.cover,
        height: 200.0,
      ),
    );
  }
}