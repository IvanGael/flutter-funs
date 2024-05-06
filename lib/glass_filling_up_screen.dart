// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math';

import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class MultipleGlassFillingUpCarousel extends StatefulWidget {
  const MultipleGlassFillingUpCarousel({super.key});

  @override
  State<MultipleGlassFillingUpCarousel> createState() => _GlassState();
}

class _GlassState extends State<MultipleGlassFillingUpCarousel> {
  final List _glassItems = [
    const GlassFillingUpScreen(color: Colors.pink),
    const GlassFillingUpScreen(color: Colors.blue),
    const GlassFillingUpScreen(color: Colors.indigo),
    const GlassFillingUpScreen(color: Colors.purple)
  ];

  late PageController _pageController;
  int _currentPageIndex = 0;

  MaterialColor _currentGlassItemColor = Colors.pink;

  TextEditingController _qteController = TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  increaseQte() {
    int qte = int.parse(_qteController.text.toString()) + 1;
    setState(() {
      _qteController.text = qte.toString();
    });
  }

  decreaseQte() {
    int qte = int.parse(_qteController.text.toString()) - 1;
    if(qte >= 0){
      setState(() {
      _qteController.text = qte.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentGlassItemColor = _glassItems[_currentPageIndex].color;
      });
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 400,
            color: _currentGlassItemColor.withOpacity(0.8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _glassItems.length,
                itemBuilder: (context, index) {
                  return _glassItems[index];
                },
                controller: _pageController,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey.shade300)),
                onPressed: _currentPageIndex >= 0
                    ? () {
                        if (_currentPageIndex > 0) {
                          _currentPageIndex--;
                          _pageController.animateToPage(
                            _currentPageIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        }
                      }
                    : null,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey.shade300)),
                onPressed: () {
                  if (_currentPageIndex < _glassItems.length - 1) {
                    _currentPageIndex++;
                    // _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    _pageController.animateToPage(
                      _currentPageIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Set quantity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 60,
                  child: TextField(
                    controller: _qteController,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 5,
                          style: BorderStyle.solid
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: decreaseQte,
                  child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.greenAccent.shade400,
                      child: const Icon(Icons.remove)),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: increaseQte,
                  child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.greenAccent.shade400,
                      child: const Icon(Icons.add)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IngredientLegendItem(width: 100, height: 10, color: Colors.red,),
                        SizedBox(width: 5,),
                        Text(
                          "Strawberry"
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "≃ 1.05mg"
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IngredientLegendItem(width: 100, height: 10, color: Colors.red.shade800,),
                        const SizedBox(width: 5,),
                        const Text(
                          "Apple"
                        ),
                        const SizedBox(width: 5,),
                        const Text(
                          "≃ 2.05mg"
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IngredientLegendItem(width: 100, height: 10, color: Colors.amber,),
                        SizedBox(width: 5,),
                        Text(
                          "Mandarin"
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "≃ 0.05mg"
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IngredientLegendItem(width: 100, height: 10, color: Colors.indigo,),
                        SizedBox(width: 5,),
                        Text(
                          "Blueberry"
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "≃ 0.09mg"
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_checkout,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Checkout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                        )
                        )
              ],
            ),
          )
        ],
      ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class IngredientLegendItem extends StatelessWidget {
  final double width;
  final double height;
  final dynamic color;

  const IngredientLegendItem({
    super.key,
    required this.width,
    required this.height,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}

class GlassFillingUpScreen extends StatefulWidget {
  final MaterialColor color;
  const GlassFillingUpScreen({Key? key, required this.color}) : super(key: key);

  @override
  _GlassFillingUpScreenState createState() => _GlassFillingUpScreenState();
}

class _GlassFillingUpScreenState extends State<GlassFillingUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _liquidController;
  late AnimationController _lemonController;
  final double glassWidth = 300;
  final double glassHeight = 300;
  double liquidWidth = 120;
  double liquidHeight = 660;
  bool liquidStop = false;
  String lemonAsset = "assets/lemon.png";

  @override
  void initState() {
    super.initState();
    _liquidController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    );

    _lemonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    );

    _liquidController.addListener(() {
      if (_liquidController.status == AnimationStatus.completed) {
        _startLemonAnimation();
      }
    });

    _liquidController.repeat();

    Timer.periodic(const Duration(seconds: 18), (timer) {
      _liquidController.stop();
      setState(() {
        liquidStop = true;
      });
    });

    // Future.delayed(const Duration(seconds: 18), () {
    //   _liquidController.stop();
    //   setState(() {
    //     liquidStop = true;
    //   });
    // });
  }

  void _startLemonAnimation() {
    _liquidController.reset();
    _liquidController.duration = const Duration(seconds: 10);
    _liquidController.forward();

    _lemonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/glass2-sans-fond.png',
                width: glassWidth, height: glassHeight),
          ),
          AnimatedBuilder(
            animation: _liquidController,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                painter: LiquidPainter(_liquidController.value, widget.color),
                size: Size(liquidWidth, liquidHeight * _liquidController.value),
              );
            },
          ),
          if (liquidStop)
            AnimatedBuilder(
              animation: _lemonController,
              builder: (BuildContext context, Widget? child) {
                // double sliceTop = 3320 * 0.2 + 100 * _lemonController.value;
                double sliceTop = 210;
                return Positioned(
                    top: sliceTop,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(18, 90),
                          child: Image.asset("assets/myrtille.png",
                              width: 60, height: 60),
                        ),
                        Transform.translate(
                          offset: const Offset(-5, 60),
                          child: Image.asset(
                            "assets/apple.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Lottie.asset("assets/watermelon.json",
                                width: 80, height: 80, fit: BoxFit.cover),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  lemonAsset = "assets/lemon-slice.png";
                                });
                              },
                              child: Transform.translate(
                                offset: const Offset(-12, 20),
                                child: Image.asset(lemonAsset,
                                    width: 40, height: 40, fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _liquidController.dispose();
    _lemonController.dispose();
    super.dispose();
  }
}

class LiquidPainter extends CustomPainter {
  final double animationValue;
  final MaterialColor color;

  LiquidPainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        // Colors.blue[700]!.withOpacity(0.3),
        // Colors.blue[800]!.withOpacity(0.3),
        // Colors.blue[900]!.withOpacity(0.4),
        color[500]!.withOpacity(0.3),
        color[600]!.withOpacity(0.3),
        color[400]!.withOpacity(0.4),
      ],
      stops: const [0.3, 0.5, 0.7],
    );

    final rect = Rect.fromPoints(
        Offset(0, size.height * 0.6), Offset(size.width, size.height));

    final paint = Paint()..shader = gradient.createShader(rect);

    final path = Path();

    final double liquidTop = size.height * 0.6 * (1.58 - animationValue);

    path.moveTo(-5, liquidTop);

    path.quadraticBezierTo(
      size.width * 0.10,
      liquidTop,
      size.width * 0.1,
      liquidTop,
    );

    path.cubicTo(
      size.width * 0.5,
      liquidTop - 10,
      size.width + 10,
      liquidTop,
      size.width,
      liquidTop,
    );

    path.quadraticBezierTo(
      size.width,
      liquidTop - 1,
      size.width + 5,
      liquidTop,
    );

    path.lineTo(size.width, size.height - 25);
    path.lineTo(2, size.height - 38);
    path.close();

    canvas.drawPath(path, paint);

    // Draw bubbles rising from the bottom of the glass
    drawBubbles(canvas, size);
  }

  void drawBubbles(Canvas canvas, Size size) async {
    final bubblePaint = Paint()
      ..color = color[400]!.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    const bubbleRadius = 4.0;

    for (int i = 0; i < 15; i++) {
      final bubbleX = Random().nextInt(size.width.toInt()).toDouble();
      final bubbleY = size.height * (0.8 - animationValue) -
          Random().nextInt((size.height * 0.4).toInt()).toDouble();

      canvas.drawCircle(Offset(bubbleX, bubbleY), bubbleRadius, bubblePaint);
    }

    // Future<ui.Image> loadImage(String path) async {
    //   final ByteData data = await rootBundle.load(path);
    //   final Uint8List bytes = data.buffer.asUint8List();
    //   final Completer<ui.Image> completer = Completer();
    //   ui.decodeImageFromList(bytes, (ui.Image img) {
    //     return completer.complete(img);
    //   });
    //   return completer.future;
    // }

    // final offsetX = Random().nextInt(size.width.toInt()).toDouble();
    // final offsetY = size.height * (0.8 - animationValue) - Random().nextInt((size.height * 0.4).toInt()).toDouble();

    // final image = await loadImage("assets/cloud.png");
    // canvas.drawImage(image, Offset(offsetX, offsetY), bubblePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
