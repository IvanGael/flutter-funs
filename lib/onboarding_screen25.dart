import 'package:flutter/material.dart';

class OnboardingScreen25 extends StatefulWidget {
  const OnboardingScreen25({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen25> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        // onPageChanged: (index) {
        //   setState(() {
        //     currentPage = index;
        //   });
        //   if (index == 2) {
        //     // Custom page transition for RainyPage
        //     Navigator.of(context).push(
        //       PageRouteBuilder(
        //         pageBuilder: (context, animation, secondaryAnimation) =>
        //             const RainyPage(),
        //         transitionsBuilder:
        //             (context, animation, secondaryAnimation, child) {
        //           const begin = Offset(1.0, 0.0);
        //           const end = Offset.zero;
        //           const curve = Curves.easeInOutCubic;

        //           var tween = Tween(begin: begin, end: end)
        //               .chain(CurveTween(curve: curve));

        //           var offsetAnimation = animation.drive(tween);

        //           return SlideTransition(
        //             position: offsetAnimation,
        //             child: child,
        //           );
        //         },
        //       ),
        //     );
        //   }
        // },
        children: const [
          WeatherPage(color: Colors.indigo, text: 'Welcome to the Sunny App'),
          WeatherPage(color: Colors.teal, text: 'Explore Cloudy Features'),
          RainyPage(),
        ],
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  final Color color;
  final String text;

  const WeatherPage({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class RainyPage extends StatelessWidget {
  const RainyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Center(
        child: CustomPaint(
          painter: RainyPainter(),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Ready for the Rainy Tips',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RainyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Implement your custom rainy painting here
    Paint paint = Paint()
      ..color = Colors.pink
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < 100; i++) {
      canvas.drawLine(
        Offset(i.toDouble(), (i % 2 == 0) ? 0 : size.height),
        Offset(i.toDouble(), (i % 2 == 0) ? size.height : 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
