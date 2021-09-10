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
          children: [
            
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                
                decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 24, 81,1),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                ),

                child: Align( //optional
                  alignment: Alignment.bottomCenter,
                  child: Text('Select BRANCH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    )
                  ),
                ),
              )
            ),
            
            Flexible(
              flex: 5,
              child: Center(
              
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 80, horizontal: 40),
                //need ba icolumn??? for equal box sizing throughout
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: ElevatedButton(
                  onPressed: () {},
                  
                  child: Text('Cagayan de Oro',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Roboto',)
                  ),

                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(240,40),
                    primary: Color.fromRGBO(243,233,211,1),
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  
                )
              ))
            )
          ]
        ),
      )
    );
  }
}