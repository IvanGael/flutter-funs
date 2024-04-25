
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class WordAssociationGame extends StatefulWidget {
  const WordAssociationGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WordAssociationGameState createState() => _WordAssociationGameState();
}

class _WordAssociationGameState extends State<WordAssociationGame> {
  List<String> words = [
    "Sun",
    "Ocean",
    "Adventure",
    "Space",
    "Innovation",
    "Dream",
    "Challenge",
    "Music",
    "Jungle",
    "Cuisine",
  ];

  String currentPrompt = "";
  String userInput = "";
  int score = 0;
  int timeLeft = 30;
  bool gameActive = false;

  final TextEditingController _textEditingController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    generateRandomPrompt();
  }

  void generateRandomPrompt() {
    final random = Random();
    currentPrompt = words[random.nextInt(words.length)];
  }

  void startGame() {
    setState(() {
      gameActive = true;
      score = 0;
      timeLeft = 30;
    });
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timeLeft == 0) {
        timer.cancel();
        endGame();
      } else {
        setState(() {
          timeLeft--;
        });
      }
    });
  }

  void endGame() {
    setState(() {
      gameActive = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("Your score: $score"),
          actions: [
            ElevatedButton(
              child: const Text("Play Again"),
              onPressed: () {
                Navigator.of(context).pop();
                generateRandomPrompt();
                startGame();
              },
            ),
          ],
        );
      },
    );
  }

  void checkAnswer() {
    if (userInput.toLowerCase() == currentPrompt.toLowerCase()) {
      setState(() {
        score++;
      });
      generateRandomPrompt();
    }
    userInput = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Prompt: $currentPrompt',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            gameActive
                ? Column(
                    children: [
                      Text(
                        'Time Left: $timeLeft seconds',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            userInput = value;
                          });
                        },
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'Your Word',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          checkAnswer();
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startGame();
                    },
                    child: const Text('Start Game'),
                  ),
          ],
        ),
      ),
    );
  }
}