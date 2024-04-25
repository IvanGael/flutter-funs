import 'package:flutter/material.dart';


class ColorPickerWidgetTestScreen extends StatelessWidget {
  const ColorPickerWidgetTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: ColorPickerButton(),
        ),
      );
  }
}


class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ColorPickerModal();
          },
        );
      },
      child: const Text('Open Color Picker'),
    );
  }
}

class ColorPickerModal extends StatelessWidget {
  final List<Color> colorPalettes = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.white
  ];

  ColorPickerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: colorPalettes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, colorPalettes[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorPalettes[index],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class ColorPickerWidget extends StatefulWidget {
//   const ColorPickerWidget({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
// }

// class _ColorPickerWidgetState extends State<ColorPickerWidget> {
//   double redValue = 0.0;
//   double greenValue = 0.0;
//   double blueValue = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 200,
//           height: 200,
//           decoration: BoxDecoration(
//             color: Color.fromRGBO(
//               redValue.round(),
//               greenValue.round(),
//               blueValue.round(),
//               1.0,
//             ),
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Text('Red: ${redValue.round()}'),
//         Slider(
//           value: redValue,
//           onChanged: (value) {
//             setState(() {
//               redValue = value;
//             });
//           },
//           min: 0,
//           max: 255,
//         ),
//         const SizedBox(height: 10),
//         Text('Green: ${greenValue.round()}'),
//         Slider(
//           value: greenValue,
//           onChanged: (value) {
//             setState(() {
//               greenValue = value;
//             });
//           },
//           min: 0,
//           max: 255,
//         ),
//         const SizedBox(height: 10),
//         Text('Blue: ${blueValue.round()}'),
//         Slider(
//           value: blueValue,
//           onChanged: (value) {
//             setState(() {
//               blueValue = value;
//             });
//           },
//           min: 0,
//           max: 255,
//         ),
//       ],
//     );
//   }
// }
