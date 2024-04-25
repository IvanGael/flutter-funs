import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/services.dart';

class PaletteGenerateScreen extends StatefulWidget {
  const PaletteGenerateScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaletteGenerateScreenState createState() => _PaletteGenerateScreenState();
}

class _PaletteGenerateScreenState extends State<PaletteGenerateScreen> {
  List<PaletteData> colorPalettes = [];

  @override
  void initState() {
    super.initState();
    generateColorPalettes();
  }

  void generateColorPalettes() {
    // Generate 5 color palettes with random number of colors
    for (int i = 0; i < 5; i++) {
      int numberOfColors = 4 + i; // Starting with 4 colors and increasing
      List<Color> palette = generateRandomPalette(numberOfColors);
      String paletteName = '${i + 1}';
      colorPalettes.add(PaletteData(name: paletteName, colors: palette));
    }
  }

  List<Color> generateRandomPalette(int numberOfColors) {
    return List.generate(
      numberOfColors,
      (index) => Colors.primaries[index % Colors.primaries.length],
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  void changeColor(BuildContext context, Color currentColor,
      Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              // ignore: deprecated_member_use
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palettes'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Regenerate color palettes on button press
                colorPalettes.clear();
                generateColorPalettes();
              });
            },
            child: const Icon(Icons.autorenew, color: Colors.white,),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (PaletteData palette in colorPalettes)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          palette.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (Color color in palette.colors)
                              GestureDetector(
                                onTap: () {
                                  copyToClipboard(color.toString());
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            changeColor(
                              context,
                              Colors.blue, // Default color
                              (Color color) {
                                // Handle the selected color
                                setState(() {
                                  palette.colors.add(color);
                                });
                              },
                            );
                          },
                          child: const Text('Add Color'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }
}

class PaletteData {
  final String name;
  final List<Color> colors;

  PaletteData({required this.name, required this.colors});
}
