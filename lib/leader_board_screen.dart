import 'package:flutter/material.dart';

class LeaderboardItemData {
  final String rank;
  final String username;
  final String points;
  final String avatarUrl;

  LeaderboardItemData({
    required this.rank,
    required this.username,
    required this.points,
    required this.avatarUrl,
  });
}

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final List<LeaderboardItemData> leaderboardData = [
    LeaderboardItemData(
      rank: '1',
      username: 'Player123',
      points: '2500',
      avatarUrl: 'https://picsum.photos/250?image=10',
    ),
    LeaderboardItemData(
      rank: '2',
      username: 'Gamer456',
      points: '2200',
      avatarUrl: 'https://picsum.photos/250?image=11',
    ),
    LeaderboardItemData(
      rank: '3',
      username: 'ProPlayer',
      points: '2000',
      avatarUrl: 'https://picsum.photos/250?image=12',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLeaderboardTitle(),
            const SizedBox(height: 16.0),
            _buildLeaderboardList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardTitle() {
    return const Text(
      'Gaming Leaderboard',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLeaderboardList() {
    return Expanded(
      child: ListView.builder(
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          return _buildLeaderboardItem(leaderboardData[index]);
        },
      ),
    );
  }

  Widget _buildLeaderboardItem(LeaderboardItemData data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAvatar(data.avatarUrl),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.rank,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  data.username,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            data.points,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String avatarUrl) {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(avatarUrl),
    );
  }
}
