import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ChatScreenWithImagesScreenShow extends StatelessWidget {
  const ChatScreenWithImagesScreenShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatScreenWithImages(),
    );
  }
}

class ChatScreenWithImages extends StatefulWidget {
  const ChatScreenWithImages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenWithImages> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () => _handleImage(ImageSource.gallery),
            ),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _textController.text.isNotEmpty ? _handleSubmitted(_textController.text) : null,
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      ChatMessage message = ChatMessage(
        imageUrl: File(pickedFile.path),
      );

      setState(() {
        _messages.insert(0, message);
      });
    }
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final File? imageUrl;

  const ChatMessage({super.key, this.text, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const CircleAvatar(
              child: Text('User'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (text != null)
                  Text(
                    text!,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                if (imageUrl != null)
                  Image.file(
                    imageUrl!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
