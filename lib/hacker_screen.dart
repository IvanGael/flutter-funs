import 'package:flutter/material.dart';

class HackerScreen extends StatefulWidget {
  const HackerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HackerScreenState createState() => _HackerScreenState();
}

class _HackerScreenState extends State<HackerScreen> {
  final TextEditingController _controller = TextEditingController();
  String originalInput = ""; // Store the original user input
  String fakeCode = ""; // Store the fake code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
                decoration: const InputDecoration(
                  hintText: "Start typing to simulate hacking...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                maxLines: 10,

                onChanged: (text) {
                  // Handle user input
                },
                onEditingComplete: (){
                  setState(() {
                    generateFakeCode(_controller.text);
                  });
                },
                onTapOutside: (event){
                  setState(() {
                    generateFakeCode(_controller.text);
                  });
                },
                onSubmitted: (text) {
                  setState(() {
                    generateFakeCode(text);
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void generateFakeCode(String userInput) async{
    // Clear previous fake code
    fakeCode = "";

    // For each character in the user input, add a line of fake code
    for (int i = 0; i < userInput.length; i++) {
      fakeCode += generatePythonCode(userInput[i]) +
          generateJavaCode(userInput[i]) +
          generateJavaScriptCode(userInput[i]) +
          generateDartCode(userInput[i]);
    }

    _animateFakeCode();
  }

  void _animateFakeCode() async {
    for (int i = 0; i < fakeCode.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _controller.text =
            fakeCode.substring(0, i + 1).replaceAll(RegExp(r'.'), '•');
      });
    }
  }

  String generatePythonCode(String userInput) {
    return """
print('Hacking in progress...')
# Using user input: $userInput
# Insert your Python hacking logic here""";
  }

  String generateJavaCode(String userInput) {
    return """
public class Hacker {
  public static void main(String[] args) {
    System.out.println("Hacking in progress...");
    // Using user input: $userInput
    // Insert your Java hacking logic here
  }
}""";
  }

  String generateJavaScriptCode(String userInput) {
    return """
console.log('Hacking in progress...');
// Using user input: $userInput
// Insert your JavaScript hacking logic here""";
  }

  String generateDartCode(String userInput) {
    return """
void main() {
  print('Hacking in progress...');
  // Using user input: $userInput
  // Insert your Dart hacking logic here
}""";
  }
}
