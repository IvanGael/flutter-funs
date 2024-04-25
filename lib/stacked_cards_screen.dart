import 'package:flutter/material.dart';

class StackedCardsScreen extends StatefulWidget {
  const StackedCardsScreen({Key? key}) : super(key: key);

  @override
  _StackedCardsScreenState createState() => _StackedCardsScreenState();
}

class _StackedCardsScreenState extends State<StackedCardsScreen> {
  final PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if both width and height are bounded
            if (constraints.hasBoundedWidth && constraints.hasBoundedHeight) {
              return _buildPageView();
            } else {
              // Placeholder container if dimensions are not yet established
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (_pageController.position.hasContentDimensions && _pageController.position.hasPixels) {
              return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double angle = (index - _pageController.page!).clamp(-1.0, 1.0) * 0.2;
                return Transform.rotate(
                  angle: angle,
                  child: buildCard(index),
                );
              },
            );
            }
            return Container();
          },
        );
      },
    );
  }

  Widget buildCard(int index) {
    return Card(
      elevation: 5.0,
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'Card $index',
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
