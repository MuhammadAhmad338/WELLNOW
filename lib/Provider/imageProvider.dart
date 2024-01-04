import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerProvider with ChangeNotifier {
  File? _image;
  File? get image => _image;

  Future getImage() async {
    PermissionStatus _permissionStatus = await Permission.storage.request();
    if (_permissionStatus.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      print(path);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
      } else {
        print('No image selected.');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}
