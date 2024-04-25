import 'package:flutter/material.dart';



class NeonRotationEffectScreen extends StatefulWidget {
  const NeonRotationEffectScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NeonRotationEffectState createState() => _NeonRotationEffectState();
}

class _NeonRotationEffectState extends State<NeonRotationEffectScreen> {
  double rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.blue, // Neon color
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Transform.rotate(
              angle: rotationAngle,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Hello, Neon!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
