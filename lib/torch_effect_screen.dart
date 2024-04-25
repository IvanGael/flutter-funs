import 'dart:ui';

import 'package:flutter/material.dart';

class TorchEffectWidgetTestScreen extends StatelessWidget {
  const TorchEffectWidgetTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TorchEffectWidget(),
    );
  }
}

class TorchEffectWidget extends StatefulWidget {
  const TorchEffectWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TorchEffectWidgetState createState() => _TorchEffectWidgetState();
}


class _TorchEffectWidgetState extends State<TorchEffectWidget> {
  Offset magnifyingGlassPosition = const Offset(50, 50);
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/cinema2.jpg',
          width: 300,
          height: 200,
          fit: BoxFit.cover,
          color: isDragging ? Colors.white : Colors.transparent,
          colorBlendMode: BlendMode.color,
        ),
        // Torch effect
        Positioned(
          top: magnifyingGlassPosition.dy - 50,
          left: magnifyingGlassPosition.dx - 50,
          child: GestureDetector(
            onPanUpdate: (details) {
              // Update the position of the magnifying glass based on user's touch
              setState(() {
                if (!isDragging) {
                  isDragging = true;
                }
                magnifyingGlassPosition += details.delta;
              });
            },
            onPanEnd: (details) {
              // Reset the dragging status when the user stops dragging
              setState(() {
                isDragging = false;
              });
            },
            onTap: () {
              // Toggle the dragging status when the user taps on the magnifying glass
              setState(() {
                isDragging = !isDragging;
              });
            },
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.transparent,
                    isDragging ? BlendMode.saturation : BlendMode.srcIn,
                  ),
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.transparent,
                    // child: const Icon(
                    //   Icons.search,
                    //   size: 40,
                    //   color: Colors.blueGrey,
                    // ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}




// class _TorchEffectWidgetState extends State<TorchEffectWidget> {
//   Offset magnifyingGlassPosition = const Offset(50, 50);
//   bool isDragging = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Image.asset(
//           'assets/cinema2.jpg',
//           width: 300,
//           height: 200,
//           fit: BoxFit.cover,
//         ),
//         // Torch effect
//         Positioned(
//           top: magnifyingGlassPosition.dy - 50,
//           left: magnifyingGlassPosition.dx - 50,
//           child: GestureDetector(
//             onPanUpdate: (details) {
//               // Update the position of the magnifying glass based on user's touch
//               setState(() {
//                 if (!isDragging) {
//                   isDragging = true;
//                 }
//                 magnifyingGlassPosition += details.delta;
//               });
//             },
//             onPanEnd: (details) {
//               // Reset the dragging status when the user stops dragging
//               setState(() {
//                 isDragging = false;
//               });
//             },
//             onTap: () {
//               // Toggle the dragging status when the user taps on the magnifying glass
//               setState(() {
//                 isDragging = !isDragging;
//               });
//             },
//             child: ClipOval(
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(
//                   sigmaX: 10.0,
//                   sigmaY: 10.0,
//                 ),
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.transparent,
//                   child: const Icon(
//                     Icons.search,
//                     size: 40,
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }