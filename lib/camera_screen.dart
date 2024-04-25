import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  String? imagePath;

  getCameras() async {
    availableCameras().then((value) => cameras = value).whenComplete(() => {
          controller = CameraController(cameras[0], ResolutionPreset.high),
          controller.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onCapturePressed() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';

    // Ensure the directory exists
    await Directory(dirPath).create(recursive: true);

    final String filePath = '$dirPath/${DateTime.now().toString()}.png';

    try {
      final XFile picture = await controller.takePicture();
      await File(picture.path).copy(filePath);

      setState(() {
        imagePath = filePath;
      });

      // Save the image to the local database (Hive)
      _saveToDatabase(imagePath!);
    } catch (e) {
      print(e);
    }
  }

  void _saveToDatabase(String imagePath) async {
    // Read the image
    final File imageFile = File(imagePath);
    final List<int> imageBytes = await imageFile.readAsBytes();
    final img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // Apply filters (you can implement multiple filters)
    // Example: grayscale filter
    final img.Image filteredImage = img.grayscale(image);

    // Save the filtered image to the database
    final Box<dynamic> photosBox = Hive.box('photos');
    photosBox.add(filteredImage.getBytes());

    // Display the saved image
    // ignore: use_build_context_synchronously
  //   showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       content: Image.file(File(imagePath)),
  //     );
  //   },
  // );
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Deluxe'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 400,
            child: CameraPreview(
              controller,
            ),
          ),
          const SizedBox(height: 30,),
          if(imagePath != null)
          SizedBox(
            width: 200,
            height: 100,
            child: Image.file(File(imagePath!)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: _onCapturePressed,
              ),
              if(imagePath != null)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: (){
                  setState(() {
                    imagePath = null;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
