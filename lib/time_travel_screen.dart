
import 'package:flutter/material.dart';

class TimeTravelScreen extends StatefulWidget {
  const TimeTravelScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeTravelScreenState createState() => _TimeTravelScreenState();
}

class _TimeTravelScreenState extends State<TimeTravelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              if(_animation.value > 0.5)
              Container(
                color: Colors.black,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/db_bg1.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              if(_animation.value <= 0.5)
              Container(
                color: Colors.black,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/db_bg3.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              Center(
                child: Transform.scale(
                  scale: 1.0 + _animation.value * 0.5,
                  child: Image.asset(
                    'assets/versus.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Positioned(
                left: 50 * _animation.value,
                top: 150 * _animation.value,
                child: Opacity(
                  opacity: 1.0 - _animation.value,
                  child: Image.asset(
                    'assets/goku_ssj_blue_kaioken.png',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              Positioned(
                right: 50 * _animation.value,
                top: 150 * _animation.value,
                child: Opacity(
                  opacity: 1.0 - _animation.value,
                  child: Image.asset(
                    'assets/golden_freezer.png',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}