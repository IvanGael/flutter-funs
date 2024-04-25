import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RoundedRectangleAvatarPicker extends StatefulWidget {
  const RoundedRectangleAvatarPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RoundedRectangleAvatarPickerState createState() =>
      _RoundedRectangleAvatarPickerState();
}

class _RoundedRectangleAvatarPickerState
    extends State<RoundedRectangleAvatarPicker> {
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
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          image: _image.path.isNotEmpty
              ? DecorationImage(
                  image: FileImage(File(_image.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _image.path.isEmpty
            ? const Icon(
                Icons.camera_alt,
                size: 40.0,
                color: Colors.black,
              )
            : null,
      ),
    );
  }
}
