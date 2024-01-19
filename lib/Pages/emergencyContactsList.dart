// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import '../Models/emergencyContacts.dart';

class EmergencyContactsList extends StatefulWidget {
  @override
  _EmergencyContactsListState createState() => _EmergencyContactsListState();
}

class _EmergencyContactsListState extends State<EmergencyContactsList> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  List<EmergencyContacts> _contacts = [];

  @override
  void dispose() {
    super.dispose();
    _nameController.clear();
    _phoneController.clear();
  }

  void _addContact(String name, String phone) {
    setState(() {
      _contacts.add(EmergencyContacts(name: name, phone: phone));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Emergency Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent.shade100,
        onPressed: () {
          // Show the bottom sheet when FloatingActionButton is pressed
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Enter Name'),
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Enter Phone'),
                    ),
                    // Add more fields as needed
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text;
                        final phoneNumber = _phoneController.text;

                        _addContact(name, phoneNumber);
                        // Close the modal or clear the form
                        Navigator.pop(context);
                      },
                      child: Text('Save Contact'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ContactListItem(contact: contact);
        },
      ),
    );
  }
}

class ContactListItem extends StatelessWidget {
  final EmergencyContacts contact;

  const ContactListItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      leading: Icon(Icons.person),
    );
  }
}
