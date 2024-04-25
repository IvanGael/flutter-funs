import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/accordion_step.dart';
import 'package:flutter_explosive_like/accordion_stepper.dart';
import 'package:flutter_explosive_like/circle_stepper.dart';
import 'package:flutter_explosive_like/circle_stepper_item.dart';
import 'package:flutter_explosive_like/gradient_stepper.dart';
import 'package:flutter_explosive_like/liquid_step.dart';
import 'package:flutter_explosive_like/liquid_stepper.dart';
import 'package:flutter_explosive_like/slidding_stepper.dart';

class LiquidStepperDemo extends StatefulWidget {
  const LiquidStepperDemo({super.key});

  @override
  State<LiquidStepperDemo> createState() => _LiquidStepperDemoState();
}

class _LiquidStepperDemoState extends State<LiquidStepperDemo> {

  final List<AccordionStep> steps = [
    AccordionStep(title: 'Step 1', content: const Text('Content for Step 1')),
    AccordionStep(title: 'Step 2', content: const Text('Content for Step 2')),
    AccordionStep(title: 'Step 3', content: const Text('Content for Step 3')),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SliddingStepper(),
    );
  }
}
