
import 'dart:ui';

import 'package:flutter/material.dart';


class SensitiveContentStyleOnImageScreen extends StatefulWidget {
  const SensitiveContentStyleOnImageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SensitiveContentStyleOnImageScreen> {
  bool isSensitiveContentVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image from Asset
            Image.asset(
              'assets/db_bg3.jpg',
              fit: BoxFit.cover,
            ),

            // Sensitive Content
            AnimatedOpacity(
              opacity: isSensitiveContentVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Text(
                      'Sensitive Content',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Toggle Button
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSensitiveContentVisible = !isSensitiveContentVisible;
                  });
                },
                child: Text(isSensitiveContentVisible ? 'Normal' : 'Sensitive'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}