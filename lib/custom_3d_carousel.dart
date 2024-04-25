// ignore: file_names
import 'package:flutter/material.dart';

class Custom3DCarousel extends StatefulWidget {
  const Custom3DCarousel({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Custom3DCarouselState createState() => _Custom3DCarouselState();
}

class _Custom3DCarouselState extends State<Custom3DCarousel> {
  double currentPage = 0.0;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  final List<String> images = [
    "assets/cinema1.jpg",
    "assets/cinema2.jpg",
    "assets/cinema3.jpg",
    "assets/infinity-song.jpg"
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: images.length, 
        itemBuilder: (context, index) {
          double scale = (1 - (index - currentPage).abs() * 0.2).clamp(0.8, 1.0);
          double angle = ((index - currentPage).abs() * 0.2) + 0.5;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(angle)
              ..scale(scale),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 0.6,
                    spreadRadius: 1,
                    offset: Offset(3, 1)
                  )
                ]
              ),
            ),
          );
        },
      ),
    );
  }
}