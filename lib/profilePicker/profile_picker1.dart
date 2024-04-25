import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CircularAvatarPicker extends StatefulWidget {
  const CircularAvatarPicker({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CircularAvatarPickerState createState() => _CircularAvatarPickerState();
}

class _CircularAvatarPickerState extends State<CircularAvatarPicker> {
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
      child: CircleAvatar(
        radius: 50.0,
        // Check if _image.path is not empty before using FileImage
        backgroundImage: _image.path.isNotEmpty ? FileImage(File(_image.path)) : null,
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
