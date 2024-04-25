
import 'package:flutter/material.dart';

class CustomNotificationBellAnimationScreen extends StatefulWidget {
  const CustomNotificationBellAnimationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CustomNotificationBellAnimationScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Bell Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _toggleAnimation();
          },
          child: CustomNotificationBell(
            animation: _scaleAnimation,
          ),
        ),
      ),
    );
  }
}

class CustomNotificationBell extends StatelessWidget {
  final Animation<double> animation;

  const CustomNotificationBell({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: 16,
            right: 44,
            child: Transform.scale(
              scale: animation.value,
              child: CustomPaint(
                painter: BellPainter(),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BellPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // canvas.drawLine(const Offset(0, 0), const Offset(20, 0), paint);
    canvas.drawCircle(const Offset(20, 0), 5, paint);
    // canvas.drawLine(const Offset(20, 0), const Offset(40, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}