import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

class OnboardingScreen13 extends StatefulWidget {
  const OnboardingScreen13({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen13> {
  late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the VideoPlayerController
    _videoPlayerController = VideoPlayerController.asset('assets/video.mp4');

    // Initialize the ChewieController
    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   looping: true,
    //   subtitle: Subtitles([
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 1,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ]),
    //   subtitleBuilder: (context, subtitle) => Container(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(
    //       subtitle,
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );

    // Start playing the video
    _videoPlayerController.initialize().then((_) {
      setState(() {
        // Now that the controller is initialized, start playing the video
        _videoPlayerController.play();
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // controller: _chewieController,
      ),
    );
  }
}
