import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CustomImageRevealAnimation extends StatefulWidget {
  const CustomImageRevealAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomImageRevealAnimationState createState() => _CustomImageRevealAnimationState();
}

class _CustomImageRevealAnimationState extends State<CustomImageRevealAnimation> {
  bool _showImage = false;
  final List<bool> _reveals = List.generate(4, (index) => false);
  final List<String> _images = [
    'assets/goku_ssj_blue.png',
    'assets/golden_freezer.png',
    'assets/vegeta_ssj_blue.png',
    'assets/jiren.png'
  ];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _showImage = false;
    _reveals.fillRange(0, _reveals.length, false);
    _startRevealsTimer();
  }

  void _startRevealsTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_showImage) {
        _showRandomReveals();
      } else {
        timer.cancel();
      }
    });
  }

  void _showRandomReveals() {
    int randomIndex = Random().nextInt(_reveals.length);
    setState(() {
      _reveals[randomIndex] = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _reveals[randomIndex] = false;
      });
    });
  }

  void _reveal(int index) {
    if (_reveals[index]) {
      setState(() {
        _reveals[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: _reveals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _reveal(index),
                    child: Container(
                        margin: const EdgeInsets.all(8),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: _reveals[index]
                                ? Colors.deepPurpleAccent
                                : const Color.fromARGB(255, 11, 224, 121),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Image.asset(
                            _reveals[index]
                                ? _images[index]
                                : 'assets/db_bg1.jpg',
                            fit: BoxFit.cover,
                          ),
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
