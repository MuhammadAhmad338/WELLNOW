import 'package:flutter/material.dart';
import '../Helper/widthHeight.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  ProfileButton({super.key, required this.text});

  final WidthHeight _widthHeight = WidthHeight();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _widthHeight.screenHeight(context, 0.065),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2.0), // change x and y to adjust shadow position
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.black)),
          Icon(Icons.arrow_forward_ios, color: Colors.black,)
        ],
      ),
    );
  }
}
