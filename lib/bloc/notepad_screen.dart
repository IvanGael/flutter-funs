
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NotepadEvent { openFile, saveFile, newTab, undo, find, replace }

class NotepadBloc extends Bloc<NotepadEvent, String> {
  NotepadBloc() : super('');

  Stream<String> mapEventToState(NotepadEvent event) async* {
    // Handle different events and update the state accordingly
    switch (event) {
      case NotepadEvent.newTab:
        yield ''; // Implement your logic for new tab
        break;
      // Handle other events similarly
      case NotepadEvent.openFile:
        // TODO: Handle this case.
      case NotepadEvent.saveFile:
        // TODO: Handle this case.
      case NotepadEvent.undo:
        // TODO: Handle this case.
      case NotepadEvent.find:
        // TODO: Handle this case.
      case NotepadEvent.replace:
        // TODO: Handle this case.
    }
  }
}

class NotepadScreen extends StatelessWidget {
  const NotepadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notepad'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              BlocProvider.of<NotepadBloc>(context).add(NotepadEvent.newTab);
            },
          ),
        ],
      ),
      body: BlocBuilder<NotepadBloc, String>(
        builder: (context, state) {
          return const Center(
            child: Text(
              'Content of the current tab will be displayed here.',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('New Tab'),
              onTap: () {
                BlocProvider.of<NotepadBloc>(context).add(NotepadEvent.newTab);
                Navigator.pop(context);
              },
            ),
            // Add more drawer items for other functionalities
          ],
        ),
      ),
    );
  }
}