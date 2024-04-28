import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data'; // Import Uint8List

class FileService {
  // For web
  // final String baseUrl = "http://localhost:5000";

  // For android (10.0.2.2 is special IP address which refers to the host machine from the Android emulator. This IP address is an alias to localhost on the host machine.)
  // Make sure the server is bound to 0.0.0.0 or the actual IP address instead of localhost when running it on the local machine. Binding to 0.0.0.0 makes the server accessible from any network interface.
  final String baseUrl = "http://10.0.2.2:5000";

  Future<Uint8List?> uploadFileForObjectsDetection(File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/detect_objects'))
            ..files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        // Assuming the response contains the bytes data
        var bytes = await response.stream.toBytes(); // Convert stream to Uint8List
        return bytes;
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return null;
    }
  }

  Future<Map<String, dynamic>?> uploadFileForObjectsCounting(File file) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/count_objects'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        // Parse JSON response
        Map<String, dynamic> data = jsonDecode(responseBody);
        return data;
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return null;
    }
  }


}
