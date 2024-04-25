import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SquareAvatarPicker extends StatefulWidget {
  const SquareAvatarPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SquareAvatarPickerState createState() => _SquareAvatarPickerState();
}

class _SquareAvatarPickerState extends State<SquareAvatarPicker> {
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
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
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
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
