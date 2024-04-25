
import 'package:flutter/material.dart';

class ExplosiveHeartButton extends StatefulWidget {
  const ExplosiveHeartButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExplosiveHeartButtonState createState() => _ExplosiveHeartButtonState();
}

class _ExplosiveHeartButtonState extends State<ExplosiveHeartButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHeartPressed() {
    _animationController.forward();
    Future.delayed(Duration(milliseconds: 500), (){
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onHeartPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: const Icon(
                Icons.favorite,
                size: 40.0,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}