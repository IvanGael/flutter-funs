import 'package:flutter/material.dart';

class Element {
  final String symbol;
  final String name;
  final int atomicNumber;
  final Color color;

  Element({
    required this.symbol,
    required this.name,
    required this.atomicNumber,
    required this.color,
  });
}

class PeriodicTableScreen extends StatelessWidget {
  final List<Element> elements = [
    Element(symbol: 'H', name: 'Hydrogen', atomicNumber: 1, color: Colors.teal),
    Element(symbol: 'He', name: 'Helium', atomicNumber: 2, color: Colors.blue),
    Element(symbol: 'Li', name: 'Lithium', atomicNumber: 3, color: Colors.purple),
    Element(symbol: 'Be', name: 'Beryllium', atomicNumber: 4, color: Colors.pink),
    Element(symbol: 'B', name: 'Boron', atomicNumber: 5, color: Colors.orange),
    Element(symbol: 'C', name: 'Carbon', atomicNumber: 6, color: Colors.black),
    Element(symbol: 'N', name: 'Nitrogen', atomicNumber: 7, color: Colors.blue),
    Element(symbol: 'O', name: 'Oxygen', atomicNumber: 8, color: Colors.red),
    Element(symbol: 'F', name: 'Fluorine', atomicNumber: 9, color: Colors.greenAccent),
    Element(symbol: 'Ne', name: 'Neon', atomicNumber: 10, color: Colors.blue),
    Element(symbol: 'U', name: 'Uranium', atomicNumber: 92, color: Colors.indigo),
  ];

  PeriodicTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periodic Table'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return ElementTile(element: elements[index]);
        },
      ),
    );
  }
}

class ElementTile extends StatelessWidget {
  final Element element;

  const ElementTile({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: element.color,
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            element.symbol,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            element.atomicNumber.toString(),
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            element.name,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
