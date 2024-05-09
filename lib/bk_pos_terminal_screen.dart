
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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


  placeOrder(){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          content: SizedBox(
            width: 235,
            height: 235,
            child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  "assets/place_order.json",
                  width: 200,
                  height: 200
                ),
                const Text(
                  "Confirmed",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
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
            child: selectedItems.isEmpty ?
          const Center(
            child: Text("Nothing selected yet!"),
          ) :
            ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                return SelectedMenuItemCard(
                  menuItem: selectedItems[index],
                  onTap: () {
                    setState(() {
                      selectedItems.removeAt(index);
                    });
                  }
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  ElevatedButton(
              onPressed: selectedItems.isEmpty ? null : () {
                placeOrder();
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

  const MenuItemCard({
    Key? key,
    required this.menuItem,
    required this.onTap
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
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(menuItem.image),
                    fit: BoxFit.contain,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}


class SelectedMenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback onTap;

  const SelectedMenuItemCard({
    Key? key,
    required this.menuItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(menuItem.image),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white,),
                        onPressed: onTap,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  menuItem.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6.0),
                Text(
                  '\$${menuItem.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                )
              ],
            ),
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
      color: Colors.deepOrangeAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Price:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}