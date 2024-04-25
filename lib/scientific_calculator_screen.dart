import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildInputDisplay(),
            const SizedBox(height: 16),
            _buildCalculatorButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Text(
        _input,
        style: const TextStyle(fontSize: 24, color: Colors.white),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildCalculatorButtons() {
    return Column(
      children: [
        _buildRow(["7", "8", "9", "/"]),
        _buildRow(["4", "5", "6", "*"]),
        _buildRow(["1", "2", "3", "-"]),
        _buildRow([".", "0", "=", "+"]),
        const SizedBox(height: 10,),
        _buildClearButton(),
      ],
    );
  }

  Widget _buildClearButton() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: ElevatedButton(
          onPressed: () => _onClearButtonPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "C",
              style: TextStyle(fontSize: 20),
            ),
          ),
        )),
      ],
    );
  }

  void _onClearButtonPressed() {
    setState(() {
      _input = '';
    });
  }

  Widget _buildRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buttons
          .map(
            (button) => ElevatedButton(
              onPressed: () => _onButtonPressed(button),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  button,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "=") {
        try {
          _input = _evaluateExpression();
        } catch (e) {
          _input = "Error";
        }
      } else {
        _input += buttonText;
      }
    });
  }

  String _evaluateExpression() {
    Parser p = Parser();
    Expression exp = p.parse(_input);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);

    // Check if the result is an integer, display as integer if true
    return result % 1 == 0 ? result.toInt().toString() : result.toString();
  }
}
