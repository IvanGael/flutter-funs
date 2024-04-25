
import 'package:flutter/material.dart';

class OnboardingScreen24 extends StatelessWidget {
  const OnboardingScreen24({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: AbstractArtPainter(),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Your App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Discover the beauty of abstract art in our app',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AbstractArtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.blue; // Set your preferred color

    // Implement your abstract art pattern using draw methods
    // This is a simple example; customize based on your preferences
    canvas.drawCircle(const Offset(100, 100), 50, paint);
    canvas.drawCircle(const Offset(200, 200), 70, paint);
    canvas.drawCircle(const Offset(400, 400), 100, paint);
    // Add more draw methods to create your abstract pattern
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}