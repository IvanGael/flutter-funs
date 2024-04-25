
import 'package:flutter/material.dart';

class BkPosTerminalScreen extends StatefulWidget {
  const BkPosTerminalScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BkPosTerminalScreenState createState() => _BkPosTerminalScreenState();
}

class _BkPosTerminalScreenState extends State<BkPosTerminalScreen> {
  List<MenuItem> menuItems = [
    MenuItem('Whopper', 'assets/whopper.png', 5.99),
    MenuItem('Chicken Royale', 'assets/chicken.png', 6.99),
    MenuItem('Veggie Burger', 'assets/veggie.png', 4.99),
    MenuItem('Fries', 'assets/fries.png', 2.49),
    MenuItem('Onion Rings', 'assets/onion-rings.png', 3.99),
    MenuItem('Soft Drink', 'assets/soft-drink.png', 1.99),
  ];

  List<MenuItem> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BK'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              itemCount: menuItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MenuItemCard(
                  menuItem: menuItems[index],
                  onTap: () {
                    setState(() {
                      selectedItems.add(menuItems[index]);
                    });
                  },
                );
              },
            ),
          ),
          const Divider(),
          const Text(
            'Selected Items',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                return MenuItemCard(
                  menuItem: selectedItems[index],
                  onTap: () {
                    setState(() {
                      selectedItems.removeAt(index);
                    });
                  },
                  canRemove: true,
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement order placement logic here
                // print('Placing Order: $selectedItems');
              },
              child: const Text('Place Order'),
            ),
          ),
          const SizedBox(height: 8.0),
          TotalPrice(selectedItems: selectedItems),
        ],
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String image;
  final double price;

  MenuItem(this.name, this.image, this.price);
}

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback onTap;
  final bool canRemove;

  const MenuItemCard({
    Key? key,
    required this.menuItem,
    required this.onTap,
    this.canRemove = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(menuItem.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                menuItem.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${menuItem.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              if (canRemove)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove, color: Colors.white,),
                      onPressed: onTap,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalPrice extends StatelessWidget {
  final List<MenuItem> selectedItems;

  const TotalPrice({Key? key, required this.selectedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = selectedItems.fold(0, (sum, item) => sum + item.price);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Price:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}