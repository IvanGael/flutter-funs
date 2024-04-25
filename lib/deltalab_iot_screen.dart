import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SensorData {
  String title;
  double value;

  SensorData(this.title, this.value);
}

class DeltalabIOTScreen extends HookWidget {
  const DeltalabIOTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeltaLab IoT'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSensorCard('Brightness', context),
              _buildSensorCard('Sound', context),
              _buildSensorCard('Temperature', context),
              _buildSensorCard('Atmospheric Pressure', context),
              _buildSensorCard('Humidity', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, BuildContext context) {
    final sensorData = useState<SensorData>(SensorData(title, 10.0));

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensorData.value.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: sensorData.value.value),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Text(
                      'Value: ${value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16.0),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Mock configuration - replace with your logic
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              'Configuration for ${sensorData.value.title}'),
                          content: const Text(
                              'Add your configuration options here.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Configure'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: sensorData.value.value / 100,
              minHeight: 10.0,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
