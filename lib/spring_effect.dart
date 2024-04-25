import 'package:flutter/material.dart';

class SpringEffectTestScreen extends StatefulWidget {
  const SpringEffectTestScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpringEffectTestScreenState createState() => _SpringEffectTestScreenState();
}

class _SpringEffectTestScreenState extends State<SpringEffectTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  List<String> images = [
    "assets/cinema1.jpg",
    "assets/cinema2.jpg",
    "assets/cinema3.jpg",
    "assets/cinema2.jpg",
    "assets/cinema3.jpg",
    "assets/cinema1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Image.asset(
                "assets/call_illustration.jpg",
                width: 360,
                height: 360,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return Card(
                    child: Center(
                      child: Image.asset(
                        images[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 350,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_circle, color: Colors.tealAccent,),
                          SizedBox(width: 5,),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
