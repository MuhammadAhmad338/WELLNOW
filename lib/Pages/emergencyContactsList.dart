// ignore_for_file: unused_field, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Helper/helperfunctions.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import '../Models/emergencyContacts.dart';
import '../LocalStorage/localStorage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Provider/emergencyContactsProvider.dart';

class EmergencyContactsList extends StatefulWidget {
  @override
  _EmergencyContactsListState createState() => _EmergencyContactsListState();
}

class _EmergencyContactsListState extends State<EmergencyContactsList> {
  final _formKey = GlobalKey<FormState>();
  WidthHeight _widthHeight = WidthHeight();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  LocalStorage _localStorage = LocalStorage();
  String _userid = "";

  void initState() {
    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.clear();
    _phoneController.clear();
  }

  // get the userid from shared preferences and store in the variable
  void getUserId() async {
    _userid = await _localStorage.getUid();
    print(_userid);
    EmergencyContactsProvider().loadContacts(_userid);
  }

  @override
  Widget build(BuildContext context) {
    final emergencyContacts = Provider.of<EmergencyContactsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Emergency Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the bottom sheet when FloatingActionButton is pressed
          showContactModalBottomSheet(
              context: context,
              nameController: _nameController,
              phoneController: _phoneController,
              userid: _userid,
              formKey: _formKey,
              widthHeight: _widthHeight,
              emergencyContacts: emergencyContacts);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: emergencyContacts.emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = emergencyContacts.emergencyContacts[index];

          return ContactListItem(contact: contact, index: index);
        },
      ),
    );
  }
}

class ContactListItem extends StatefulWidget {
  final EmergencyContacts contact;
  final int index;

  ContactListItem({Key? key, required this.contact, required this.index})
      : super(key: key);

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  

  void launchDialer(String phoneNumber) async {
    print(phoneNumber);
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //assign the contact data to the text controllers
  void initState() {
    super.initState();
    _usernameController.text = widget.contact.name;
    _phoneNumberController.text = widget.contact.phone;
  }

  @override
  Widget build(BuildContext context) {
    final emergencyContacts = Provider.of<EmergencyContactsProvider>(context);
    return ListTile(
      title: Text(widget.contact.name),
      subtitle: Text(widget.contact.phone),
      onTap: () => launchDialer(widget.contact.phone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              //Raise the bottom sheet and also pass the contact data to the bottom sheet
              showContactModalBottomSheet(
                  context: context,
                  nameController: _usernameController,
                  phoneController: _phoneNumberController,
                  userid: widget.contact.userid,
                  formKey: GlobalKey<FormState>(),
                  widthHeight: WidthHeight(),
                  emergencyContacts: emergencyContacts,
                );
                        
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              final emergencyContacts = Provider.of<EmergencyContactsProvider>(
                  context,
                  listen: false);
              emergencyContacts.removeContact(widget.contact);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      leading: Icon(Icons.person),
    );
  }
}
