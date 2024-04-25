import 'package:flutter/material.dart';
import 'package:args/args.dart';

class CLIScreen extends StatefulWidget {
  const CLIScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CLIScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  String _outputText = '';

  void _runCLI(String input) {
    final ArgParser argParser = ArgParser()
      ..addFlag('help', abbr: 'h', negatable: false, help: 'Prints usage information.')
      ..addOption('name', abbr: 'n', help: 'Specifies the name for the CLI app.');

    List<String> args = input.split(' ');

    ArgResults argResults;
    try {
      argResults = argParser.parse(args);
    } catch (e) {
      _updateOutput('Error parsing arguments: $e');
      return;
    }

    if (argResults['help'] || args.isEmpty) {
      _updateOutput(argParser.usage);
      return;
    }

    final String name = argResults['name'] ?? 'User';
    _updateOutput('Hello, $name! Welcome to your CLI app.');
  }

  void _updateOutput(String text) {
    setState(() {
      _outputText = text;
    });
  }

  @override
  void initState() {
    super.initState();
    _textFieldController.text = "Help";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter CLI App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(labelText: 'Enter CLI command'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _runCLI(_textFieldController.text);
              },
              child: const Text('Run CLI'),
            ),
            const SizedBox(height: 16.0),
            Text(_outputText),
          ],
        ),
      ),
    );
  }
}