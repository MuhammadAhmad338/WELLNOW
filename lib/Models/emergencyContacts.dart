class EmergencyContacts {
  final String name;
  final String phone;
  final String userid;

  EmergencyContacts({
    required this.name,
    required this.phone,
    required this.userid,
  });

  factory EmergencyContacts.fromJson(Map<String, dynamic> json) {
    return EmergencyContacts(
      name: json['name'],
      phone: json['phone'],
      userid: json['userid'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'userid': userid,
      };
}
