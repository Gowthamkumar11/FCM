import 'dart:convert';

import 'package:api_testing/recentfile.dart';
import 'package:api_testing/services/local_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'firstpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    productList();

    FirebaseMessaging.instance.getInitialMessage();

    ///foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print('Notification hashCode = ${message.notification.hashCode}');
        print('Notification title = ${message.notification!.title}');
        print('Notification body = ${message.notification!.body}');

        LocalNotificationService.display(message);
      } else {
        print('opened message not working properly');
      }
    });

    ///background (but app should opened in background and user taps)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final getmsg = message.data['key'];
      if (getmsg == 'hello') {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Firpage()));
      }
    });
  }

  productList() async {
    var url = Uri.parse(
        'http://ec2-13-234-30-3.ap-south-1.compute.amazonaws.com:8000/Product_Master/product_list/');
    // https://us-central1-argutes-learning.cloudfunctions.net/app/entries/${textValue.text}

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = response.body.runtimeType == String
          ? convert.jsonDecode(response.body)
          : convert.jsonDecode(response.body) as Map<String, dynamic>;

      print('Response value: $jsonResponse ');
    } else {
      print('not work properly');
    }
  }

  // productList() async {
  //   print('+++++++++++++++++++++++++++++++++++++++++++++++++');
  //   var result = await http.get(
  //       Uri.parse(
  //           'http://ec2-13-234-30-3.ap-south-1.compute.amazonaws.com:8000/Product_Master/product_list/'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Accept': 'application/json',
  //         'Access-Control-Allow-Origin': '*/*',
  //       });
  //   final response = json.decode(result.body);

  //   //print(response['product_name']);
  //   print(" body property ${result.body}");
  //   // print(response[3]);
  //   dynamic test = response as Map<String, dynamic>;
  //   print("checking");
  //   print("type ${test.runtimeType}");

  //   return json.decode(result.body);
  // }

  @override
  final textValue = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Testing"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('entries').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docu = snapshot.data!.docs;

            return ListView.builder(
                shrinkWrap: true,
                itemCount: docu.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${index + 1}. Docu id -- ${docu[index].id}',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'field value ------ ${docu[index]['title']}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                          indent: 25,
                          endIndent: 25,
                        )
                      ],
                    ),
                  );
                }

                // SizedBox(
                //   width: 300,
                //   child: TextFormField(
                //     controller: textValue,
                //     decoration:
                //         const InputDecoration(labelText: 'Type something'),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Enter Something';
                //       }
                //     },
                //   ),
                // ),

                // ElevatedButton(
                //   onPressed: () async {
                //     // dynamic enterText;
                //     // if (_formKey.currentState!.validate()) {
                //     //   enterText = textValue.text;
                //     //   FirebaseFirestore.instance
                //     //       .collection('create')
                //     //       .doc('create')
                //     //       .set({'name': enterText}).then((value) {
                //     //     textValue.clear();
                //     //   });
                //     // }
                //     print('create button');
                //     var url = Uri.parse(
                //         'https://us-central1-argutes-learning.cloudfunctions.net/app/entries');
                //     Map<String, dynamic> mapvalue = {
                //       "title": textValue.text,
                //       "text": "textvalue",
                //     };
                //     var response = await http.post(url, body: mapvalue);
                //     if (response.statusCode == 200) {
                //       var jsonResponse = convert.jsonDecode(response.body)
                //           as Map<String, dynamic>;

                //       print('Response value: $jsonResponse ');
                //     } else {
                //       print(
                //           'Request failed with status: ${response.statusCode}.');
                //     }
                //     print('Response status: ${response.statusCode}');
                //     print('Response body: ${response.body}');
                //     textValue.clear();
                //   },
                //   child: Text('Create'),
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     print('delete button ${textValue.text}');

                //     final baseUrl =
                //         "https://us-central1-argutes-learning.cloudfunctions.net/app/entries/${textValue.text}";
                //     final url = Uri.parse(baseUrl);
                //     // final request = http.Request("DELETE", url);
                //     // //  var response = await http.post(url, body: mapvalue);
                //     final response = await http.delete(url);
                //     // await request.send();
                //     if (response.statusCode != 200) {
                //       return Future.error(
                //           "error: status code ${response.statusCode}");
                //     } else if (response.statusCode == 200) {
                //       print(
                //           "${textValue.text}  Document Deleted and the status code is ${response.statusCode}");
                //     }
                //     textValue.clear();
                //   },
                //   child: Text('Delete'),
                // ),
                // ElevatedButton(
                //   onPressed: () {

                //     print('update button');
                //   },
                //   child: Text('Update'),
                // )

                );
          }),
    );
  }
}
