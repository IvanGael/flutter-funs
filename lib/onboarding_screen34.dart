import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/job_hiring.dart';

class OnboardingScreen34 extends StatefulWidget {
  const OnboardingScreen34({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen34>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> featureTitles = [
    'Search Jobs',
    'Apply Easily',
    'Get Notifications',
  ];

  List<String> featureDescriptions = [
    'Explore a variety of job opportunities from different industries.',
    'Apply to your dream job with just a few taps and get hired quickly.',
    'Receive timely notifications for new job openings and updates.',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: featureTitles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Himalayas'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: List.generate(
            featureTitles.length,
            (index) => Tab(text: featureTitles[index]),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          featureTitles.length,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnboardingPage(
                index: index,
                title: featureTitles[index],
                description: featureDescriptions[index],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JobHiringScreen(),
                    ),
                  );
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final int index;
  final String title;
  final String description;

  const OnboardingPage(
      {super.key,
      required this.index,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index == 0)
            const Icon(
              Icons.search,
              size: 100.0,
              color: Colors.deepPurple,
            ),
          if (index == 1)
            const Icon(
              Icons.work,
              size: 100.0,
              color: Colors.deepPurple,
            ),
          if (index == 2)
            const Icon(
              Icons.notifications,
              size: 100.0,
              color: Colors.deepPurple,
            ),
          const SizedBox(height: 16.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
