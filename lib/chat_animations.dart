import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';


class Message {
  final String text;
  final bool isMe;

  Message(this.text, this.isMe);
}

class ChatModel extends ChangeNotifier {
  List<Message> messages = [];

  void addMessage(Message message) {
    messages.add(message);
    notifyListeners();
  }
}



class ChatAnimationScreen extends StatelessWidget {
  const ChatAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: MessageList(),
          ),
          InputSection(),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatModel>(
      builder: (context, chatModel, child) {
        return ListView.builder(
          itemCount: chatModel.messages.length,
          reverse: true,
          itemBuilder: (context, index) {
            final message = chatModel.messages[index];
            return MessageBubble(message: message);
          },
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          OpenContainer(
            closedBuilder: (context, _) {
              return Bubble(
                message: message,
              );
            },
            openBuilder: (context, _) {
              return MessageDetail(message: message);
            },
            closedColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final Message message;

  const Bubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: message.isMe ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        message.text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class MessageDetail extends StatelessWidget {
  final Message message;

  const MessageDetail({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Detail'),
      ),
      body: Center(
        child: Text(message.text),
      ),
    );
  }
}

class InputSection extends StatelessWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Type a message...',
              ),
              onSubmitted: (text) {
                final chatModel = Provider.of<ChatModel>(context, listen: false);
                chatModel.addMessage(Message(text, true));
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final chatModel = Provider.of<ChatModel>(context, listen: false);
              chatModel.addMessage(Message('Your message here', false));
            },
          ),
        ],
      ),
    );
  }
}