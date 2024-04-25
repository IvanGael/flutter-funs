import 'package:flutter/material.dart';

class NeonTextAnimationScreen extends StatefulWidget {
  const NeonTextAnimationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NeonTextAnimationState createState() => _NeonTextAnimationState();
}

class _NeonTextAnimationState extends State<NeonTextAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Base Text
            Text(
              "FLUTTER",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            // Neon Glow Text
            Neon(
              text: "FLUTTER",
              color: Colors.pink,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              repeat: true,
              repeatPause: Duration(milliseconds: 100),
              startDelay: Duration(milliseconds: 500),
            ),
          ],
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

class Neon extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Duration duration;
  final Curve curve;
  final bool repeat;
  final Duration repeatPause;
  final Duration startDelay;

  const Neon({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.duration,
    required this.curve,
    required this.repeat,
    required this.repeatPause,
    required this.startDelay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeonText(
      text: text,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      duration: duration,
      curve: curve,
      repeat: repeat,
      repeatPause: repeatPause,
      startDelay: startDelay,
    );
  }
}

class NeonText extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Duration duration;
  final Curve curve;
  final bool repeat;
  final Duration repeatPause;
  final Duration startDelay;

  const NeonText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.duration,
    required this.curve,
    required this.repeat,
    required this.repeatPause,
    required this.startDelay,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NeonTextState createState() => _NeonTextState();
}

class _NeonTextState extends State<NeonText> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.repeat) {
      _controller.repeat(reverse: true, period: widget.repeatPause);
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return NeonShaderMask(
          text: widget.text,
          color: widget.color,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          gradientBegin: _controller.value - 0.2,
          gradientEnd: _controller.value + 0.2,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class NeonShaderMask extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double gradientBegin;
  final double gradientEnd;

  const NeonShaderMask({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.gradientBegin,
    required this.gradientEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0),
            color,
            color.withOpacity(0),
          ],
          stops: [
            gradientBegin,
            0.5,
            gradientEnd,
          ],
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}
