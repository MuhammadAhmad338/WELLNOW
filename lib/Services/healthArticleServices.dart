import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wellnow/Api/api.dart';
import 'package:wellnow/Helper/const.dart';
import 'package:wellnow/Models/articles.dart';

class HealthArticleServices {
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

  Future<void> uploadMedicalRecord() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      try {
        // Upload the file to Firebase Storage
        TaskSnapshot snapshot =
            await storage.ref('medical_records/${file}').putFile(file);
        // Get the download URL of the file
        String downloadUrl = await snapshot.ref.getDownloadURL();
        // Store the metadata of the file in Firestore
        print(downloadUrl);
      } on FirebaseException catch (e) {
        // Handle any errors
        print(e);
      }
    } else {
      // User canceled the picker
    }
  }

  // Upload image with my api upload image
    
  
}
