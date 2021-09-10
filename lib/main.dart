import 'package:flutter/material.dart';
import 'essentials.dart';

void main() => runApp(MaterialApp(
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
      //home: SelectBranch(),
      home: VisitUSTP(),
    ));

//maybe move this to pages folder under visitor
class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat('Select BRANCH', ['Cagayan de Oro']),
    );
  }
}

class VisitUSTP extends StatelessWidget {
  VisitUSTP({List<String> optionList})
      : this.optionList = optionList ?? ['View Map', 'Scan Office QR Code'];
  final List<String> optionList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat('Visit USTP CDO', optionList),
    );
  }
}
