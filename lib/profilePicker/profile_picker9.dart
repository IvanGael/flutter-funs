import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiamondShapeAvatarPicker extends StatefulWidget {
  const DiamondShapeAvatarPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DiamondShapeAvatarPickerState createState() =>
      _DiamondShapeAvatarPickerState();
}

class _DiamondShapeAvatarPickerState extends State<DiamondShapeAvatarPicker> {
  late ImagePicker _picker;
  late XFile _image = XFile(''); 

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  Future<void> _pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
                image: _image.path.isNotEmpty
                    ? DecorationImage(
                        image: FileImage(File(_image.path)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            Center(
              child: _image.path.isEmpty
                  ? const Icon(
                      Icons.camera_alt,
                      size: 40.0,
                      color: Colors.white,
                    )
                  : null,
            ),
            Center(
              child: Transform.rotate(
                angle: 45 * pi / 180,
                child: const Icon(
                  Icons.star,
                  size: 40.0,
                  color: Colors.yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
