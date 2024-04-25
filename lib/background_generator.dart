// ignore_for_file: use_build_context_synchronously, avoid_print, duplicate_ignore, null_check_always_fails, unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';


class ExportableContent extends StatelessWidget {
  final Color backgroundColor;
  final double opacity;

  const ExportableContent({
    required this.backgroundColor,
    required this.opacity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(opacity),
      ),
    );
  }
}




class BackgroundGeneratorScreen extends StatefulWidget {
  const BackgroundGeneratorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BackgroundGeneratorScreen> {
  Color _currentColor = Colors.blue;
  double _currentOpacity = 0.5;
  GlobalKey globalKey = GlobalKey();

  List<String> savedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _exportImage(),
          ),
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () => _navigateToSavedImages(),
          ),
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: ExportableContent(
            backgroundColor: _currentColor,
            opacity: _currentOpacity,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _pickColor(),
            child: const Icon(Icons.color_lens),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _showOpacitySlider(),
            child: const Icon(Icons.opacity),
          ),
        ],
      ),
    );
  }

  Future<void> _pickColor() async {
    Color pickedColor = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) {
                setState(() {
                  _currentColor = color;
                });
              },
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              // ignore: deprecated_member_use
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2.0),
                topRight: Radius.circular(2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_currentColor);
              },
            ),
          ],
        );
      },
    );

    // ignore: unnecessary_null_comparison
    if (pickedColor != null) {
      setState(() {
        _currentColor = pickedColor;
      });
    }
  }

  void _showOpacitySlider() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adjust Opacity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$_currentOpacity'),
              Slider(
                value: _currentOpacity,
                onChanged: (value) {
                  setState(() {
                    _currentOpacity = value;
                  });
                },
                min: 0.1,
                max: 1.0,
                divisions: 10,
                label: '$_currentOpacity',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
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

  
  

  Future<void> _exportImage() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = 'wallpaper_image_${DateTime.now().millisecondsSinceEpoch}.png';
      String filePath = '$directory/$fileName';

      File file = File(filePath);
      await file.writeAsBytes(pngBytes);

      setState(() {
        savedImages.add(fileName);
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(
        //   content: Text('Image saved to $filePath', style: TextStyle(color: Colors.black),),
        //   backgroundColor: Colors.greenAccent,
        // ),
        const SnackBar(
          content: Text(
            'Wallpaper successfully saved!',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.greenAccent,
        ),
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void _navigateToSavedImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedImagesScreen(savedImages),
      ),
    );
  }
}

class SavedImagesScreen extends StatefulWidget {
  final List<String> savedImages;

  const SavedImagesScreen(this.savedImages, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SavedImagesScreenState createState() => _SavedImagesScreenState();
}

class _SavedImagesScreenState extends State<SavedImagesScreen> {
  late Future<String> _directoryFuture;

  @override
  void initState() {
    super.initState();
    _directoryFuture = getApplicationDocumentsDirectory().then((directory) {
      return directory.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved wallpapers'),
      ),
      body: FutureBuilder<String>(
        future: _directoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              if (widget.savedImages.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: widget.savedImages.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () => _viewImage(
                            widget.savedImages[index], snapshot.data!, context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.file(
                                File(
                                    '${snapshot.data}/${widget.savedImages[index]}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.savedImages[index],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  widget.savedImages.removeAt(index);
                                });
                              }, 
                              icon: const Icon(Icons.delete)
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              if (widget.savedImages.isEmpty) {
                return const Center(
                  child: Text('No saved wallpapers yet!'),
                );
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _viewImage(String fileName, String directory, BuildContext context) {
    String filePath = '$directory/$fileName';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageScreen(filePath),
      ),
    );
  }
}



class ImageScreen extends StatefulWidget {
  final String imagePath;

  const ImageScreen(this.imagePath, {Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper view'),
      ),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              points.add(renderBox.globalToLocal(details.globalPosition));
            });
          },
          onPanEnd: (details) {
            points.add(null!);
          },
          onPanDown: (details) {
            points.add(null!);
          },
          child: CustomPaint(
            painter: MyPainter(points),
            child: Image.file(File(widget.imagePath)),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Offset> points;
  final Paint paintt;

   MyPainter(this.points) : paintt = Paint()
    ..color = Colors.white 
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paintt);
      } else if (points[i] != null && points[i + 1] == null) {
        // Draw dots for single point (when user stops drawing)
        canvas.drawPoints(ui.PointMode.points, [points[i]], paintt);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
