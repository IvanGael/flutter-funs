import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

class PodcastPlayerScreen extends StatefulWidget {
  const PodcastPlayerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PodcastPlayerScreenState createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends State<PodcastPlayerScreen> {
  // AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double currentSliderValue = 0.0;
  Duration duration = const Duration();

  @override
  void initState() {
    super.initState();
    // audioPlayer.onAudioPositionChanged.listen((Duration position) {
    //   setState(() {
    //     currentSliderValue = position.inSeconds.toDouble();
    //   });
    // });

    // audioPlayer.onDurationChanged.listen((Duration d) {
    //   setState(() {
    //     duration = d;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast Player'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Podcast Cover Image
          Image.network(
            'https://picsum.photos/250?image=15',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20),

          // Podcast Title
          const Text(
            'Podcast Title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Audio Slider
          Slider(
            value: currentSliderValue,
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                currentSliderValue = value;
              });
              // audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),

          // Current Time / Duration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentSliderValue.toInt()}s',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '${duration.inSeconds}s',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Play / Pause Button
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            iconSize: 48,
            onPressed: () {
              // if (isPlaying) {
              //   audioPlayer.pause();
              // } else {
              //   audioPlayer.play('https://example.com/podcast_audio.mp3');
              // }
              setState(() {
                isPlaying = !isPlaying;
              });
            },
          ),
        ],
      ),
    );
  }
}