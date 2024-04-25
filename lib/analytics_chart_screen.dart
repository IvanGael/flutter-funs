
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsChartScreen extends StatelessWidget {
  const AnalyticsChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Chart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildChartTitle(),
            const SizedBox(height: 16.0),
            _buildAnalyticsChart(),
            const SizedBox(height: 16.0),
            _buildChartLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildChartTitle() {
    return const Text(
      'App Usage Analytics',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAnalyticsChart() {
    return SizedBox(
      height: 300.0,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 3),
                const FlSpot(2, 2),
                const FlSpot(3, 4),
                const FlSpot(4, 3),
                const FlSpot(5, 5),
                const FlSpot(6, 4),
              ],
              isCurved: true,
              color: Colors.pink,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
              // showTitles: true,
              sideTitles: SideTitles(
                showTitles: true
              )
            ),
            bottomTitles: AxisTitles(
              // showTitles: true,
              sideTitles: SideTitles(
                showTitles: true
              )
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  Widget _buildChartLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.blue, 'App Usage'),
        _buildLegendItem(Colors.blue, 'App Usage'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          color: color,
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}