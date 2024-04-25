import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FunctionDrawerScreen extends StatefulWidget {
  const FunctionDrawerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FunctionDrawerState createState() => _FunctionDrawerState();
}

class _FunctionDrawerState extends State<FunctionDrawerScreen> {
  final TextEditingController _functionController = TextEditingController();
  List<FlSpot> functionPoints = [];

  //draw the function
  void _drawFunction() {
    String functionExpression = _functionController.text;
    functionPoints.clear();

    if (functionExpression.isNotEmpty) {
      Parser parser = Parser();
      Expression expression = parser.parse(functionExpression);

      for (double x = -5; x <= 5; x += 0.1) {
        ContextModel contextModel = ContextModel();
        contextModel.bindVariable(Variable('x'), Number(x));
        double y = expression.evaluate(EvaluationType.REAL, contextModel);
        functionPoints.add(FlSpot(x, y));
      }
    }

    setState(() {}); // Trigger a rebuild to update the chart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Function representative curve'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _functionController,
              decoration: const InputDecoration(
                  labelText: 'Enter a mathematical function'),
              onChanged: (value) => _drawFunction(),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: functionPoints.isEmpty
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // CircularProgressIndicator(
                            //   // value: 40,
                            //   color: Colors.pink,
                            //   // valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                            // ),
                            SpinKitFoldingCube(
                              size: 30,
                              itemBuilder: (_, int index) {
                                return const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    shape: BoxShape.circle
                                  )
                                );
                              },
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // const Text('Waiting for the prompt...'),
                          ],
                        ),
                      )
                    : LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: functionPoints,
                              isCurved: true,
                              color: Colors.pink[500],
                              belowBarData: BarAreaData(show: true),
                            ),
                          ],
                          titlesData: const FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              )),
                          gridData: const FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
