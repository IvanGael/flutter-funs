
import 'dart:math';

import 'package:flutter/material.dart';

class ParkingLotScreen extends StatelessWidget {
  const ParkingLotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Lot'),
      ),
      body: const Center(
        child: ParkingLot(),
      ),
    );
  }
}

class ParkingLot extends StatefulWidget {
  const ParkingLot({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParkingLotState createState() => _ParkingLotState();
}


class _ParkingLotState extends State<ParkingLot> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<CarAnimation> _carAnimations = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _initializeCars();
    _startAnimation();
  }

  void _initializeCars() async{
    _carAnimations.add(CarAnimation(0, 'assets/car1.png'));

    await Future.delayed(const Duration(seconds: 10), (){
      _carAnimations.add(CarAnimation(1, 'assets/car2.png'));
      setState(() {
        
      });
    });

    await Future.delayed(const Duration(seconds: 10), (){
      _carAnimations.add(CarAnimation(2, 'assets/car1.png'));
      setState(() {
        
      });
    });

    await Future.delayed(const Duration(seconds: 10), (){
      _carAnimations.add(CarAnimation(3, 'assets/car2.png'));
      setState(() {
        
      });
    });
    

    await Future.delayed(const Duration(seconds: 10), (){
      _carAnimations.add(CarAnimation(4, 'assets/car1.png'));
      setState(() {
        
      });
    });


    await Future.delayed(const Duration(seconds: 10), (){
      _carAnimations.add(CarAnimation(5, 'assets/car2.png'));
      setState(() {
        
      });
    });
  }

  void _startAnimation() {
    for (var carAnimation in _carAnimations) {
      carAnimation.startAnimation(_animationController);
    }

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 400.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.black),
      ),
      child: Stack(
        children: _carAnimations.map((carAnimation) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                left: carAnimation.position.dx,
                top: carAnimation.position.dy,
                child: Image.asset(
                  carAnimation.imageAsset,
                  width: 50.0,
                  height: 50.0,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CarAnimation {
  late AnimationController controller;
  late Offset position;
  final String imageAsset;

  CarAnimation(double startingAngle, this.imageAsset) {
    position = _calculatePosition(startingAngle);
  }

  void startAnimation(AnimationController animationController) {
    controller = animationController;

    controller.addListener(() {
      final angle = controller.value * 2 * pi;
      position = _calculatePosition(angle);
      // setState(() {});
    });

    controller.repeat();
  }

  Offset _calculatePosition(double angle) {
    // Adjust the radius and center as needed
    const double radius = 100.0;
    const Offset center = Offset(150.0, 200.0);

    final double x = center.dx + radius * cos(angle);
    final double y = center.dy + radius * sin(angle);

    return Offset(x, y);
  }
}