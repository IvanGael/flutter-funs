import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';

class MyShortsScreen extends StatefulWidget {
  const MyShortsScreen({super.key});

  @override
  State<MyShortsScreen> createState() => _MyShortsScreenState();
}

class _MyShortsScreenState extends State<MyShortsScreen> {
  late VideoPlayerController _videoPlayerController;

  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset("assets/slow-burn.mp4")
      ..initialize().then((_) => {setState(() {})});
    
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      "assets/slow-burn.mp4"
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(autoPlay: true),
        betterPlayerDataSource: betterPlayerDataSource
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  // an arbitrary value, this can be whatever you need it to be
  double videoContainerRatio = 0.3;

  double getScale() {
    double videoRatio = _videoPlayerController.value.aspectRatio;

    if (videoRatio < videoContainerRatio) {
      ///for tall videos, we just return the inverse of the controller aspect ratio
      return videoContainerRatio / videoRatio;
    } else {
      ///for wide videos, divide the video AR by the fixed container AR
      ///so that the video does not over scale

      return videoRatio / videoContainerRatio;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Shorts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Video Player
          // if (_videoPlayerController.value.isInitialized)
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         _videoPlayerController.play();
          //       });
          //     },
          //     child: SizedBox(
          //       height: 200,
          //       child: AspectRatio(
          //         aspectRatio: getScale(),
          //         child: VideoPlayer(_videoPlayerController),
          //       ),
          //     ),
          //   ),
          AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
        controller: _betterPlayerController,
      ),
      ),
          // Video Information
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Video Title
                const Text(
                  'Awesome Flutter Tutorial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Video Views and Upload Date
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1.5M views'),
                    Text('Published on Feb 12, 2024'),
                  ],
                ),
                // User Profile and Subscribe Button
                Row(
                  children: [
                    CircleAvatar(
                        radius: 20, child: Image.asset("assets/avatar2.png")
                        // Add user profile image here
                        ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Subscribe'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Comments Section
          Expanded(
            child: ListView(
              children: [
                // Comment 1
                ListTile(
                  leading: CircleAvatar(child: Image.asset("assets/avatar3.png")
                      // Add commenter's profile image here
                      ),
                  title: const Text('Username'),
                  subtitle: const Text('Great video!'),
                ),
                // Comment 2
                ListTile(
                  leading: CircleAvatar(child: Image.asset("assets/avatar3.png")
                      // Add commenter's profile image here
                      ),
                  title: const Text('AnotherUser'),
                  subtitle: const Text('I learned a lot, thanks!'),
                ),
                // Add more comments as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
