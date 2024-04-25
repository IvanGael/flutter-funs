
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ShimmeringTextLoaderTestScreen extends StatelessWidget {
  const ShimmeringTextLoaderTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: ShimmeringTextLoader(),
        ),
      );
  }
}

class ShimmeringTextLoader extends StatelessWidget {
  const ShimmeringTextLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1500),
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[100]!,
      child: const Text(
        'Loading...',
        style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
