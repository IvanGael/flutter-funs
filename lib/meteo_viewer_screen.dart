
import 'package:flutter/material.dart';

class MeteoViewerScreen extends StatelessWidget {
  const MeteoViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Floating Meteo Viewer'),
      // ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome')
          ],
        ),
      ),
      floatingActionButton: Transform.translate(
        offset: Offset(0, -30),
        child: WeatherCard(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}

class WeatherCard extends StatefulWidget {
  const WeatherCard({Key? key}) : super(key: key);

  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap on the WeatherCard if needed
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bruxelles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
                Icon(
                  Icons.cloud,
                  size: 50,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
                Text(
                      'Temperature: 25°C',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Condition: Sunny',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                SizedBox(height: 10),
                Text(
                      'Humidity: 70%',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Wind: 10 km/h',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
