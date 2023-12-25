import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     body: Center(
       child: Column(
         children: [
           SizedBox(height: 20,),
           Text("Search Page"),
         ],
       ),
     )
    );
  }
}