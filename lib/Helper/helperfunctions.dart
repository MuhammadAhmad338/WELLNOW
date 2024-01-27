import 'package:flutter/material.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import 'package:wellnow/Models/emergencyContacts.dart';
import 'package:wellnow/Provider/emergencyContactsProvider.dart';

void showContactModalBottomSheet(
    {required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required String userid,
    required GlobalKey<FormState> formKey,
    required EmergencyContactsProvider emergencyContacts,
    required WidthHeight widthHeight}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            // Make the 250 height to the height of the form
            height: widthHeight.screenHeight(context, 0.31),
            padding: EdgeInsets.symmetric(
              horizontal: widthHeight.screenWidth(context, 0.014),
              vertical: widthHeight.screenHeight(context, 0.014)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthHeight.screenWidth(context, 0.012)),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      // Write a valication
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Enter Name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthHeight.screenWidth(context, 0.012)),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      // Write a validation
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Enter Phone'),
                  ),
                ),
                SizedBox(height: widthHeight.screenHeight(context, 0.006)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthHeight.screenWidth(context, 0.012)),
                  child: Container(
                    // Add more fields as needed
                    height: widthHeight.screenHeight(context, 0.07),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final name = nameController.text;
                          final phoneNumber = phoneController.text;
                          emergencyContacts.addContact(EmergencyContacts(
                            name: name,
                            phone: phoneNumber,
                            userid: userid,
                          ));
                          nameController.clear();
                          phoneController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save Contact',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
