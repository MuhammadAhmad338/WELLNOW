import 'package:flutter/material.dart';
import 'package:wellnow/Helper/widthHeight.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String content;
  HealthCard({super.key, required this.title, required this.content});

  final WidthHeight _widthHeight = WidthHeight();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _widthHeight.screenHeight(
          context, 0.190), // Set your desired height here
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: EdgeInsets.symmetric(
            horizontal: _widthHeight.screenWidth(context, 0.035),
            vertical: _widthHeight.screenHeight(context, 0.008)),
        child: ListTile(
          title: Text(title),
          subtitle: Text(content),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
                "assets/images/settings.png"), // Assuming TipsResponse has an imageUrl field
          ),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            // Handle your onTap here
          },
        ),
      ),
    );
  }
}
