
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;

  const TypewriterText({super.key, 
    required this.text,
    required this.textStyle,
    required this.duration,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _letterAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _letterAnimations = List.generate(
      widget.text.length,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / widget.text.length,
            (index + 1) / widget.text.length,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.text.length,
        (index) => FadeTransition(
          opacity: _letterAnimations[index],
          child: Text(
            widget.text[index],
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TypewriterTextAnimationScreen extends StatelessWidget {
  const TypewriterTextAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
        body: Center(
          child: TypewriterText(
            text: 'Hello, World!',
            textStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink
            ),
            duration: Duration(seconds: 5),
          ),
        ),
      );
  }
}