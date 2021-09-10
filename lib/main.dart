import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253,180,23,1)),
    home: SelectBranch(),
    ));

class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [Row(

            children: [

              Flexible(child:Container(
                padding: EdgeInsets.all(10.0),
                //margin: EdgeInsets.fromLTRB(5.0, 7.0, 3.0, 4.0),
                color: Color.fromRGBO(25, 24, 81,1),

                child: Text('Select BRANCH',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: 1.0,
                    color: Colors.white,
                    fontFamily: 'Nunito',)
                ),
              )),

            ] //children

          ),
          ElevatedButton(
              onPressed: () {},
              
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('Cagayan de Oro',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Roboto',)
               )
              ),

              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(243,233,211,1),
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
              
            )
          ]
        ),
      )
    );
  }
}