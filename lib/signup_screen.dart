import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/custom_stepper.dart';
import 'package:flutter_explosive_like/liquid_step.dart';
import 'package:flutter_explosive_like/liquid_stepper.dart';
import 'package:flutter_explosive_like/password_checker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  int currentStep = 0;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController additionalInfoController;

  String passwordValue = "";
  String cfpasswordValue = "";

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
          Random().nextDouble() * 140,
        ),
        color: Colors.pink[900]!,
        size: Random().nextDouble() * 20 + 6,
        speed: Random().nextDouble() * 0.6 + 0.2,
        angle: Random().nextDouble() * 2 * pi,
      ),
    );

    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    additionalInfoController = TextEditingController();
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
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 20),
            child: FlipInY(
              delay: const Duration(milliseconds: 100),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // CustomStepper(
                //   currentStep: currentStep,
                //   steps: const [
                //     "Account",
                //     "Additional Info",
                //     "Summary",
                //   ],
                // ),
                LiquidStepper(
                  steps: [
                    LiquidStep(
                      title: 'Account', 
                      content: getStepOne()
                    ),
                    LiquidStep(
                      title: 'Additional Info', 
                      content: getStepTwo()
                    ),
                    LiquidStep(
                      title: 'Summary', 
                      content: getLastStep()
                    ),
                  ],
                ),
                // const SizedBox(height: 40),
                // Expanded(
                //   child: _buildStep(currentStep),
                // ),
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     if (currentStep == 0)
                //       Expanded(
                //         child: ElevatedButton(
                //           onPressed: () {
                //             setState(() {
                //               currentStep += 1;
                //             });
                //           },
                //           style: ButtonStyle(
                //             backgroundColor:
                //                 MaterialStateProperty.all<Color>(Colors.pink),
                //           ),
                //           child: const Text(
                //             'Next',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //     if (currentStep == 1)
                //       ElevatedButton(
                //         onPressed: () {
                //           setState(() {
                //             currentStep -= 1;
                //           });
                //         },
                //         child: const Row(
                //           children: [
                //             Icon(Icons.arrow_back_ios, color: Colors.pink, size: 15),
                //             Text('Back',
                //                 style: TextStyle(
                //                     color: Colors.pink,
                //                     fontWeight: FontWeight.bold)),
                //           ],
                //         ),
                //       ),
                //     if (currentStep == 1)
                //       ElevatedButton(
                //         onPressed: () {
                //           if (currentStep < 2) {
                //             setState(() {
                //               currentStep += 1;
                //             });
                //           } else {
                //             // Handle form submission
                //             // For demonstration purposes, just print the information
                //             print('Email: ${emailController.text}');
                //             print(
                //                 'Additional Info: ${additionalInfoController.text}');
                //           }
                //         },
                //         style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all<Color>(Colors.pink),
                //         ),
                //         child: const Row(
                //           children: [
                //             Text(
                //               'Next',
                //               style: TextStyle(
                //                   color: Colors.white, fontWeight: FontWeight.bold),
                //             ),
                //             Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
                //           ],
                //         ),
                //       ),
                //     if (currentStep == 2)
                //       ElevatedButton(
                //         onPressed: () {
                //           setState(() {
                //             currentStep -= 1;
                //           });
                //         },
                //         child: const Row(
                //           children: [
                //             Icon(Icons.arrow_back_ios, color: Colors.pink, size: 15),
                //             Text('Back',
                //                 style: TextStyle(
                //                     color: Colors.pink,
                //                     fontWeight: FontWeight.bold)),
                //           ],
                //         ),
                //       ),
                //     if (currentStep == 2)
                //       ElevatedButton(
                //         onPressed: () {
                //           if (currentStep < 2) {
                //             setState(() {
                //               currentStep += 1;
                //             });
                //           } else {
                //             // Handle form submission
                //             // For demonstration purposes, just print the information
                //             print('Email: ${emailController.text}');
                //             print(
                //                 'Additional Info: ${additionalInfoController.text}');
                //           }
                //         },
                //         style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all<Color>(Colors.pink),
                //         ),
                //         child: const Text(
                //           'Submit',
                //           style: TextStyle(
                //               color: Colors.white, fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //   ],
                // ),
              ],
            ),
            )
            ,
          ),
        ],
      ),
    );
  }

  Widget getStepOne(){
    return SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                setState(() {
                  passwordValue = value;
                });
              },
              obscureText: true,
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
            const SizedBox(height: 10),
            PasswordCheckerWidget(
              password: passwordValue,
              minimumCharacters: 12,
              requireUppercase: true,
              requireLowercase: true,
              requireNumber: true,
              requireSpecialChar: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              onChanged: (value) {
                setState(() {
                  cfpasswordValue = value;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
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
            const SizedBox(height: 10),
            PasswordCheckerWidget(
              password: cfpasswordValue,
              minimumCharacters: 12,
              requireUppercase: true,
              requireLowercase: true,
              requireNumber: true,
              requireSpecialChar: true,
            ),
          ],
        ),
        );
  }

  Widget getStepTwo(){
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: additionalInfoController,
              decoration: const InputDecoration(
                labelText: 'Additional Info',
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
          ],
        );
  }


  Widget getLastStep(){
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Email: ${emailController.text}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Additional Info: ${additionalInfoController.text}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                setState(() {
                  passwordValue = value;
                });
              },
              obscureText: true,
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
            const SizedBox(height: 10),
            PasswordCheckerWidget(
              password: passwordValue,
              minimumCharacters: 12,
              requireUppercase: true,
              requireLowercase: true,
              requireNumber: true,
              requireSpecialChar: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              onChanged: (value) {
                setState(() {
                  cfpasswordValue = value;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
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
            const SizedBox(height: 10),
            PasswordCheckerWidget(
              password: cfpasswordValue,
              minimumCharacters: 12,
              requireUppercase: true,
              requireLowercase: true,
              requireNumber: true,
              requireSpecialChar: true,
            ),
          ],
        ),
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: additionalInfoController,
              decoration: const InputDecoration(
                labelText: 'Additional Info',
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
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Email: ${emailController.text}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Additional Info: ${additionalInfoController.text}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        );
      default:
        return Container();
    }
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
