import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class AllDeviceInfosScreen extends StatefulWidget {
  const AllDeviceInfosScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllDeviceInfosScreenState createState() => _AllDeviceInfosScreenState();
}

class _AllDeviceInfosScreenState extends State<AllDeviceInfosScreen> {
  Map<String, dynamic> deviceInfo = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceInfo = {
            'Model': iosInfo.model,
            'System Version': iosInfo.systemVersion
          };
        });
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceInfo = {
            'Brand': androidInfo.brand,
            'Model': androidInfo.model,
            'Android Version': androidInfo.version.release,
            'Manufacturer': androidInfo.manufacturer,
            'IsPhysicalDevice': androidInfo.isPhysicalDevice
          };
        });
      }
    } catch (e) {
      // print('Error getting device info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Device Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: deviceInfo.length,
                itemBuilder: (context, index) {
                  String key = deviceInfo.keys.elementAt(index);
                  dynamic value = deviceInfo[key];
                  return ListTile(
                    title: Text(
                      key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(value.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}