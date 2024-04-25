import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FrameOverlayAvatarPicker extends StatefulWidget {
  const FrameOverlayAvatarPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FrameOverlayAvatarPickerState createState() =>
      _FrameOverlayAvatarPickerState();
}

class _FrameOverlayAvatarPickerState extends State<FrameOverlayAvatarPicker> {
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
      child: Container(
        width: 120.0,
        height: 120.0,
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
        child: const Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Icon(
                Icons.camera_alt,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.favorite,
                size: 40.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
