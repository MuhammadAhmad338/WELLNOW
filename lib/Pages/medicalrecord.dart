import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Services/healthArticleServices.dart';

// ignore: must_be_immutable
class MedicalRecords extends StatelessWidget {
  MedicalRecords({super.key});

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _healthServicesProvider = Provider.of<HealthArticleServices>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Medical Records'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 
            20.0),
        child: Column(          
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                  onPressed: () {
                    _healthServicesProvider.pickFile();
                  },
                  child: Text('Upload File'),
                ),
                SizedBox(height: 15.0,),
                 Flexible(
                   child: Text('Selected file: ${_healthServicesProvider.fileName}', 
                    style: TextStyle(
                    overflow: TextOverflow.ellipsis
                   ),),
                 ),
            SizedBox(height: 20.0),
            ElevatedButton(
                      onPressed: () {
                        _healthServicesProvider.uploadMedicalRecord(
                          _nameController.text, context);
                        _nameController.clear();      
                      },
                      child: Text("Upload Record",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1)),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 45), // You can adjust the height (48) as needed
                        ),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
