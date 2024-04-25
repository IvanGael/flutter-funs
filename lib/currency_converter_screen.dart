import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  double amount = 1.0;
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double convertedAmount = 0.0;

  final List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'CNY',
    'INR',
    'AUD',
    'CAD',
    'SGD',
    'CHF',
    'MYR',
    'NZD',
    'THB',
    'PHP',
    'IDR',
    'ZAR',
    'HKD',
    'SEK',
    'NOK',
    'DKK',
  ];

  final Map<String, double> exchangeRates = {
    'USD': 1.0,
    'EUR': 0.88,
    'GBP': 0.77,
    'JPY': 109.25,
    'CNY': 6.38,
    'INR': 74.85,
    'AUD': 1.34,
    'CAD': 1.27,
    'SGD': 1.34,
    'CHF': 0.91,
    'MYR': 4.12,
    'NZD': 1.45,
    'THB': 31.18,
    'PHP': 50.48,
    'IDR': 14220.0,
    'ZAR': 14.93,
    'HKD': 7.75,
    'SEK': 8.50,
    'NOK': 8.85,
    'DKK': 6.10,
  };

  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http
        .get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        // You can replace 'USD' and 'EUR' with your desired default currencies
        convertedAmount = amount * data['rates'][toCurrency];
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.parse(value);
                  convertedAmount = amount * exchangeRates[toCurrency]!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: fromCurrency,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        fromCurrency = newValue;
                        convertedAmount = amount * exchangeRates[toCurrency]!;
                      });
                    }
                  },
                  items:
                      currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Icon(Icons.arrow_forward, size: 30.0),
                DropdownButton<String>(
                  value: toCurrency,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        toCurrency = newValue;
                        convertedAmount = amount * exchangeRates[toCurrency]!;
                      });
                    }
                  },
                  items:
                      currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Converted Amount: ${convertedAmount.toStringAsFixed(2)} $toCurrency',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
