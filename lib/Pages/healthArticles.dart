import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wellnow/Models/articles.dart';
import '../Services/healthArticleServices.dart';

class HealthArticlesPage extends StatelessWidget {
  HealthArticlesPage({Key? key}) : super(key: key);
  
  final HealthArticleServices _articleServices = HealthArticleServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Health Articles'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _articleServices.fetchArticles(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data![index].url),
                subtitle: Html(data: snapshot.data![index].content),
                onTap: () {
                
                },
              );
            },
          );
        },
      ));
  }
}