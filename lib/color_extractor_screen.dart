import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorExtractorScreen extends StatefulWidget {
  const ColorExtractorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorExtractorScreenState createState() => _ColorExtractorScreenState();
}

class _ColorExtractorScreenState extends State<ColorExtractorScreen> {
  PaletteGenerator? _paletteGenerator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Extractor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _loadPalette,
              child: const Text('Load Image and Extract Colors'),
            ),
            const SizedBox(height: 20),
            _paletteGenerator != null
                ? Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: _paletteGenerator!.dominantColor?.color,
                      ),
                      const SizedBox(height: 10),
                      const Text('Dominant Color'),
                      const SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 100,
                        color: _paletteGenerator!.lightVibrantColor?.color,
                      ),
                      const SizedBox(height: 10),
                      const Text('Light Vibrant Color'),
                      const SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 100,
                        color: _paletteGenerator!.darkVibrantColor?.color,
                      ),
                      const SizedBox(height: 10),
                      const Text('Dark Vibrant Color'),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> _loadPalette() async {
    const imageProvider = AssetImage('assets/db_bg2.jpg');

    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);

    setState(() {
      _paletteGenerator = paletteGenerator;
    });
  }
}