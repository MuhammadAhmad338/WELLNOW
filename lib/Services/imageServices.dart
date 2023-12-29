// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wellnow/LocalStorage/localStorage.dart';

class ImageUploadServices {
  // Upload image with my api upload image {
  onUploadImage(File? selectedImage, String username) async {
    if (selectedImage == null) {
      throw Exception('No image selected');
    }
    FirebaseStorage storage = FirebaseStorage.instance;
    String uid = await LocalStorage().getUid();
    Reference ref = storage
        .ref()
        .child('profile_images/${uid}/${selectedImage.path.split('/').last}');
    UploadTask uploadTask = ref.putFile(selectedImage);

    await uploadTask.whenComplete(() => null);
    final url = await ref.getDownloadURL();

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(uid).update({'imageUrl': url, 'username': username});
  }
}
