import 'package:flutter/material.dart';

class CustomRichTextEditorScreen extends StatefulWidget {
  const CustomRichTextEditorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomRichTextEditorState createState() => _CustomRichTextEditorState();
}

class _CustomRichTextEditorState extends State<CustomRichTextEditorScreen> {
  final TextEditingController _controller = TextEditingController();

  // Default text style
  TextStyle _currentTextStyle =
      const TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Roboto');

  // Available options for font sizes
  final List<double> fontSizes = [12, 14, 16, 18, 20, 24];

  // Available options for font weights
  final List<FontWeight> fontWeights = FontWeight.values;

  // Available options for font styles
  final List<FontStyle> fontStyles = [FontStyle.normal, FontStyle.italic];

  // Available options for text colors
  final List<Color> textColors = [
    Colors.white,
    Colors.red,
    Colors.greenAccent,
    Colors.blue,
    Colors.orange
  ];

  Map<Color, String> textDisp = {
    Colors.white : 'White',
    Colors.red : 'Red',
    Colors.greenAccent : 'Green',
    Colors.blue : 'Blue',
    Colors.orange : 'Orange'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Customization Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Font Family Dropdown
                  DropdownButton<String>(
                    value: _currentTextStyle.fontFamily,
                    onChanged: (String? value) {
                      setState(() {
                        _currentTextStyle =
                            _currentTextStyle.copyWith(fontFamily: value);
                      });
                    },
                    items: <String>['Roboto', 'Arial', 'Times New Roman']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Font Family: $value'),
                      );
                    }).toList(),
                  ),
                  // Font Size Dropdown
                  DropdownButton<double>(
                    value: _currentTextStyle.fontSize,
                    onChanged: (double? value) {
                      setState(() {
                        _currentTextStyle =
                            _currentTextStyle.copyWith(fontSize: value);
                      });
                    },
                    items:
                        fontSizes.map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text('Font Size: $value'),
                      );
                    }).toList(),
                  ),
                  // Font Weight Dropdown
                  DropdownButton<FontWeight>(
                    value: _currentTextStyle.fontWeight,
                    onChanged: (FontWeight? value) {
                      setState(() {
                        _currentTextStyle =
                            _currentTextStyle.copyWith(fontWeight: value);
                      });
                    },
                    items: fontWeights
                        .map<DropdownMenuItem<FontWeight>>((FontWeight value) {
                      return DropdownMenuItem<FontWeight>(
                        value: value,
                        child: Text('Font Weight: $value'),
                      );
                    }).toList(),
                  ),
                  // Font Style Dropdown
                  DropdownButton<FontStyle>(
                    value: _currentTextStyle.fontStyle,
                    onChanged: (FontStyle? value) {
                      setState(() {
                        _currentTextStyle =
                            _currentTextStyle.copyWith(fontStyle: value);
                      });
                    },
                    items: fontStyles
                        .map<DropdownMenuItem<FontStyle>>((FontStyle value) {
                      return DropdownMenuItem<FontStyle>(
                        value: value,
                        child: Text(
                            'Font Style: ${value.toString().split('.').last}'),
                      );
                    }).toList(),
                  ),
                  // Text Color Dropdown
                  DropdownButton<Color>(
                    value: _currentTextStyle.color,
                    onChanged: (Color? value) {
                      setState(() {
                        _currentTextStyle =
                            _currentTextStyle.copyWith(color: value);
                      });
                    },
                    items:
                        textColors.map<DropdownMenuItem<Color>>((Color value) {
                      return DropdownMenuItem<Color>(
                        value: value,
                        child:
                            Text(textDisp[value]!, style: TextStyle(color: value)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // Text Field
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                style: _currentTextStyle,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your text here...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
