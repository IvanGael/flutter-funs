import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class CustomAnalogClock extends StatefulWidget {
  const CustomAnalogClock({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomAnalogClockState createState() => _CustomAnalogClockState();
}

class _CustomAnalogClockState extends State<CustomAnalogClock> {
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update current time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: ClockPainter(dateTime: _currentTime),
        ),
      ),
    );
  }
}


class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter({required this.dateTime});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY);

    // Draw outer circle
    final Paint circlePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(centerX, centerY), radius, circlePaint);

    // Draw hour markings and numbers
    const double hourMarkLength = 10;
    const double hourMarkWidth = 2;
    const double hourNumberDistance = 20;
    final Paint hourMarkPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = hourMarkWidth;
    const TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontStyle: FontStyle.italic
    );
    for (int i = 1; i <= 12; i++) {
      final double angle = (i * 30) * pi / 180;
      final double x1 = centerX + (radius - hourMarkLength) * cos(angle);
      final double y1 = centerY + (radius - hourMarkLength) * sin(angle);
      final double x2 = centerX + radius * cos(angle);
      final double y2 = centerY + radius * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourMarkPaint);
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '$i',
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final double textX = centerX + (radius - hourNumberDistance) * cos(angle) - textPainter.width / 2;
      final double textY = centerY + (radius - hourNumberDistance) * sin(angle) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(textX, textY));
    }

    // Draw minute markings
    const double minuteMarkLength = 5;
    const double minuteMarkWidth = 1;
    final Paint minuteMarkPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = minuteMarkWidth;
    for (int i = 0; i < 60; i++) {
      if (i % 5 != 0) {
        final double angle = (i * 6) * pi / 180;
        final double x1 = centerX + (radius - minuteMarkLength) * cos(angle);
        final double y1 = centerY + (radius - minuteMarkLength) * sin(angle);
        final double x2 = centerX + radius * cos(angle);
        final double y2 = centerY + radius * sin(angle);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), minuteMarkPaint);
      }
    }

    // Draw hour hand
    final double hourX =
        centerX + radius * 0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    final double hourY =
        centerY + radius * 0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    final Paint hourPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(centerX, centerY), Offset(hourX, hourY), hourPaint);

    // Draw minute hand
    final double minuteX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    final double minuteY = centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    final Paint minutePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(centerX, centerY), Offset(minuteX, minuteY), minutePaint);

    // Draw second hand
    final double secondX = centerX + radius * 0.7 * cos(dateTime.second * 6 * pi / 180);
    final double secondY = centerY + radius * 0.7 * sin(dateTime.second * 6 * pi / 180);
    final Paint secondPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(centerX, centerY), Offset(secondX, secondY), secondPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
