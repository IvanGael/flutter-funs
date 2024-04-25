import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/sea_wave_animation_screen.dart';
import 'package:flutter_explosive_like/typewriter_text_animation.dart';

class SigninScreen2 extends StatefulWidget {
  const SigninScreen2({super.key});

  @override
  State<SigninScreen2> createState() => _SigninScreen2State();
}

class _SigninScreen2State extends State<SigninScreen2> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidBackground(animation: _animation),
          // SeaWaveAnimation(),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Welcome',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 24.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  TypewriterText(
            text: 'Welcome!',
            textStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            duration: Duration(seconds: 5),
          ),
                  SizedBox(height: 20.0),
                  SignInForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
          ),
          obscureText: true,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implement sign-in logic
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}


class LiquidBackground extends StatelessWidget {
  final Animation<double> animation;

  const LiquidBackground({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: LiquidPainter(animation.value),
          size: MediaQuery.of(context).size, // Ensure the custom paint covers the entire screen
        );
      },
    );
  }
}

class LiquidPainter extends CustomPainter {
  final double animationValue;

  LiquidPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        Colors.pink[600]!.withOpacity(0.3),
        Colors.pink[600]!.withOpacity(0.3),
        Colors.pink[600]!.withOpacity(0.3),
      ],
      stops: const [0.3, 0.5, 0.7],
    );

    final rect = Rect.fromPoints(Offset(0, size.height * 0.6), Offset(size.width, size.height));

    final paint = Paint()..shader = gradient.createShader(rect);

    final path = Path();

    path.moveTo(0, size.height * 0.6);

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.65 + 50 * animationValue,
      size.width * 0.3,
      size.height * 0.6,
    );

    path.cubicTo(
      size.width * 0.5,
      size.height * 0.55 - 50 * animationValue,
      size.width * 0.7,
      size.height * 0.65 + 50 * animationValue,
      size.width * 0.85,
      size.height * 0.6,
    );

    path.quadraticBezierTo(
      size.width,
      size.height * 0.55 - 50 * animationValue,
      size.width,
      size.height * 0.6,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
