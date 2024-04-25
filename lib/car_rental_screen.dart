
import 'package:flutter/material.dart';

class CarRentalScreen extends StatelessWidget {
  const CarRentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Rental'),
      ),
      body: const CarList(),
    );
  }
}

class CarList extends StatelessWidget {
  const CarList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Change this to the number of cars you want to display
      itemBuilder: (context, index) {
        return CarCard(
          carName: 'Car $index',
          imageUrl: 'https://placekitten.com/200/200', // Replace with actual car image URL
          onTap: () {
            // Handle the tap event for each car
            // You can navigate to a details screen or perform any other action
            print('Car $index tapped');
          },
        );
      },
    );
  }
}

class CarCard extends StatelessWidget {
  final String carName;
  final String imageUrl;
  final Function onTap;

  const CarCard({super.key, 
    required this.carName,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                carName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}