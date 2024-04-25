
import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAlbumCover(),
            const SizedBox(height: 24.0),
            _buildSongDetails(),
            const SizedBox(height: 24.0),
            _buildPlayerControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/250?image=10'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Widget _buildSongDetails() {
    return const Column(
      children: [
        Text(
          'Song Title',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Artist Name - Album Name',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 36.0,
          onPressed: () {
            // Implement skip to previous logic
          },
        ),
        IconButton(
          icon: const Icon(Icons.play_arrow),
          iconSize: 64.0,
          onPressed: () {
            // Implement play/pause logic
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 36.0,
          onPressed: () {
            // Implement skip to next logic
          },
        ),
      ],
    );
  }
}