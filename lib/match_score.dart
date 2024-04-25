import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class MatchScoreScreen extends StatefulWidget {
  const MatchScoreScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MatchScoreScreenState createState() => _MatchScoreScreenState();
}

class _MatchScoreScreenState extends State<MatchScoreScreen> {
  int homeScore = 0;
  int awayScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Match Score'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Lottie.asset(
                      'assets/soccer_ball.json',
                      repeat: true,
                      reverse: true,
                      animate: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: _buildTeamScore('argentina', homeScore),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: _buildTeamScore('algeria', awayScore),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamScore(String team, int score) {
    return Column(
      children: [
        Image.asset(
          'assets/$team.png',
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 10),
        Text(
          '$team: $score',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}