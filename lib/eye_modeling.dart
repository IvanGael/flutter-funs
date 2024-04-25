import 'package:flutter/material.dart';

class EyeAnimationTestScreen extends StatefulWidget {
  const EyeAnimationTestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EyeAppState createState() => _EyeAppState();
}


class _EyeAppState extends State<EyeAnimationTestScreen> {
  bool isEyeClosed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isEyeClosed = !isEyeClosed;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              isEyeClosed = true;
            });
          },
          onPanEnd: (details) {
            setState(() {
              isEyeClosed = false;
            });
          },
          child: EyeWidget(isClosed: isEyeClosed),
        ),
      ),
    );
  }
}

class EyeWidget extends StatelessWidget {
  final bool isClosed;

  const EyeWidget({Key? key, required this.isClosed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Colors.red,
            Colors.black,
          ],
          stops: [0.4, 1.0],
        ),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isClosed ? 50 : 80,
          height: isClosed ? 50 : 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}



// class EyeWidget extends StatelessWidget {
//   final bool isClosed;

//   const EyeWidget({Key? key, required this.isClosed}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: RadialGradient(
//           colors: [
//             Colors.purple,
//             Colors.black,
//           ],
//           stops: [0.4, 1.0],
//         ),
//         border: Border.all(color: Colors.black, width: 2.0),
//       ),
//       child: Center(
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           width: isClosed ? 50 : 80,
//           height: isClosed ? 50 : 80,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }