import 'dart:math';
import 'package:flutter/material.dart';

class TeamGeneratorScreen extends StatefulWidget {
  const TeamGeneratorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TeamGeneratorScreenState createState() => _TeamGeneratorScreenState();
}

class _TeamGeneratorScreenState extends State<TeamGeneratorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _teamController = TextEditingController();
  final List<String> _names = [];
  final List<List<String>> _teams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 2),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Enter a name'),
                    )
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: _addNameToList,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.greenAccent)
                      ),
                      child: const Icon(Icons.add, color: Colors.black,),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _teamController,
                  decoration: const InputDecoration(labelText: 'Number of teams'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _generateTeams,
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.greenAccent)
                      ),
                  child: const Text(
                    'Generate Teams',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          if(_teams.isNotEmpty)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 2),
              borderRadius: BorderRadius.circular(14)
            ),
              child: ListView.builder(
                itemCount: _teams.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showTeamMembers(index),
                    child: ListTile(
                      title: Text('Team ${index + 1}'),
                      subtitle: Text('${_teams[index].length} members'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _addNameToList() {
    setState(() {
      if (_nameController.text.isNotEmpty) {
        _names.add(_nameController.text);
        _nameController.clear();
      }
    });
  }

  void _generateTeams() {
    setState(() {
      _teams.clear();
      final numTeams = int.tryParse(_teamController.text) ?? 1;
      if (numTeams <= 0) return;

      _names.shuffle();
      final namesPerTeam = (_names.length / numTeams).ceil();

      for (var i = 0; i < numTeams; i++) {
        final start = i * namesPerTeam;
        final end = min((i + 1) * namesPerTeam, _names.length);
        _teams.add(_names.sublist(start, end));
      }
    });
  }

  void _showTeamMembers(int teamIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Team ${teamIndex + 1} Members'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _teams[teamIndex].map((name) => Text(name)).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
