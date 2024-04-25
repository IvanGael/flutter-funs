import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  final TextEditingController passwordController = TextEditingController();

  String? passwordValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    particles = List.generate(
      50,
      (index) => Particle(
        position: Offset(
          Random().nextDouble() * 280,
          Random().nextDouble() * 200,
        ),
        color: Colors.pink[900]!,
        size: Random().nextDouble() * 30 + 10,
        speed: Random().nextDouble() * 0.6 + 0.2,
        angle: Random().nextDouble() * 2 * pi,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: particles.map((particle) {
                  return Positioned(
                    left: particle.position.dx +
                        sin(particle.angle) *
                            _controller.value *
                            particle.speed,
                    top: particle.position.dy +
                        cos(particle.angle) *
                            _controller.value *
                            particle.speed,
                    child: Container(
                      width: particle.size,
                      height: particle.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: particle.color,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: false,
                  controller: passwordController,
                  onChanged: (value) {
                    setState(() {
                      passwordValue = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    // Implement sign-in logic here
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'No account yet?',
                      style: TextStyle(
                        color: Colors.pink,    
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.pink,
                        decorationStyle: TextDecorationStyle.dotted                    
                      ),
                      
                    ),
                  ),
                )
              ],
            )
                ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  Color color;
  double size;
  double speed;
  double angle;

  Particle({
    required this.position,
    required this.color,
    required this.size,
    required this.speed,
    required this.angle,
  });
}
