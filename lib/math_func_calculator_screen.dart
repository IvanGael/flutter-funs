import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MathFunctionCalculatorScreen extends StatefulWidget {
  const MathFunctionCalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MathFunctionCalculatorState createState() => _MathFunctionCalculatorState();
}

class _MathFunctionCalculatorState extends State<MathFunctionCalculatorScreen> {
  final TextEditingController _functionController = TextEditingController();
  double _discriminant = 0;
  double _solution1 = 0;
  double _solution2 = 0;

  String _derivativeResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Function Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _functionController,
              decoration: const InputDecoration(
                labelText: 'Enter mathematical function',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                resolveFunc();
              },
              child: const Text('Resolve function'),
            ),
            const SizedBox(height: 10.0),
            Text('Discriminant: $_discriminant'),
            Text('Solution 1: ${_solution1.toStringAsFixed(2)}'),
            Text('Solution 2: ${_solution2.toStringAsFixed(2)}'),
            // const SizedBox(height: 10.0),
            // ElevatedButton(
            //   onPressed: () {
            //     calculateDerivative();
            //   },
            //   child: const Text('Calculate derivative'),
            // ),
            // const SizedBox(height: 10.0),
            // Text(_derivativeResult),
          ],
        ),
      ),
    );
  }

  void resolveFunc() {
    String function = _functionController.text;
    Parser p = Parser();
    Expression exp = p.parse(function);
    ContextModel cm = ContextModel();

    // Assuming the expression has a variable 'x'
    cm.bindVariable(Variable('x'), Number(1.0)); // Bind 'x' to a default value (1.0)

    double a = exp.simplify().evaluate(EvaluationType.REAL, cm);

    print("a : $a");

    // Extract the coefficient of 'x' (b)
    double b = exp.simplify().derive('x').evaluate(EvaluationType.REAL, cm);

    print("b : $b");

    // Extract the constant term (c)
    double c = exp.simplify().evaluate(EvaluationType.REAL, cm) - a;

    print("c : $c");

    double discriminant = pow(b, 2) - 4 * a * c;

    print("discriminant : $discriminant");

    setState(() {
      _discriminant = discriminant;
    });

    print("discriminant : $_discriminant");

    double solution1 = (-b + sqrt(discriminant)) / (2 * a);
    double solution2 = (-b - sqrt(discriminant)) / (2 * a);

    setState(() {
      _solution1 = solution1;
      _solution2 = solution2;
    });
  }

  void calculateDerivative() {
    String function = _functionController.text;
    Parser p = Parser();
    Expression exp = p.parse(function);
    ContextModel cm = ContextModel();

    cm.bindVariable(Variable('x'), Number(1.0));

    // Calculate the derivative using the parsed expression
    Expression derivative = exp.derive('x');
    double derivativeValue = derivative.evaluate(EvaluationType.REAL, cm);

    setState(() {
      _derivativeResult = 'Derivative: $derivativeValue';
    });
  }
}
