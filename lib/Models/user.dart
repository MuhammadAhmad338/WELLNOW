import 'dart:convert';

class User {
  final String username;
  final String email;
  final String user_uid;
  final String message;
  final String? imageUrl;

  User(this.imageUrl, {required this.username, required this.user_uid, required this.email, required this.message});

 Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'message': message,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
       map['imageUrl'] as String?,
      username: map['username'] as String,
      email: map['email'] as String,
      message: map['message'] as String,
      user_uid: map['user_uid'] as String,
    );
  }
}

class PalmResponse {
  final String message;

  PalmResponse({required this.message});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory PalmResponse.fromMap(Map<String, dynamic> map) {
    return PalmResponse(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PalmResponse.fromJson(String source) =>
      PalmResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TipsResponse {
  final String title;
  final String content;

  TipsResponse({required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
    };
  }

  factory TipsResponse.fromMap(Map<String, dynamic> map) {
    return TipsResponse(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipsResponse.fromJson(String source) =>
      TipsResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
