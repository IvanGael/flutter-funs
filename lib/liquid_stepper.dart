import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/liquid_step.dart';

class LiquidStepper extends StatefulWidget {
  final List<LiquidStep> steps;

  const LiquidStepper({Key? key, required this.steps}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LiquidStepperState createState() => _LiquidStepperState();
}

class _LiquidStepperState extends State<LiquidStepper> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: LiquidProgressPainter(
              value: (currentStep + 1) / widget.steps.length),
          child: const SizedBox(
            height: 20.0,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          widget.steps[currentStep].title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 20),
        widget.steps[currentStep].content,
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentStep == 0)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentStep += 1;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            if (currentStep == 1)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentStep -= 1;
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.pink, size: 15),
                    Text('Back',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            if (currentStep == 1)
              ElevatedButton(
                onPressed: () {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep += 1;
                    });
                  } else {
                    // Handle form submission
                    // For demonstration purposes, just print the information
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 15),
                  ],
                ),
              ),
            if (currentStep == 2)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentStep -= 1;
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.pink, size: 15),
                    Text('Back',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            if (currentStep == 2)
              ElevatedButton(
                onPressed: () {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep += 1;
                    });
                  } else {
                    // Handle form submission
                    // For demonstration purposes, just print the information
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class LiquidProgressPainter extends CustomPainter {
  final double value;

  LiquidProgressPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    double waveWidth = size.width;
    double waveY = size.height * (1 - value);
    double amplitude = 20.0;

    Path path = Path();
    path.moveTo(0, waveY);

    for (double i = 0.0; i < waveWidth; i++) {
      double x = i;
      double y =
          amplitude * sin((i / waveWidth) * 2.5 * pi + (value * 0.5 * pi)) +
              waveY;
      path.lineTo(x, y);
    }

    path.lineTo(waveWidth, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
