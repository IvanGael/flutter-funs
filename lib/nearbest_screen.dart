import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearbestScreen extends StatefulWidget {
  const NearbestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NearbestScreenState createState() => _NearbestScreenState();
}

class _NearbestScreenState extends State<NearbestScreen> {
  late TextEditingController textController;
  late ImagePicker _imagePicker;
  LatLng? currentLocation;
  late double transmissionRadius;
  late int transmissionDuration;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _imagePicker = ImagePicker();
    transmissionRadius = 1.0; // Initialize with a default value
    // Get the user's current location
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the picked image
    }
  }

  void _submitInformation() {
    // Implement logic to submit information to the server
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NearBest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            FutureBuilder<void>(
              future: _getCurrentLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'Location: ${currentLocation?.latitude ?? ''}, ${currentLocation?.longitude ?? ''}',
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 10),
            Slider(
              value: transmissionRadius,
              onChanged: (value) {
                setState(() {
                  transmissionRadius = value;
                });
              },
              label: 'Transmission Radius: $transmissionRadius km',
              min: 1,
              max: 100,
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  transmissionDuration = int.parse(value);
                });
              },
              decoration:
                  const InputDecoration(labelText: 'Transmission Duration'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitInformation,
              child: const Text('Submit Information'),
            ),
          ],
        ),
      ),
    );
  }
}
