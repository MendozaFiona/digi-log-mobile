import 'essentials/page_format.dart';
import 'general_pages/map.dart';
import 'general_pages/code_qr.dart';

import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
      initialRoute: '/',
      routes: {
        '/': (context) => SelectBranch(),
        '/visitUSTP': (context) => VisitUSTP(),
        '/mapNav': (context) => MapScreen(),
        '/showQR': (context) => ShowCode(),
        '/regQR': (context) => RegisterCode(),
      },
    ));

class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat(context, 'Select BRANCH', ['Cagayan de Oro'], 'optSect'),
    );
  }
}

class VisitUSTP extends StatelessWidget {
  //const VisitUSTP({ Key? key }) : super(key: key);

  VisitUSTP({List<String> optionList})
      : this.optionList =
            optionList ?? ['View Map', 'Show QR Code', 'Register QR Code'];
  final List<String> optionList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat(context, 'Visit USTP CDO', optionList, 'optSect'),
    );
  }
}
