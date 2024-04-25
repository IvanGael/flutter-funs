
import 'package:flutter/material.dart';


class ATMHomeScreen extends StatefulWidget {
  const ATMHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ATMHomeScreenState createState() => _ATMHomeScreenState();
}

class _ATMHomeScreenState extends State<ATMHomeScreen> {
  double balance = 5000.0; // Initial account balance
  bool isWithdrawing = false;
  TextEditingController withdrawalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATM Machine'),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Balance: \$${balance.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: withdrawalController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Enter Amount to Withdraw'),
                enabled: !isWithdrawing,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isWithdrawing ? null : () => startWithdrawal(context),
                child: const Text('Withdraw'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startWithdrawal(BuildContext context) {
    double withdrawalAmount = double.tryParse(withdrawalController.text) ?? 0.0;

    if (withdrawalAmount <= 0 || withdrawalAmount > balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid withdrawal amount',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      setState(() {
        isWithdrawing = true;
      });

      // Simulating a withdrawal process
      Future.delayed(const Duration(seconds: 10), () {
        setState(() {
          balance -= withdrawalAmount;
          isWithdrawing = false;
          withdrawalController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Withdrawal successful: \$${withdrawalAmount.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.greenAccent,
          ),
        );
      });
    }
  }
}