import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: SelectBranch(),
    ));

class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // no appbar
      body: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.fromLTRB(5.0, 7.0, 3.0, 4.0),
        color: Colors.blue[400],
        child: Text(''),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('CDO'),
        backgroundColor: Color.fromRGBO(243, 233, 211, 1),
      ),
    );
  }
}

/*
Center(
  child: Text(
    'Select Branch',
    style: TextStyle(
      //fontSize: ,
      //fontWeight: FontWeight.bold,
      //letterSpacing: 2.0,
      //color: Colors.grey[600],
      fontFamily: 'Nunito',
    ),
  ),
),
*/