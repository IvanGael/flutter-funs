
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:fl_chart/fl_chart.dart';


class StockListScreen extends StatelessWidget {
  const StockListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks'),
      ),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return StockListItem(
            stockSymbol: 'AAPL', 
            companyName: 'Apple Inc.',
            stockPrice: 150.00,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StockDetailScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StockListItem extends StatelessWidget {
  final String stockSymbol;
  final String companyName;
  final double stockPrice;
  final VoidCallback onTap;

  const StockListItem({super.key, 
    required this.stockSymbol,
    required this.companyName,
    required this.stockPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(stockSymbol),
        subtitle: Text(companyName),
        trailing: Text('\$$stockPrice'),
        onTap: onTap,
      ),
    );
  }
}

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AAPL - Apple Inc.',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: 0,
                  maxX: 7,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 1),
                        const FlSpot(6, 4),
                      ],
                      isCurved: true,
                      // colors: [Colors.blue],
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Stock Performance',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...'),
            const SizedBox(height: 16.0),
            const Text(
              'Recent News',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 50,
              child: Marquee(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: const TextStyle(fontSize: 16.0),
                velocity: 30.0,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 10.0,
                blankSpace: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

