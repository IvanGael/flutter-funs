
import 'package:flutter/material.dart';

class BotChatScreen extends StatefulWidget {
  const BotChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<BotChatScreen> {
  final List<Message> _messages = [];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bot Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageWidget(message: _messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          Message(
            text: _messageController.text,
            sender: 'User',
            timestamp: DateTime.now(),
          ),
        );
        // Simulating a bot response after a delay
        Future.delayed(const Duration(seconds: 1), () {
          _messages.add(
            Message(
              text: 'Hello! How can i help you today ?',
              sender: 'Bot',
              timestamp: DateTime.now(),
            ),
          );
          setState(() {
            
          });
          _messageController.clear();
        });
      });
    }
  }
}

class Message {
  final String text;
  final String sender;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: message.sender == 'User'
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (message.sender == 'Bot')
            const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('B'),
            ),
          const SizedBox(width: 8.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: message.sender == 'Bot'
                  ? Colors.blue[100]
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: message.sender == 'Bot'
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(message.text, style: const TextStyle(color: Colors.black),),
                const SizedBox(height: 4.0),
                Text('${message.timestamp.hour}:${message.timestamp.minute}', style: const TextStyle(color: Colors.black),),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          if (message.sender == 'User')
            const CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Text('U'),
            ),
        ],
      ),
    );
  }
}