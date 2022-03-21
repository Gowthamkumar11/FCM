import 'package:api_testing/tes.dart';
import 'package:flutter/material.dart';

class Firpage extends StatefulWidget {
  const Firpage({Key? key}) : super(key: key);

  @override
  _FirpageState createState() => _FirpageState();
}

class _FirpageState extends State<Firpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: const Icon(Icons.person_outlined),
            onTap: () {
              print('Firstpage');
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Tes()));
            },
          ),
        ],
        title: const Text('Firstpage'),
      ),
      // drawer: const Drawer(),
    );
  }
}
