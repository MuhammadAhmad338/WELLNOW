// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:wellnow/Models/user.dart';
import 'package:wellnow/Services/palmServices.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Future<PalmResponse>? _futurePalmResponse;
  List<Map<String, dynamic>> messages = []; // List to store the messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Well Now",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            child: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: "Search",
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            setState(() {
                              _futurePalmResponse =
                                  PalmServices().getData(_controller.text);
                            });
                          }
                        },
                        child: Text('Search',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder<PalmResponse>(
                      future: _futurePalmResponse,
                      builder: (BuildContext context,
                          AsyncSnapshot<PalmResponse> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // show a loading spinner while waiting for the data
                        } else {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('${snapshot.error}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ); // show an error message if an error occurred
                          } else {
                            if (snapshot.data == null) {
                              return Center(
                                child: Text(
                                    "Welcome to WellNow App – Your Health Companion!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              );
                            }

                            if (snapshot.data != null) {
                              // Add prompt message to the list
                              messages.add({"Prompt": _controller.text});
                              // Add response message to the list
                              messages.add({"Response": snapshot.data!.message});
                            }

                            return ListView.builder(
                              itemCount: messages.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2.0,
                                        blurRadius: 2.0,
                                        offset: Offset(0, 2.0),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                      messages[index].values.first.toString()),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
