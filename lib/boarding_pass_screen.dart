import 'package:flutter/material.dart';

class BoardingPassScreen extends StatelessWidget {
  const BoardingPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boarding Pass'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFlightInfo(),
            const SizedBox(height: 16.0),
            _buildPassengerInfo(),
            const SizedBox(height: 16.0),
            _buildAdditionalInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Flight 123',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'From: JFK',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'To: LAX',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gate: A12',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Seat: 14A',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Passenger Information',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Passenger: John Doe',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              Text(
                'Class: Economy',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Boarding Time: 12:30 PM',
                style: TextStyle(
                  color: Colors.black
                ),
          ),
          Text(
            'Departure Time: 1:00 PM',
                style: TextStyle(
                  color: Colors.black
                ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Promotions and Offers',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Explore our credit card offers and enjoy exclusive benefits during your journey.',
                style: TextStyle(
                  color: Colors.black
                ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Check out partner deals with local hotels and resorts for a discounted stay.',
                style: TextStyle(
                  color: Colors.black
                ),
          ),
        ],
      ),
    );
  }
}