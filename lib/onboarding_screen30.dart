
import 'package:flutter/material.dart';

class OnboardingScreen30 extends StatelessWidget {
  const OnboardingScreen30({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/infinity-song.jpg', 
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Content Container
          Container(
            color: Colors.black.withOpacity(0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo or Title
                // Image.asset(
                //   'assets/parcel3.jpg',
                //   width: 150,
                //   height: 150,
                // ),

                const SizedBox(height: 20),

                // Onboarding Title
                const Text(
                  'Welcome to MyApp!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Onboarding Subtitle
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Discover the amazing features of MyApp and enhance your experience.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // PillLoader Animation
                const PillLoader(),

                const SizedBox(height: 40),

                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    // Add navigation to your main app here
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PillLoader extends StatefulWidget {
  const PillLoader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PillLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset((_controller.value - 0.5) * 200, 0),
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(12.5),
              ),
            ),
          );
        },
      ),
    );
  }
}