// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, use_build_context_synchronously, avoid_print

import 'dart:ui';
import 'dart:typed_data';

import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class GradientBackgroundGeneratorScreen extends StatefulWidget {
  const GradientBackgroundGeneratorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<GradientBackgroundGeneratorScreen> {
  Image? _wallpaperImage;
  late List<Color> _gradientColors;
  AlignmentGeometry _gradientBegin = Alignment.topLeft;
  AlignmentGeometry _gradientEnd = Alignment.bottomRight;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    _gradientColors = [Colors.blue, Colors.orange];
    // _generateGradientWallpaper();
  }

  Future<void> _generateGradientWallpaper() async {
    final Gradient gradient = LinearGradient(
      colors: _gradientColors,
      begin: _gradientBegin,
      end: _gradientEnd,
    );

    final image = await _generateImage(gradient);
    setState(() {
      imageBytes = image;
    });
    setState(() {
      _wallpaperImage = Image.memory(image);
    });
  }

  Future<Uint8List> _generateImage(Gradient gradient) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final rect = Rect.fromPoints(const Offset(0.0, 0.0), const Offset(300.0, 300.0));

    // Draw gradient
    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect);
    canvas.drawRect(rect, gradientPaint);

    // Draw picked image at the center
    if (pickedImage != null) {
      final pickedImageFile = await pickedImage.readAsBytes();
      final pickedImageCodec = await instantiateImageCodec(pickedImageFile);
      final pickedImageFrame = await pickedImageCodec.getNextFrame();

      final imageRect = Rect.fromCenter(
        center: rect.center,
        width: 230.0,
        height: 230.0,
      );

      canvas.drawImageRect(
        pickedImageFrame.image,
        pickedImageFrame.image.getBoundingRect(),
        imageRect,
        Paint(),
      );
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(300, 300);
    final byteData = await img.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

   Future<void> _saveImage() async {
    try {
      // final imageBytes = await _generateImage(
      //   LinearGradient(colors: _gradientColors, begin: _gradientBegin, end: _gradientEnd),
      // );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(imageBytes!),
        quality: 80,
        name: 'generated_wallpaper',
      );

      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),), 
            backgroundColor: Colors.greenAccent,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save image')),
        );
      }
    } on PlatformException catch (error) {
      print('Error saving image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error saving image')),
      );
    }
  }

  void _openColorPicker(int index) {
    Color selectedColor = _gradientColors[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Gradient Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _gradientColors[index] = color;
                });
              },
              enableAlpha: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorPicker(int index) {
    return GestureDetector(
      onTap: () {
        _openColorPicker(index);
      },
      child: Container(
        width: 50,
        height: 50,
        color: _gradientColors[index],
      ),
    );
  }

  void _openAlignmentPicker(String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$label Alignment"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _gradientBegin == Alignment.topLeft
                          ? _gradientBegin = Alignment.topRight
                          : _gradientBegin = Alignment.topLeft;
                    });
                  },
                  child: Text(_gradientBegin.toString()),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _gradientEnd == Alignment.bottomRight
                          ? _gradientEnd = Alignment.bottomLeft
                          : _gradientEnd = Alignment.bottomRight;
                    });
                  },
                  child: Text(_gradientEnd.toString()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAlignmentPicker(String label, AlignmentGeometry alignment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("$label Alignment", textAlign: TextAlign.center,),
        ElevatedButton(
          onPressed: () {
            _openAlignmentPicker(label);
          },
          child: Text(alignment.toString()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Wallpaper Generator', style: TextStyle(fontSize: 16),),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: _generateGradientWallpaper,
          ),
          IconButton(
            onPressed: _saveImage, 
            icon: const Icon(Icons.save)
          )
        ],
      ),
      body: Center(
        child: _wallpaperImage != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  _wallpaperImage!,
                  const SizedBox(
                    height: 20,
                  ),
                  // Color pickers for the gradient
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorPicker(0),
                      _buildColorPicker(1),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                    ],
                  ),
                  // Alignment pickers for the gradient
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAlignmentPicker("Begin", _gradientBegin),
                      _buildAlignmentPicker("End", _gradientEnd),
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                    ],
                  ),
                ],
              )
            : const Center(child: Text("Start by uploading an image"),),
      ),
    );
  }
}