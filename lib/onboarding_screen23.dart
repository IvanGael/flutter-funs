import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


class OnboardingScreen23 extends StatefulWidget {
  const OnboardingScreen23({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}


class _OnboardingScreenState extends State<OnboardingScreen23> {
  int currentPage = 0;
  PageController pageController = PageController();
  late AssetsAudioPlayer audioPlayer;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to the App!',
      content: 'Discover amazing features that make your experience unique.',
      audioPath: 'assets/music.mp3',
    ),
    OnboardingPage(
      title: 'Customization Options',
      content: 'Personalize your app with themes, colors, and much more.',
      audioPath: 'assets/music.mp3',
    ),
    OnboardingPage(
      title: 'Connect and Share',
      content: 'Connect with friends, share experiences, and make memories.',
      audioPath: 'assets/music.mp3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    audioPlayer = AssetsAudioPlayer();
    playMusic(onboardingPages[currentPage].audioPath);
  }

  void playMusic(String audioPath) {
    audioPlayer.open(Audio('assets/music.mp3'));
    audioPlayer.play();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: onboardingPages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
            playMusic(onboardingPages[index].audioPath);
          });
        },
        itemBuilder: (context, index) {
          return OnboardingPageWidget(onboardingPage: onboardingPages[index]);
        },
      ),
    );
  }
}


class OnboardingPage {
  final String title;
  final String content;
  final String audioPath;

  OnboardingPage({
    required this.title,
    required this.content,
    required this.audioPath,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const OnboardingPageWidget({super.key, required this.onboardingPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            onboardingPage.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            onboardingPage.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
