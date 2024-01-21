import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellnow/Models/medicalRecord.dart';
import 'package:wellnow/Services/healthArticleServices.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  Future<List<MedicalRecord>>? _medicalRecords;

  @override
  void initState() {
    super.initState();
    _medicalRecords = HealthArticleServices().fetchMedicalRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Medical Records'),
      ),
      body: FutureBuilder<List<MedicalRecord>>(
        future: _medicalRecords,
        builder: (BuildContext context,
            AsyncSnapshot<List<MedicalRecord>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data![index].url);
                return ListTile(
                  title: Text(
                      'Patient Name: ${snapshot.data![index].patientName}'),
                  leading:
                      CachedNetworkImage(imageUrl: snapshot.data![index].url),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go('/uploadRecord');
        },
        child: Icon(Icons.upload),
      ),
    );
  }
}
