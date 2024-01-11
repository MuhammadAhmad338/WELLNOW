import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:wellnow/Api/api.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wellnow/Helper/const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';
import 'package:wellnow/Models/articles.dart';
import 'package:wellnow/Models/medicalRecord.dart';

class HealthArticleServices with ChangeNotifier {

  String? _fileName = "Please select a file";
  String? get fileName => _fileName;
  PlatformFile? _platformFile;
  Uint8List? _fileData;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg', 'png'],
    );

    if (result != null) {
      _platformFile = result.files.first;
      _fileData = _platformFile!.bytes;

      _fileName = _platformFile!.name;
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadMedicalRecord(String patientName, BuildContext context) async {
    if (_platformFile != null && _fileData != null) {
      try {
        // Upload the file to Firebase Storage
        String userid =  await LocalStorage().getUid();
        TaskSnapshot snapshot = await storage
            .ref('medical_records/${_platformFile!.name}')
            .putData(_fileData!);
        // Get the download URL of the file
        String downloadUrl = await snapshot.ref.getDownloadURL();
        // Send the metadata of the file to the api
        Map<String, String> body = {
          'patientName': patientName,
          'userid': userid,
          'url': downloadUrl,
        };

        Response response = await client.post(
            Uri.parse('$APIURL/api/post_medical'),
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'});
        if (response.statusCode == 200) {
          _fileName = "Please select a file";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Medical record uploaded successfully'),
              backgroundColor: Colors.blue,
            ),
          );
          notifyListeners();
        }
      } on FirebaseException catch (e) {
        // Handle any errors
        print(e);
      }
    }
  }

  // Please get me the medical apis from the backend api
  Future<List<MedicalRecord>> fetchMedicalRecords() async {
    final response = await client.get(Uri.parse('$APIURL/api/get_medical'));

    if (response.statusCode == 200) {
      //Make It For List Dynamic
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => MedicalRecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load medical records');
    }
  }

  Future<List<Article>> fetchArticles() async {
    final response = await client
        .get(Uri.parse('https://www.healthcare.gov/api/articles.json'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['articles'];
      return body.map((dynamic item) => Article.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

}
