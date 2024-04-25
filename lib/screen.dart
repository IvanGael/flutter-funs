
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transition de Brouillard'),
      ),
      body: Stack(
        children: [
          // Contenu initial avec l'effet de brouillard
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _showContent ? 0.0 : 1.0,
            child: const BlurHash(
              hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              imageFit: BoxFit.cover,
            ),
          ),
          // Nouveau contenu à révéler
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _showContent ? 1.0 : 0.0,
            child: Container(
              color: Colors.blue, // Remplace cela par ton propre contenu
              child: const Center(
                child: Text(
                  'Nouveau Contenu',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showContent = !_showContent;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}