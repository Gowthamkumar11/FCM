import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Newspage extends StatefulWidget {
  Newspage({
    Key? key,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urltoimage,
    this.publishedat,
    this.content,
  }) : super(key: key);

  final author, title, description, url, urltoimage, publishedat, content;
  @override
  _NewspageState createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    print('author value ${widget.author}');
    print('title value ${widget.title}');
    print('description value ${widget.description}');
    print('url value ${widget.url}');
    print('urltoimage value ${widget.urltoimage}');
    print('publishedAt value ${widget.publishedat}');
    print('content value ${widget.content}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Newspage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.title} ',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '- ${widget.author} ',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Image.network(widget.urltoimage),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description - ${widget.description}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.content}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Read More >>'),
                  onPressed: () {
                    _launchURL(widget.url);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
