import 'package:flutter/material.dart';

class Car {
  final String brand;
  final String model;
  final String color;
  final String imageUrl;

  Car({required this.brand, required this.model, required this.color, required this.imageUrl});
}

class CarParkingSimulate extends StatelessWidget {
  final List<Car> cars = [
    Car(brand: 'Toyota', model: 'Camry', color: 'Blue', imageUrl: 'assets/car1.png'),
    Car(brand: 'Ford', model: 'Mustang', color: 'Red', imageUrl: 'assets/car2.png'),
    Car(brand: 'Tesla', model: 'Model S', color: 'White', imageUrl: 'assets/car1.png'),
    Car(brand: 'Toyota', model: 'Camry', color: 'Blue', imageUrl: 'assets/car1.png'),
    Car(brand: 'Ford', model: 'Mustang', color: 'Red', imageUrl: 'assets/car2.png'),
    Car(brand: 'Tesla', model: 'Model S', color: 'White', imageUrl: 'assets/car1.png'),
    Car(brand: 'Ford', model: 'Mustang', color: 'Red', imageUrl: 'assets/car2.png'),
    Car(brand: 'Tesla', model: 'Model S', color: 'White', imageUrl: 'assets/car1.png'),
    Car(brand: 'Toyota', model: 'Camry', color: 'Blue', imageUrl: 'assets/car1.png'),
    Car(brand: 'Ford', model: 'Mustang', color: 'Red', imageUrl: 'assets/car2.png'),
  ];

  CarParkingSimulate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return CarCard(car: cars[index]);
            },
          ),
        ),
      );
  }
}

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
              child: Image.asset(
                car.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${car.brand} ${car.model}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Color: ${car.color}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}