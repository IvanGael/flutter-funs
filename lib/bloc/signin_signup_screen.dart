import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AuthBloc extends Cubit<bool> {
  AuthBloc() : super(false);

  void toggleAuthMode() => emit(!state);
}

class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomTab({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class SignInSignUpScreen extends StatelessWidget {
  const SignInSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Switch Tabbed Signin-Signup'),
      ),
      body: BlocBuilder<AuthBloc, bool>(
        builder: (context, isSignInMode) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: DefaultTextStyle(
              //     style: const TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     child: AnimatedTextKit(
              //       animatedTexts: [
              //         TypewriterAnimatedText('Sign In'),
              //         TypewriterAnimatedText('Sign Up'),
              //       ],
              //       isRepeatingAnimation: true,
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.blue, width: 3)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTab(
                      text: 'Sign In',
                      isSelected: isSignInMode,
                      onPressed: () {
                        context.read<AuthBloc>().toggleAuthMode();
                      },
                    ),
                    const SizedBox(width: 20),
                    CustomTab(
                      text: 'Sign Up',
                      isSelected: !isSignInMode,
                      onPressed: () {
                        context.read<AuthBloc>().toggleAuthMode();
                      },
                    ),
                  ],
                ),
              ),
              if (isSignInMode)
                const SignInForm()
              else
                const SignUpForm(),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().toggleAuthMode();
                },
                child: Text(
                  isSignInMode ? 'Don\'t have an account? Sign Up' : 'Already have an account? Sign In',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement your sign in form here
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text('Sign In Form'),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement your sign up form here
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text('Sign Up Form'),
    );
  }
}