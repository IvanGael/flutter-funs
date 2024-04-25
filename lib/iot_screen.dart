import 'package:flutter/material.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';


class IotScreen extends StatefulWidget {
  const IotScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<IotScreen> {
  bool livingRoomLightsOn = false;
  bool bedroomFanOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Device Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DeviceCard(
              title: 'Living Room',
              temperature: '22°C',
              humidity: '40%',
              onStatusChanged: (status) {
                setState(() {
                  livingRoomLightsOn = status;
                });
              },
              isDeviceOn: livingRoomLightsOn,
            ),
            const SizedBox(height: 16),
            DeviceCard(
              title: 'Bedroom',
              temperature: '20°C',
              humidity: '45%',
              onStatusChanged: (status) {
                setState(() {
                  bedroomFanOn = status;
                });
              },
              isDeviceOn: bedroomFanOn,
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String title;
  final String temperature;
  final String humidity;
  final Function(bool) onStatusChanged;
  final bool isDeviceOn;

  const DeviceCard({super.key, 
    required this.title,
    required this.temperature,
    required this.humidity,
    required this.onStatusChanged,
    required this.isDeviceOn,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Temperature: $temperature'),
                Text('Humidity: $humidity'),
              ],
            ),
            const SizedBox(height: 16),
            AnimatedSizeAndFade(
              fadeDuration: const Duration(milliseconds: 300),
              child: isDeviceOn
                  ? Image.asset(
                      'assets/light-on.png',
                      height: 50,
                      width: 50,
                    )
                  : Image.asset(
                      'assets/light-off.png',
                      height: 50,
                      width: 50,
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onStatusChanged(!isDeviceOn);
              },
              child: Text(isDeviceOn ? 'Turn Off' : 'Turn On'),
            ),
          ],
        ),
      ),
    );
  }
}