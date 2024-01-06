class MedicalRecord {
  final String patientName;
  final String url;

  MedicalRecord({required this.patientName, required this.url});

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      patientName: json['patientName'],
      url: json['url'],
    );
  }
}