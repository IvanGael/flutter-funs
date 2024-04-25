
import 'dart:async';
import 'package:flutter/material.dart';

class CountdownCardScreen extends StatefulWidget {
  const CountdownCardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownCardScreen> {
  late PageController _pageController;
  // ignore: unused_field
  int _currentIndex = 0;
  int _countdown = 10; 
  int maxCardNb = 1000;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Set up a timer to update the countdown every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _countdown = 10; 
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.orange
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1]
            )
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _countdown = 10; 
              });
            },
            itemCount: maxCardNb,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                elevation: 12,
                // color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_countdown}s',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.red[400]!),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


