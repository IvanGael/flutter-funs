import 'dart:math';
import 'package:flutter/material.dart';


class SpinCarouselTestScreen extends StatelessWidget {
  const SpinCarouselTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinCarousel(
            itemCount: 5, // Number of items in carousel
            itemSize: 200.0, // Size of each item
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 200.0,
                height: 200.0,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(
                  child: Text(
                    'Item $index',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}

class SpinCarousel extends StatefulWidget {
  final int itemCount;
  final double itemSize;
  final IndexedWidgetBuilder itemBuilder;

  const SpinCarousel({super.key, required this.itemCount, required this.itemSize, required this.itemBuilder});

  @override
  // ignore: library_private_types_in_public_api
  _SpinCarouselState createState() => _SpinCarouselState();
}

class _SpinCarouselState extends State<SpinCarousel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), 
    )..repeat();

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _animation.value,
          child: SizedBox(
            width: widget.itemSize,
            height: widget.itemSize,
            child: Stack(
              children: List.generate(widget.itemCount, (index) {
                final angle = (2 * pi / widget.itemCount) * index;
                final centerX = widget.itemSize / 2;
                final centerY = widget.itemSize / 2;
                final radius = widget.itemSize / 2;

                final itemX = centerX + (radius * cos(angle));
                final itemY = centerY + (radius * sin(angle));

                return Positioned(
                  left: itemX - (widget.itemSize / 2),
                  top: itemY - (widget.itemSize / 2),
                  child: widget.itemBuilder(context, index),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
