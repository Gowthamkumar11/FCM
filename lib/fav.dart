import 'package:api_testing/newspage.dart';
import 'package:api_testing/secondpage.dart';
import 'package:flutter/material.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    print('len value $len');
    print(bookmark);
    // print(bookmark[2.toString()]['id']['author']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite List'),
      ),
      body: bookmark.isEmpty
          ? const Center(
              child: Text('No Favourite List'),
            )
          : Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: len,
                    itemBuilder: (context, index) {
                      return (bookmark.isEmpty
                              ? false
                              : ((bookmark[index.toString()] != null)
                                      ? true
                                      : false)
                                  ? true
                                  : false)
                          ? //Text(bookmark[index.toString()]['id']['author'])
                          Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    dynamic author,
                                        title,
                                        description,
                                        url,
                                        urltoimage,
                                        publishedat,
                                        content;
                                    author = bookmark[index.toString()]['id']
                                            ['author'] ??
                                        "author";
                                    title = bookmark[index.toString()]['id']
                                            ['title'] ??
                                        "title";
                                    description = bookmark[index.toString()]
                                            ['id']['description'] ??
                                        "description";
                                    url = bookmark[index.toString()]['id']
                                            ['url'] ??
                                        "url";
                                    urltoimage = bookmark[index.toString()]
                                            ['id']['urltoimage'] ??
                                        "image";
                                    publishedat = bookmark[index.toString()]
                                            ['id']['publishedAt'] ??
                                        "publishedat";
                                    content = bookmark[index.toString()]['id']
                                            ['content'] ??
                                        "content";

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
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
                                        bookmark[index.toString()]['id']
                                            ['urltoimage']),
                                  ),
                                  title: Text(bookmark[index.toString()]['id']
                                      ['title']),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          '- ${bookmark[index.toString()]['id']['author']}'),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 3,
                                  indent: 75,
                                )
                              ],
                            )
                          : Container();
                    })
              ],
            ),
    );
  }
}
