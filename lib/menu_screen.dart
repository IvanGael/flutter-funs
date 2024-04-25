
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(name: 'Fries', price: 2.5, image: 'assets/fries.png', desc: 'fries'),
    MenuItem(name: 'chicken', price: 3.0, image: 'assets/chicken.png', desc: 'chicken'),
    MenuItem(name: 'onion-rings', price: 3.5, image: 'assets/onion-rings.png', desc: 'onion-rings'),
    MenuItem(name: 'whopper', price: 4.0, image: 'assets/whopper.png', desc: 'whopper'),
  ];

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Shop Menu'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(menuItem: menuItems[index]),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: Hero(
                  tag: menuItems[index].name,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(menuItems[index].image),
                  ),
                ),
                title: Text(menuItems[index].name),
                subtitle: Text('\$${menuItems[index].price.toStringAsFixed(2)}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final MenuItem menuItem;

  const DetailsScreen({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menuItem.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: menuItem.name,
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage(menuItem.image),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              '\$${menuItem.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Description: ${menuItem.desc}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;
  final String image;
  final String desc;

  MenuItem({required this.name, required this.price, required this.image, required this.desc});
}