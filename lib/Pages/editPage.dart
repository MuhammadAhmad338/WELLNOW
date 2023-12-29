
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import 'package:wellnow/Provider/imageProvider.dart';
import 'package:wellnow/Services/imageServices.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});

  final WidthHeight _widthHeight = WidthHeight();
  final TextEditingController _controller = TextEditingController();
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            imageProvider.image != null
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black, // Specify border color
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Specify shadow color
                          spreadRadius: 3, // Specify spread radius
                          blurRadius: 3, // Specify blur radius
                          offset: Offset(0, 3), // Specify offset
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: _widthHeight.screenWidth(context, 0.13),
                      backgroundImage: FileImage(imageProvider.image!),
                    ))
                : CircleAvatar(
                    radius: _widthHeight.screenWidth(context, 0.13),
                    backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    ),
                  ),
            SizedBox(height: _widthHeight.screenHeight(context, 0.015)),
            InkWell(
              onTap: () {
                imageProvider.getImage();
              },
              child: Container(
                width: _widthHeight.screenWidth(context, 0.36),
                height: _widthHeight.screenHeight(context, 0.05),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'Change Photo',
                    style: TextStyle(
                      fontSize: _widthHeight.screenHeight(context, 0.018),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: _widthHeight.screenHeight(context, 0.045)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              child: TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please update your username to save changes.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Username', 
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: _widthHeight.screenHeight(context, 0.035)),
            InkWell(
              onTap: () {
                print("Save Changes");
              if (_formKey.currentState!.validate() &&   imageProvider.image != null) {
                ImageUploadServices().onUploadImage(
                  imageProvider.image,
                  _controller.text,
                );
                //Make the tetxfield empty after saving changes
                _controller.clear();
                
              }
          
              },
              child: Container(
                width: _widthHeight.screenWidth(context, 0.66),
                height: _widthHeight.screenHeight(context, 0.06),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Center(
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: _widthHeight.screenHeight(context, 0.02),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
