import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image_editor/image_editor.dart';


class CropImageWidgetTestScreen extends StatelessWidget {
  const CropImageWidgetTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CropImageWidget(),
      );
  }
}

class CropImageWidget extends StatefulWidget {
  const CropImageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CropImageWidgetState createState() => _CropImageWidgetState();
}


class _CropImageWidgetState extends State<CropImageWidget> {
  GlobalKey imageKey = GlobalKey();
  double left = 50.0;
  double top = 50.0;
  double width = 200.0;
  double height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onScaleUpdate: (details) {
          setState(() {
            left = (left + details.focalPointDelta.dx).clamp(0.0, MediaQuery.of(context).size.width - width);
            top = (top + details.focalPointDelta.dy).clamp(0.0, MediaQuery.of(context).size.height - height);
            width = (width * details.scale).clamp(50.0, MediaQuery.of(context).size.width - left);
            height = (height * details.scale).clamp(50.0, MediaQuery.of(context).size.height - top);
          });
        },
        onScaleEnd: (_) {
          _cropImage();
        },
        child: Stack(
          children: [
            Image.asset(
              'assets/cinema1.jpg',
              key: imageKey,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: left,
              top: top,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    RenderRepaintBoundary boundary = imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8List = byteData!.buffer.asUint8List();

    final editorOption = ImageEditorOption();
    editorOption.addOption(const FlipOption());

    ImageEditor.editImageAndGetFile(
      image: Uint8List.fromList(uint8List), 
      imageEditorOption: editorOption
    ).then((value) => {print(value.path)});
    // editor.setImage(Uint8List.fromList(uint8List));
    // editor.crop(left.toInt(), top.toInt(), width.toInt(), height.toInt());

    // Uint8List croppedData = await editor.exportData();

  }
}