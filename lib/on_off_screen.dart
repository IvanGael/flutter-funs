
import 'package:flutter/material.dart';

class OnOffSwitchScreen extends StatefulWidget {
  const OnOffSwitchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnOffSwitchScreenState createState() => _OnOffSwitchScreenState();
}

class _OnOffSwitchScreenState extends State<OnOffSwitchScreen> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On/Off Switch'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSwitch(),
              const SizedBox(height: 24.0),
              _buildStatusMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return Container(
      width: 120.0,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: _isSwitched ? Colors.greenAccent : Colors.grey[400],
      ),
      child: Stack(
        children: [
          Positioned(
            left: _isSwitched ? 60.0 : 0.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSwitched = !_isSwitched;
                });
              },
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 3),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMessage() {
    return Text(
      _isSwitched ? 'Device is ON' : 'Device is OFF',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: _isSwitched ? Colors.greenAccent : Colors.grey,
      ),
    );
  }
}