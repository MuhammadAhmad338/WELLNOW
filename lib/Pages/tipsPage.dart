import 'package:flutter/material.dart';
import 'package:wellnow/Services/tipsServices.dart';
import 'package:wellnow/Widgets/healthCard.dart';
import '../Models/user.dart';

class TipsPage extends StatefulWidget {
  TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Health Tips"),
        ),
        body: SafeArea(
          child: Column(
                children: [
  
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
