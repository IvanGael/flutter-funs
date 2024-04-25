import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';


class SignInScreen3 extends StatefulWidget {
  const SignInScreen3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen3> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isSignInScreenVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _toggleSignInScreen() {
    setState(() {
      isSignInScreenVisible = !isSignInScreenVisible;
      if (isSignInScreenVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: Stack(
        children: [
          // Your main content goes here

          // Sign In Screen
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.translationValues(
              0.0,
              isSignInScreenVisible ? MediaQuery.of(context).size.height * 0.7 : 0.0,
              0.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: SignInForm(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSignInScreen,
        child: const Icon(Icons.toc),
      ),
    );
  }
}


class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.black),
          ),
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20.0),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black),
          ),
          obscureText: true,
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implement sign-in logic
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}