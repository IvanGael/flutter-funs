import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkModeValue = false;
  bool enableSoundValue = false;
  double volumeValue = 0.5;
  bool enableNotificationsValue = false;
  bool showPreviewValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Appearance'),
            _buildAppearanceSettings(),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Sound'),
            _buildSoundSettings(),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Notifications'),
            _buildNotificationSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return Column(
      children: [
        _buildSwitchTile('Dark Mode', darkModeValue),
      ],
    );
  }

  Widget _buildSoundSettings() {
    return Column(
      children: [
        _buildSwitchTile('Enable Sound', enableSoundValue),
        _buildVolumeSlider(),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return Column(
      children: [
        _buildSwitchTile('Enable Notifications', enableNotificationsValue),
        _buildSwitchTile('Show Preview', showPreviewValue),
      ],
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (bool newValue) {
          if(title == 'Dark Mode'){
            setState(() {
              darkModeValue = newValue;
            });
          } else if(title == 'Enable Sound'){
            setState(() {
              enableSoundValue = newValue;
            });
          } else if(title == 'Enable Notifications'){
            setState(() {
              enableNotificationsValue = newValue;
            });
          } else if(title == 'Show Preview'){
            setState(() {
              showPreviewValue = newValue;
            });
          }
        },
      ),
    );
  }

  Widget _buildVolumeSlider() {
    return ListTile(
      title: const Text('Volume'),
      trailing: SizedBox(
        width: 200.0,
        child: Slider(
          value: volumeValue,
          onChanged: (double newValue) {
            setState(() {
              volumeValue = newValue;
            });
          },
        ),
      ),
    );
  }
}
