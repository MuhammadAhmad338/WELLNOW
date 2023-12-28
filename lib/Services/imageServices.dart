
import 'dart:convert';

import 'package:wellnow/Api/api.dart';
import 'package:wellnow/Helper/const.dart';

class ImageUploadServices {
  // upload image with my api upload image {
  uploadImage(String? image) async {
    Map<String, String> body = {'image': image!};
    print(body);
    var response = await client.post(Uri.parse('${APIURL}/api/upload'),
    body: jsonEncode(body),
//give me header  for upload image
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }
    );
    if (response.statusCode == 200) {
         print('Iamge uploaded successfully');
    } else {
      throw Exception('Failed to upload image');
    }
  }
}