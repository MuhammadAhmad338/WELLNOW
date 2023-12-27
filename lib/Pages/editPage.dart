import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import 'package:wellnow/Provider/imageProvider.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});

  final WidthHeight _widthHeight = WidthHeight();

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          imageProvider.image != null
              ? CircleAvatar(
                  radius: _widthHeight.screenWidth(context, 0.13),
                  backgroundImage: FileImage(imageProvider.image!),
                )
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Change Photo',
                  style: TextStyle(
                    fontSize: _widthHeight.screenHeight(context, 0.02),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: _widthHeight.screenHeight(context, 0.045)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(height: _widthHeight.screenHeight(context, 0.045)),
          InkWell(
            onTap: () {
              print("Save Changes");
            },
            child: Container(
              width: _widthHeight.screenWidth(context, 0.66),
              height: _widthHeight.screenHeight(context, 0.06),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(24),
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
    );
  }
}
