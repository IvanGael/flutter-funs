
import 'package:flutter/material.dart';

class AnimatedBottomSheetScreen extends StatelessWidget {
  const AnimatedBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Bottom Sheets'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const AnimatedBottomSheetContent();
              },
            );
          },
          child: const Text('Show Animated Bottom Sheet'),
        ),
      ),
    );
  }
}

class AnimatedBottomSheetContent extends StatelessWidget {
  const AnimatedBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ModalRoute.of(context)!.animation!,
      builder: (context, child) {
        double slideValue = ModalRoute.of(context)!.animation!.value;

        return Transform.translate(
          offset: Offset(0.0, (1 - slideValue) * 500),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Animated Bottom Sheet',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text('Your content goes here...'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}