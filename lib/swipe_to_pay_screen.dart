
import 'package:flutter/material.dart';

class SwipeToPayScreen extends StatelessWidget {
  const SwipeToPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: DragUnlock(),
      ),
    );
  }
}

class DragUnlock extends StatefulWidget {
  const DragUnlock({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DragUnlockState createState() => _DragUnlockState();
}

class _DragUnlockState extends State<DragUnlock> {
  double _dragPosition = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragPosition += details.delta.dx;
        });
      },
      onHorizontalDragEnd: (details) {
        if (_dragPosition > MediaQuery.of(context).size.width / 2) {
          // Unlock the screen
          debugPrint('Screen unlocked');
        }
        setState(() {
          _dragPosition = 0;
        });
      },
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 50,
            left: _dragPosition,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                      Icons.swipe,
                      color: Colors.white,
                    ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 50,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(child: Text("Swipe to pay")),
            ),
          ),
        ],
      ),
    );
  }
}