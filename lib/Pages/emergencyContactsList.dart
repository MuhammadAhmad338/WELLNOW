import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/emergencyContacts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Provider/emergencyContactsProvider.dart';

class EmergencyContactsList extends StatefulWidget {
  @override
  _EmergencyContactsListState createState() => _EmergencyContactsListState();
}

class _EmergencyContactsListState extends State<EmergencyContactsList> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Emergency Contact'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contact = EmergencyContacts(
                      name: _nameController.text,
                      phone: _phoneController.text,
                    );
                    Provider.of<EmergencyContactsProvider>(context,
                            listen: false)
                        .addContact(contact);
                    Navigator.pop(context);
                  }
                },
              ),
              Consumer<EmergencyContactsProvider>(
                  builder: (context, contactsProvider, child) {
                return ListView.builder(
                  itemCount: contactsProvider.emergencyContacts.length,
                  itemBuilder: (context, index) {
                    final contact = contactsProvider.emergencyContacts[index];
                    return ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phone),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          contactsProvider.deleteContact(contact);
                        },
                      ),
                      onTap: () async {
                        final url = 'tel:${contact.phone}';
                        if (await canLaunchUrl(url as Uri)) {
                          await launchUrl(url as Uri);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
