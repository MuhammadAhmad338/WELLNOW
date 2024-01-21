import 'package:flutter/cupertino.dart';
import 'package:wellnow/Models/emergencyContacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContactsProvider with ChangeNotifier {
  List<EmergencyContacts> _emergencyContacts = [
    EmergencyContacts(
        name: 'General Emergencies - Rescue', phone: '1122', userid: '1'),
    EmergencyContacts(
        name: 'General Emergencies - Pehl', phone: '911', userid: '2'),
    EmergencyContacts(
        name: 'Police', phone: '15', userid: '3'),
    EmergencyContacts(
        name: 'Rangers', phone: '1011', userid: '4'),
    EmergencyContacts(
        name: 'Medical - Edhi Ambulance', phone: '115', userid: '5'),
    EmergencyContacts(
        name: 'Medical - Chhipa Ambulance', phone: '1020', userid: '6'),
    EmergencyContacts(
        name: 'Medical - PMA Helpline', phone: '1166', userid: '7'),
    EmergencyContacts(
        name: 'Fire Brigade', phone: '16', userid: '8'),
    EmergencyContacts(
        name: 'Women Helpline', phone: '1094', userid: '9'),
    EmergencyContacts(
        name: 'Sindh Child Protection', phone: '1121', userid: '10'),
  ];
  List<EmergencyContacts> get emergencyContacts => _emergencyContacts;

  // Add the contacts to the list
  void addContact(EmergencyContacts contact) {
    print(contact.userid);
    _emergencyContacts.add(contact);
    notifyListeners();
    saveContacts();
  }

  // Edit and Update a specific contact in the list
  void editContact(EmergencyContacts contact, int index) {
    print(contact.phone);
    _emergencyContacts[index] = contact;
    notifyListeners();
    saveContacts();
  }

  // Remove the contacts from the list
  void removeContact(EmergencyContacts contact) {
    _emergencyContacts.remove(contact);
    notifyListeners();
    saveContacts();
  }

  // Save the contacts to shared preferences based on the userid
  void saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsString = _emergencyContacts.map((contact) {
      return '${contact.name},${contact.phone},${contact.userid}';
    }).join(';');

    prefs.setString('contacts', contactsString);
  }

  // Load the contacts from shared preferences based on the userid
  void loadContacts(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final contactsString = prefs.getString('contacts') ?? '';
    final contacts = contactsString.split(';');

    // Filter contacts based on userid
    final filteredContacts = contacts.where((contact) {
      final trimmedContact = contact.trim(); // Trim whitespace and semicolon
      final split = trimmedContact.split(',');
      if (split.length == 3 && split[2] == userId) {
        return true;
      } else {
        print('Invalid contact format: $contact');
        return false;
      }
    }).toList();

    // Convert to List for easier printing
    _emergencyContacts = filteredContacts.map((contact) {
      final split = contact.split(',');
      return EmergencyContacts(
        name: split[0],
        phone: split[1],
        userid: split[2],
      );
    }).toList();

    notifyListeners();
  }
}
