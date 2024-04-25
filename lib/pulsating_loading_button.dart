
import 'package:flutter/material.dart';

class PulsatingLoadingButtonTestScreen extends StatelessWidget {
  const PulsatingLoadingButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
          body: Center(
            child: PulsatingLoadingButton(),
          ),
        );
  }
}

class PulsatingLoadingButton extends StatefulWidget {
  const PulsatingLoadingButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PulsatingLoadingButtonState createState() => _PulsatingLoadingButtonState();
}

class _PulsatingLoadingButtonState extends State<PulsatingLoadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reset the animation to its initial state
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (_isLoading) {
          // If loading is still ongoing, restart the animation
          _animationController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    if (_isLoading) {
      // Handle loading completion here
      // For demonstration purposes, let's just simulate a delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        _animationController.reverse();
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLoading ? null : _onButtonPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.greenAccent,
              ),
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Click Me',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
