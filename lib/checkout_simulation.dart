
import 'dart:async';

import 'package:flutter/material.dart';

class CheckoutSimulation {
  int clientId;
  final Completer<void> _checkoutCompleter = Completer<void>() ;

  CheckoutSimulation(this.clientId);

  Future<void> startCheckout() async {
    print('Client $clientId is waiting for checkout.');
    await Future.delayed(const Duration(seconds: 2)); // Simulating checkout process
    print('Client $clientId has completed checkout.');
    _checkoutCompleter.complete();
  }

  Future<void> get checkoutComplete => _checkoutCompleter.future;
}

class CheckoutQueue {
  List<CheckoutSimulation> clients = [];
  int servingClientId = 0;

  void addClient(int clientId) {
    clients.add(CheckoutSimulation(clientId));
  }

  void serveNextClient() async {
    if (clients.isNotEmpty) {
      servingClientId = clients.first.clientId;
      await clients.first.startCheckout();
      // clients.removeAt(0);
      // servingClientId = 0;
      serveNextClient();
    }
  }
}

class CheckoutSimulationTestScreen extends StatelessWidget {
  final CheckoutQueue checkoutQueue = CheckoutQueue();

  CheckoutSimulationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  int clientId = checkoutQueue.clients.length + 1;
                  checkoutQueue.addClient(clientId);
                },
                child: const Text('Add Client to Queue'),
              ),
              const SizedBox(height: 20),
              QueueDisplay(checkoutQueue),
            ],
          ),
        ),
      );
  }
}

class QueueDisplay extends StatefulWidget {
  final CheckoutQueue checkoutQueue;

  const QueueDisplay(this.checkoutQueue, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QueueDisplayState createState() => _QueueDisplayState();
}

class _QueueDisplayState extends State<QueueDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Checkout Queue'),
        const SizedBox(height: 10),
        for (var client in widget.checkoutQueue.clients)
          Text('Client ${client.clientId}'),
        const SizedBox(height: 10),
        Text('Serving Client ${widget.checkoutQueue.servingClientId}'),
      ],
    );
  }
}