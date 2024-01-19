import 'dart:convert';
import 'package:http/http.dart';
import 'package:wellnow/Api/api.dart';
import 'package:wellnow/Models/user.dart';
import '../Helper/const.dart';

class PalmServices {
  Future<PalmResponse> getData(String searchText) async {
    Map<String, String> body = {'prompt': searchText};
    print(body);
    Response response = await client.post(Uri.parse('${APIURL}/api/palm'),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      // Data fetched successfully

      PalmResponse palmResponse = PalmResponse.fromMap(
          jsonDecode(response.body) as Map<String, dynamic>);
      print(palmResponse);
      return palmResponse;
    } else {
      // Error occurred while fetching data
      throw Exception('Failed to fetch data');
    }
  }
}
