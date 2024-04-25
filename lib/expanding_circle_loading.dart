
import 'package:flutter/material.dart';


class ExpandingCirclesLoaderTestScreen extends StatelessWidget {
  const ExpandingCirclesLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: ExpandingCirclesLoader(),
        ),
      );
  }
}

class ExpandingCirclesLoader extends StatefulWidget {
  const ExpandingCirclesLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandingCirclesLoaderState createState() => _ExpandingCirclesLoaderState();
}

class _ExpandingCirclesLoaderState extends State<ExpandingCirclesLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
          child: Container(
            width: 100 * _animation.value,
            height: 100 * _animation.value,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
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
