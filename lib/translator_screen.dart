
import 'package:flutter/material.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  String selectedLanguage = 'English';
  String inputText = '';
  String translatedText = '';

  // Function to handle language selection
  void onLanguageChanged(String? language) {
    setState(() {
      selectedLanguage = language!;
    });
  }

  // Function to handle translation
  void onTranslatePressed() {
    // Implement translation logic here
    // You can use a translation API or any other method based on your requirements
    // Update the translatedText variable with the translated text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Translate from:',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: onLanguageChanged,
              items: ['English', 'Spanish', 'French', 'German']
                  .map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter text:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type here...',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onTranslatePressed,
              child: const Text('Translate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Translated text:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                translatedText,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}