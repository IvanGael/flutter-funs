
import 'package:flutter/material.dart';


class RaceTrackTestScreen extends StatelessWidget {
  const RaceTrackTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: RaceTrack(),
      );
  }
}

class RaceTrack extends StatefulWidget {
  const RaceTrack({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RaceTrackState createState() => _RaceTrackState();
}

class _RaceTrackState extends State<RaceTrack> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller1,
            builder: (context, child) {
              return Car(_controller1, carNumber: 1);
            },
          ),
          const SizedBox(height: 50),
          AnimatedBuilder(
            animation: _controller2,
            builder: (context, child) {
              return Car(_controller2, carNumber: 2);
            },
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              _startRace();
            },
            child: const Text('Start Race'),
          ),
        ],
      ),
    );
  }

  void _startRace() {
    _controller1.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

class Car extends StatelessWidget {
  final Animation<double> animation;
  final int carNumber;

  const Car(this.animation, {super.key, required this.carNumber});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(left: animation.value * 200),
          width: 50,
          height: 30,
          color: carNumber == 1 ? Colors.red : Colors.blue,
        );
      },
    );
  }
}
