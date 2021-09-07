import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: SelectBranch(),
    ));

class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // no appbar
      body: Center(
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('CDO'),
        backgroundColor: Color.fromRGBO(243, 233, 211, 1),
      ),
    );
  }
}
