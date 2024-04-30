import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMe;

  Message(this.text, this.isMe);
}

class CharacterChattingScreen extends StatefulWidget {
  const CharacterChattingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CharacterChatScreenState createState() => _CharacterChatScreenState();
}

class _CharacterChatScreenState extends State<CharacterChattingScreen> {
  final List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();
  bool _stopChatSimulation = false;

  @override
  void initState() {
    super.initState();
    // Start simulating chat when the screen is loaded
    _simulateChat();
  }

  // Simulate a chat between the two characters
  void _simulateChat() async {
    await Future.delayed(const Duration(seconds: 1)); // Initial delay

    while (mounted) {
      // Character 1 speaks
      _addMessage(Message("Un! Kore mo ii desu ne!", true));
      await Future.delayed(const Duration(seconds: 4));

      // Character 2 responds
      _addMessage(Message("Okaasan wa ryouri no sensei desu.", false));
      await Future.delayed(const Duration(seconds: 4));

      // Character 1 speaks
      _addMessage(Message("Arigatou Arekkusu. Ureshii wa.", true));
      await Future.delayed(const Duration(seconds: 4));


      // Character 2 responds
      _addMessage(Message("Naruhodo!", false));
      await Future.delayed(const Duration(seconds: 10));

      setState(() {
        _stopChatSimulation = true;
      });

      // if(_stopChatSimulation == true) break;

      // Continue the conversation as needed...

      // To stop the chat simulation, you can add a condition here
      // For example, if (_stopChatSimulation) break;

      // Note: This is a simple simulation, and you may need to adjust the timing
      // and messages according to your desired chat flow.
    }
  }

  void _addMessage(Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: message.isMe ? Colors.transparent : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets/cloud.png',
                  width: 150.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
                Transform.translate(
                  offset: const Offset(40, 10),
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 80,
                    child: Text(
                      message.text,
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 12
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('トチャット', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Character 1
                Positioned(
                  left: 20.0,
                  bottom: 40.0,
                  child: Image.asset(
                    'assets/character1.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                // Character 2
                Positioned(
                  right: 20.0,
                  bottom: 40.0,
                  child: Image.asset(
                    'assets/character2.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                // Chat Messages
                Positioned.fill(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(messages[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          // const Divider(height: 1.0,),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).cardColor,
          //   ),
          //   child: _buildTextComposer(),
          // ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.primary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
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
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _addMessage(Message(text, true));
  }

  @override
  void dispose() {
    // Cleanup when the screen is disposed
    _textController.dispose();
    super.dispose();
  }
}
