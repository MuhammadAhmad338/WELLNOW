import 'dart:convert';
import '../Api/api.dart';
import 'package:http/http.dart';
import 'package:wellnow/Models/user.dart';
import '../Helper/const.dart';

class TipsServices {
  Future<List<TipsResponse>> fetchTips() async {
    Response response = await client.get(Uri.parse("${APIURL}/api/tips"),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => TipsResponse.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load tips from API');
    }
  }
}
