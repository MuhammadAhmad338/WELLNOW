class EmergencyContacts {
  final String name;
  final String phone;

  EmergencyContacts({
    required this.name,
    required this.phone,
  });

  factory EmergencyContacts.fromJson(Map<String, dynamic> json) {
    return EmergencyContacts(
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
      };
}
