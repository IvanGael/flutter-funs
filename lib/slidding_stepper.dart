import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/slidding_step.dart';

class SliddingStepper extends StatefulWidget {
  const SliddingStepper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SliddingStepperState createState() => _SliddingStepperState();
}

class _SliddingStepperState extends State<SliddingStepper> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SliddingStep> _steps = [
    SliddingStep(
      title: const Text('Step 1'),
      content: const Center(
        child: Text('Step 1 Content'),
      ),
    ),
    SliddingStep(
      title: const Text('Step 2'),
      content: const Center(
        child: Text('Step 2 Content'),
      ),
    ),
    SliddingStep(
      title: const Text('Step 3'),
      content: const Center(
        child: Text('Step 3 Content'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slidding Stepper'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _steps.map((SliddingStep step) {
                return step.content;
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  child: const Text('Previous'),
                ),
                Text('Step ${_currentPage + 1} of ${_steps.length}'),
                ElevatedButton(
                  onPressed: _currentPage < _steps.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
