
// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_diamond_button.dart';

class RadarVibrationAnimation extends StatefulWidget {
  const RadarVibrationAnimation({super.key});

  @override
  _RadarVibrationAnimationState createState() => _RadarVibrationAnimationState();
}

class _RadarVibrationAnimationState extends State<RadarVibrationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  late int _elapsedSeconds = 0;
  late String _formattedTime = "00:00:00";
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
    });
    _controller.repeat(reverse: false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        _formattedTime = _formatTime(_elapsedSeconds);
      });
    });
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
    });
    _controller.stop();
    _timer.cancel();
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingSeconds = seconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int secs = remainingSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            // decoration:  BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [Colors.deepPurpleAccent, Colors.blueGrey],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomRight
            //   )
            // ),
            color: Colors.black,
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurpleAccent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent,
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(300, 300),
                    painter: RadarPainter(_animation),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.47,
            left: MediaQuery.of(context).size.width * 0.26,
            child: Text(
              _formattedTime,
              style: const TextStyle(
                color: Colors.white24,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.4,
            child: DiamondButton(
              onPressed: () {
                if (_isRunning) {
                  _stopStopwatch();
                } else {
                  _startStopwatch();
                }
              },
              width: 90,
              height: 90,
              backgroundColor: _isRunning ? Colors.redAccent : Colors.teal,
              child: Text(
                _isRunning ? 'Stop' : 'Start',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            // child: ElevatedButton(
            //   style: ButtonStyle(
            //     backgroundColor: _isRunning ? MaterialStateProperty.all(Colors.redAccent) : MaterialStateProperty.all(Colors.greenAccent)
            //   ),
            //   onPressed: () {
            //     if (_isRunning) {
            //       _stopStopwatch();
            //     } else {
            //       _startStopwatch();
            //     }
            //   },
            //   child: Text(
            //     _isRunning ? 'Stop' : 'Start',
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 18
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}



// class RadarVibrationAnimation extends StatefulWidget {
//   const RadarVibrationAnimation({super.key});

//   @override
//   _RadarVibrationAnimationState createState() => _RadarVibrationAnimationState();
// }

// class _RadarVibrationAnimationState extends State<RadarVibrationAnimation>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late Timer _timer;
//   late String _formattedTime;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: false);
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);

//     _updateTime();
//     // Start timer to update time every minute
//     _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
//       _updateTime();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     // Cancel the timer to avoid memory leaks
//     _timer.cancel();
//     super.dispose();
//   }

//   void _updateTime() {
//     // Get the current time
//     DateTime now = DateTime.now();
//     // Format the time to display only hour and minute in HH:mm format
//     setState(() {
//       _formattedTime = DateFormat.Hm().format(now);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       // backgroundColor: Colors.white24,
//       body: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             // decoration: const BoxDecoration(
//             //   gradient: LinearGradient(
//             //     colors: [Colors.deepPurpleAccent, Colors.blueGrey],
//             //     begin: Alignment.topCenter,
//             //     end: Alignment.bottomRight
//             //   )
//             // ),
//             color: Colors.black 
//           ),
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//           colors: [
//             Colors.deepPurpleAccent,
//             Colors.black,
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         boxShadow:  [
//           BoxShadow(
//             color: Colors.cyanAccent,
//             blurRadius: 15.0,
//             spreadRadius: 1.0,
//           ),
//         ],
//               ),
//               child: CustomPaint(
//                 size: const Size(300, 300),
//                 painter: RadarPainter(_animation),
//               ),
//             ),
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.47,
//             left: MediaQuery.of(context).size.width * 0.35,
//             child: Text(
//               _formattedTime, 
//               style: const TextStyle(
//                 color: Colors.white24,
//                 fontSize: 45,
//                 fontWeight: FontWeight.bold
//               )
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class RadarPainter extends CustomPainter {
  final Animation<double> animation;
  RadarPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    const double strokeWidth = 6.0;
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(Offset(radius, radius), radius - strokeWidth / 2, paint);
    canvas.drawCircle(Offset(radius, radius), radius * animation.value, paint);
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RadarPainter oldDelegate) => false;
}