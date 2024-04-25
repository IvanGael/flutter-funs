import 'package:flutter/material.dart';


class CaptivePortalScreen extends StatefulWidget {
  const CaptivePortalScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CaptivePortalScreenState createState() => _CaptivePortalScreenState();
}

class _CaptivePortalScreenState extends State<CaptivePortalScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intranet Portal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bank1.jpg', 
              height: 100,
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24.0),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: const Text('Connect to Intranet'),
                  ),
            const SizedBox(height: 16.0),
            if (_error)
              const Text(
                'Invalid credentials. Please try again.',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    // Simulate authentication delay
    setState(() {
      _loading = true;
      _error = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    // Simulate authentication success
    if (_usernameController.text == 'user' && _passwordController.text == 'password') {
      // Navigate to the next screen or perform necessary actions on authentication success
      // For now, let's just print a message.
      print('Intranet connection successful!');
    } else {
      // Authentication failed
      setState(() {
        _error = true;
      });
    }

    // Reset loading state
    setState(() {
      _loading = false;
    });
  }
}
