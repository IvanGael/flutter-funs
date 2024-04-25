import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/explosive_heart_button.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatelessWidget {
  final String videoAsset;
  const ReelsScreen({super.key, required this.videoAsset});

  @override
  Widget build(BuildContext context) {
    return ReelPreview(
      userAvatar: 'assets/parcel3.jpg',
      videoUrl: videoAsset,
      username: 'The first take',
      caption: 'Naruto vs One piece opening',
    );
  }
}

class ReelPreview extends StatefulWidget {
  final String userAvatar;
  final String videoUrl;
  final String username;
  final String caption;

  const ReelPreview({
    super.key,
    required this.userAvatar,
    required this.videoUrl,
    required this.username,
    required this.caption,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ReelPreviewState createState() => _ReelPreviewState();
}

class _ReelPreviewState extends State<ReelPreview> {
  late VideoPlayerController _videoController;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _isPlaying = false;
    _videoController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_videoController.value.isInitialized)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                  _isPlaying
                      ? _videoController.play()
                      : _videoController.pause();
                });
              },
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter,
              //     colors: [
              //       Colors.black.withOpacity(0.8),
              //       Colors.transparent,
              //     ],
              //   ),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                            _isPlaying
                                ? _videoController.play()
                                : _videoController.pause();
                          });
                        },
                      ),
                      // ExplosiveHeartButton(),
                      IconButton(
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.white),
                        onPressed: () {
                          // Handle like functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline,
                            color: Colors.white),
                        onPressed: () {
                          // Handle comment functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          // Handle send functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz, color: Colors.white),
                        onPressed: () {
                          // Handle more options functionality
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 0,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(widget.userAvatar),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.caption,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
