import 'package:flutter/cupertino.dart';
import 'package:wellnow/Models/emergencyContacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContactsProvider with ChangeNotifier {
  List<EmergencyContacts> _emergencyContacts = [];
  List<EmergencyContacts> get emergencyContacts => _emergencyContacts;

  EmergencyContactsProvider() {
    loadContacts();
  }

  void addContact(EmergencyContacts contact) {
    _emergencyContacts.add(contact);
    saveContacts();
    notifyListeners();
  }

  void deleteContact(EmergencyContacts contact) {
    _emergencyContacts.remove(contact);
    saveContacts();
    notifyListeners();
  }

  void saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsString = _emergencyContacts.map((contact) {
      return '${contact.name},${contact.phone}';
    }).join(';');
    await prefs.setString('contacts', contactsString);
  }

  void loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsString = prefs.getString('contacts') ?? '';
    _emergencyContacts = contactsString.split(';').where((contactString) {
      return contactString.isNotEmpty;
    }).map((contactString) {
      final parts = contactString.split(',');
      return EmergencyContacts(name: parts[0], phone: parts[1]);
    }).toList();
    notifyListeners();
  }
}