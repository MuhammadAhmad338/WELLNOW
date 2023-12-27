import 'package:flutter/material.dart';
import 'package:wellnow/Helper/widthHeight.dart';
import 'package:wellnow/Services/tipsServices.dart';
import 'package:wellnow/Widgets/healthCard.dart';
import '../Models/user.dart';

class TipsPage extends StatefulWidget {
  TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final WidthHeight _widthHeight = WidthHeight();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
                children: [
          SizedBox(height: _widthHeight.screenHeight(context, 0.02)),
          Text("Health Tips",
              style: TextStyle(
                  fontSize: _widthHeight.screenHeight(context, 0.025),
                  fontWeight: FontWeight.bold)),
          SizedBox(height: _widthHeight.screenHeight(context, 0.02)),
          Expanded(
            child: FutureBuilder<List<TipsResponse>>(
              future: TipsServices().fetchTips(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    reverse: false,
                    itemBuilder: (context, index) {
                      final title = snapshot.data![index].title;
                      final content = snapshot.data![index].content;
                      return HealthCard(title: title, content: content);
                      
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
                ],
              ),
        ));
  }
}
