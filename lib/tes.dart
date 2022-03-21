import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tes extends StatefulWidget {
  const Tes({Key? key}) : super(key: key);

  @override
  _TesState createState() => _TesState();
}

class _TesState extends State<Tes> {
  void initState() {
    String link =
        'https://play.google.com/store/apps/details?id=com.argutes.smartlearning';
    check(link);
    super.initState();
  }

  check(String data) {
    _makinglinkpage(data);
  }

  _makinglinkpage(String link) async {
    var url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not connect';
    }
  }

  Widget build(BuildContext context) {
    Navigator.of(context).pop();
    return Container();
  }
}
