import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
Future<bool> isSignedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isSignedIn') ?? false;
}

Future<void> saveSignInData(bool isSignedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isSignedIn', isSignedIn);
}

Future<String> getUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? "";
}

Future<String> getEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email') ?? "";
}

Future<String> getUid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_uid') ?? "";
}

Future<void> setUid(String uid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("user_uid", uid);
}

Future<void> setEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("email", email);
}


Future<void> setUsername(String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}

Future<void> setSearchHistory(List<String> messages) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('messagesList', messages);
}
  
Future<List<String>> getSearchHistory() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('messagesList') ?? [];
}



}