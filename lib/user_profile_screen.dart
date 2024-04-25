
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildUserProfileImage(),
            const SizedBox(height: 16.0),
            _buildUserName(),
            const SizedBox(height: 8.0),
            _buildUserBio(),
            const SizedBox(height: 24.0),
            _buildUserStats(),
            const SizedBox(height: 24.0),
            _buildFollowButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileImage() {
    return const CircleAvatar(
      radius: 60.0,
      backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
    );
  }

  Widget _buildUserName() {
    return const Text(
      'John Doe',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildUserBio() {
    return const Text(
      'Passionate about technology and photography. Exploring the world one photo at a time.',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildUserStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem('Posts', '120'),
        const SizedBox(width: 24.0),
        _buildStatItem('Followers', '2.5K'),
        const SizedBox(width: 24.0),
        _buildStatItem('Following', '150'),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFollowButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement follow/unfollow logic here
        _showFollowStatus(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      ),
      child: const Text('Follow'),
    );
  }

  void _showFollowStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Follow Status'),
          content: const Text('You are now following John Doe.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}