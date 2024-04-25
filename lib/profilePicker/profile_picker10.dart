import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DoubleBorderAvatarPicker extends StatefulWidget {
  const DoubleBorderAvatarPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoubleBorderAvatarPickerState createState() =>
      _DoubleBorderAvatarPickerState();
}

class _DoubleBorderAvatarPickerState extends State<DoubleBorderAvatarPicker> {
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
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
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
