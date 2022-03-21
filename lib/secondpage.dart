import 'package:api_testing/fav.dart';
import 'package:api_testing/newspage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:number_pagination/number_pagination.dart';

dynamic bookmark = {}, map2 = {}, len = 0;

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  _SecondpageState createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  @override
  void initState() {
    test();
    super.initState();
  }

  bool value1 = false;
  dynamic value;
  @override
  test() async {
    print('hwlol $value');
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=Apple&from=2022-02-22&sortBy=popularity&apiKey=9bdef97d765d43d28ab2e9e3a954d66d');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var jsonResponse = response.body.runtimeType == String
      //     ? convert.jsonDecode(response.body)
      //     : convert.jsonDecode(response.body) as Map<String, dynamic>;

      print(
          '${jsonResponse['articles'].length} value: $jsonResponse and its length ');
      setState(() {
        value = jsonResponse;
        len = jsonResponse['articles'].length;
      });
    } else {
      print('not work properly ${response.statusCode}');
    }
  }

  fav(int index) {
    dynamic author, title, description, url, urltoimage, publishedat, content;

    author = value['articles'][index]['author'] ?? "author";
    title = value['articles'][index]['title'];
    description = value['articles'][index]['description'] ?? "description";
    url = value['articles'][index]['url'] ?? "url";
    urltoimage = value['articles'][index]['urlToImage'] ?? "image";
    publishedat = value['articles'][index]['publishedAt'] ?? "publishedat";
    content = value['articles'][index]['content'] ?? "content";
    print("gowtham ${index}");

    setState(() {
      map2[index.toString()] = {'id': index.toString()};
      print('map2 value $map2');
    });
    // if (bookmark.length > 0) {
    //   if (bookmark.length >= index + 1) {
    //     print('if part');
    //     // setState(() {
    //     //   map2[index.toString()] = {'id': true};
    //     //   print('map2 value $map2');
    //     // });
    //     print(
    //         'checking value ${bookmark[index.toString()]['id']['author']}');
    //   } else {
    //     print(' ${map2.length}other indexes $index');
    //   }
    // } else {
    //   print('else part worked');
    //   map2[index.toString()] = {'id': true};
    // }
    dynamic mapvalue = {};
    mapvalue = {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urltoimage': urltoimage,
      'publishedat': publishedat,
      'content': content,
      'index': index.toString(),
    };
    dynamic inde = index.toString();
    bookmark[inde] = {'id': mapvalue};
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('News-App'),
          actions: [
            InkWell(
              onDoubleTap: () {},
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Fav()));
              },
              child: Row(
                children: const [
                  Text("Favourites"),
                  SizedBox(
                    width: 3,
                  ),
                  Icon(Icons.star_outline),
                  SizedBox(
                    width: 3,
                  ),
                ],
              ),
            )
          ],
        ),
        body: value == null
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Fetching Data')
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: value["articles"].length,
                itemBuilder: (context, index) {
                  String val = index.toString();
                  print('val ${bookmark.length}');

                  return Column(
                    children: [
                      ListTile(
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: (map2.isEmpty
                                    ? false
                                    : ((map2[index.toString()] != null)
                                                ? map2[index.toString()]['id']
                                                : 'check') ==
                                            index.toString()
                                        ? true
                                        : false)
                                ? Colors.red
                                : Colors.grey[400],
                          ),
                          onPressed: () {
                            if (map2[index.toString()] != null) {
                              if (map2[index.toString()]['id'] ==
                                  bookmark[index.toString()]['id']['index']) {
                                setState(() {
                                  map2.remove(index.toString());
                                  bookmark.remove(index.toString());
                                  // map2[index.toString()] = {'id': 'change'};
                                });
                              }
                            } else {
                              fav(index);
                            }
                          },
                        ),
                        onTap: () {
                          dynamic author,
                              title,
                              description,
                              url,
                              urltoimage,
                              publishedat,
                              content;
                          author =
                              value['articles'][index]['author'] ?? "author";
                          title = value['articles'][index]['title'] ?? "title";
                          description = value['articles'][index]
                                  ['description'] ??
                              "description";
                          url = value['articles'][index]['url'] ?? "url";
                          urltoimage =
                              value['articles'][index]['urlToImage'] ?? "image";
                          publishedat = value['articles'][index]
                                  ['publishedAt'] ??
                              "publishedat";
                          content =
                              value['articles'][index]['content'] ?? "content";

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Newspage(
                                  content: content,
                                  author: author,
                                  title: title,
                                  url: url,
                                  urltoimage: urltoimage,
                                  publishedat: publishedat,
                                  description: description)));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            value['articles'][index]['urlToImage'].toString(),
                          ),
                        ),
                        title:
                            Text(value['articles'][index]['title'].toString()),
                        subtitle: Text(
                          value['articles'][index]['author'].toString() ==
                                  "null"
                              ? "- unknown author"
                              : "- ${value['articles'][index]['author'].toString()} ",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(
                        thickness: 2.5,
                        indent: 75,
                      ),
                    ],
                  );
                })
        // child: Column(
        //   children: [
        //     Text(value['articles'][0]['source']['id'].toString() ?? 'hello'),

        //   ],
        // ),
        );
  }
}
