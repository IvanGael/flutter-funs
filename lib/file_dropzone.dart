// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/image-toolbox/file_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FileDropZoneTestScreen extends StatefulWidget {
  const FileDropZoneTestScreen({super.key});

  @override
  State<FileDropZoneTestScreen> createState() => _FileDropZoneTestScreenState();
}

class _FileDropZoneTestScreenState extends State<FileDropZoneTestScreen> {
  List<File> selectedFiles = [];
  Uint8List? imageResult;
  Map<String, dynamic>? countingResult;
  bool uploadStarting = false;
  final FileService _fileService = FileService();

  onFilesSelected(List<File> files) {
    setState(() {
      selectedFiles = files;
    });
  }

  handleUpload() async {
    if (selectedFiles.isNotEmpty) {
      setState(() {
        imageResult = null;
        uploadStarting = true;
      });
      try {
        Uint8List? result = await _fileService.uploadFileForObjectsDetection(selectedFiles[0]);
        if (result != null) {
          try {
            Map<String, dynamic>? ctResult = await _fileService.uploadFileForObjectsCounting(selectedFiles[0]);
            setState(() {
              uploadStarting = false;
              countingResult = ctResult;
              imageResult = result;
            });
          } catch (error) {
            setState(() {
              uploadStarting = false;
            });
            debugPrint(error.toString());
          }
        }
      } catch (error) {
        setState(() {
          uploadStarting = false;
        });
        debugPrint(error.toString());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select a JPG, JPEG, or PNG image.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red[400]!,
        ),
      );
      return;
    }
  }

  Widget displayCountingResult() {
    if (countingResult == null) {
      // Handle the case when countingResult is null
      return const SizedBox(); 
    }

    List<String> keys = countingResult!.keys.toList();
    return Row(
      children: [
        Text(
          '${keys.length} object(s) detected : ',
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(width: 4),
        Text(
          keys.join(', '),
          style: const TextStyle(
            color: Colors.deepPurple, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
          child: Column(
            children: [
              FileDropZone(
                onFilesSelected: onFilesSelected,
                allowMultiple: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: uploadStarting == true ? null :  () async {
                      handleUpload();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        uploadStarting == true ? Colors.blue.shade200 : Colors.blue
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(7)),
                    ),
                    child: Text(
                      uploadStarting == false ? 'Send' : 'Processing',
                      style: const TextStyle(fontSize: 13),
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 500,
                height: MediaQuery.of(context).size.height - 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageResult != null)
                      Image.memory(
                        imageResult!,
                        width: 350,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    if (imageResult != null)
                    displayCountingResult(),
                    if (uploadStarting == true)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    if (uploadStarting == false) const Text("...")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FileDropZone extends StatefulWidget {
  final bool allowMultiple;
  final Function(List<File>) onFilesSelected;

  const FileDropZone(
      {super.key, this.allowMultiple = true, required this.onFilesSelected});

  @override
  _FileDropZoneState createState() => _FileDropZoneState();
}

class _FileDropZoneState extends State<FileDropZone> {
  List<File> droppedFiles = [];

  Future<void> handleDrop(List<XFile> xFiles) async {
    List<File> files = [];

    for (var xFile in xFiles) {
      File file = File(xFile.path);
      files.add(file);
    }

    List<File> imageFiles = files.where((file) {
      String fileType = file.path.toLowerCase();
      return fileType.endsWith('.jpg') ||
          fileType.endsWith('.jpeg') ||
          fileType.endsWith('.png');
    }).toList();

    if (imageFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a JPG, JPEG, or PNG image.'),
        ),
      );
      return;
    }

    setState(() {
      if (!widget.allowMultiple) {
        droppedFiles = [imageFiles.first];
      } else {
        droppedFiles = imageFiles;
      }
    });

    widget.onFilesSelected(imageFiles);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 300,
        height: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.allowMultiple == false && droppedFiles.isNotEmpty)
              Image.file(
                droppedFiles[0],
                width: 100,
                height: 100,
              ),
            if (widget.allowMultiple == true && droppedFiles.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: droppedFiles
                    .map(
                      (f) => Image.file(
                        droppedFiles[0],
                        width: 70,
                        height: 70,
                      ),
                    )
                    .toList(),
              ),
            if (droppedFiles.isEmpty)
              const Text(
                'Drop the image file here',
                style: TextStyle(fontSize: 13),
              ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                List<XFile>? xFiles =
                    await ImagePicker().pickMultiImage(imageQuality: 70);
                if (xFiles != null) {
                  await handleDrop(xFiles);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
                padding: MaterialStateProperty.all(const EdgeInsets.all(7)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.upload_file),
                  SizedBox(width: 5),
                  Text(
                    'Pick the image',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: droppedFiles.map((file) {
            //     return Text(
            //       '${file.path.substring(0, file.path.length ~/ 2)}...${file.path.split('.').last} (${(file.lengthSync() / 1024).toStringAsFixed(2)} KB)',
            //       style: const TextStyle(fontSize: 13),
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
