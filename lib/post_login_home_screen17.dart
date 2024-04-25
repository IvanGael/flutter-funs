
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PostLoginHomeScreen17 extends StatelessWidget {
  const PostLoginHomeScreen17({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Home Screen'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16/9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                // Handle page change
              },
            ),
            items: [
              Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('Carousel Item 1', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(
                  child: Text('Carousel Item 2', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Center(
                  child: Text('Carousel Item 3', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          // Add more widgets or content as needed
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}