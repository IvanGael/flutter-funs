
import 'package:flutter/material.dart';

class GmailScreen extends StatefulWidget {
  const GmailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GmailScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gmail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.indigo[400],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Received',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Followed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drafts),
            label: 'Drafts',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle compose email action
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        // Received messages
        return _buildEmailList('Received');
      case 1:
        // Followed messages
        return _buildEmailList('Followed');
      case 2:
        // Pending messages
        return _buildEmailList('Pending');
      case 3:
        // Drafts
        return _buildEmailList('Drafts');
      default:
        return Container(); // Should not reach here
    }
  }

  Widget _buildEmailList(String category) {
    return ListView.builder(
      itemCount: 20, 
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Text('A'), 
          ),
          title: const Text('Sender Name'),
          subtitle: const Text('Subject of the email'),
          trailing: const Text('12:30 PM'), 
          onTap: () {
            // Handle email item tap
          },
        );
      },
    );
  }
}