import 'package:digi_logbook/main.dart';
import 'package:flutter/material.dart';

SafeArea mapBody(_title) {
  // i think dapat i array ning optionText
  return SafeArea(
    child: Column(children: [
      Flexible(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(bottom: 40.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(25, 24, 81, 1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            child: Align(
              //optional
              alignment: Alignment.bottomCenter,
              child: Text(_title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  )),
            ),
          )),
      
      Flexible(
          flex: 11,
          child: Center(
              child: Container(
                color: Colors.red,
      ))),
      
      Flexible(
          flex: 2,
          child: Center(
              child: Container(
                color: Colors.green,
      )))
    ]),
  );
}

SafeArea bodyFormat(context, _title, _textList, _functOption) {
  // i think dapat i array ning optionText
  return SafeArea(
    child: Column(children: [
      Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(bottom: 40.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(25, 24, 81, 1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            child: Align(
              //optional
              alignment: Alignment.bottomCenter,
              child: Text(_title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  )),
            ),
          )),
      Flexible(
          flex: 1,
          child: Center(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 40),

                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.15),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Spacer()
                      if(_functOption == 'optSect')
                        optionSection(context, _textList),
                      if(_functOption == 'fillForm')
                        fillupForm(context, _textList)

                    ],
                  ))))
    ]),
  );
}

Column optionSection(context, _optionList){
  return Column(
    children: [
      for (var options in _optionList)
        optionsLight(context, options.toString()),
    ]);
}

Column fillupForm(context, _formTitle){
  return Column(children: [      
      Text(_formTitle,
        style: TextStyle(
          fontSize: 23,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        )),
      SizedBox(height: 15),

      Container(
        height: 40,
        width: 250,
        child: TextFormField(
          style: TextStyle(
            fontSize: 20.0, 
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:Color.fromRGBO(25, 24, 81, 1),
              ),
              borderRadius: BorderRadius.circular(10.0)
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          ),
        ),
      ),

      SizedBox(height: 15),
      optionsLight(context, 'Submit')
    ],
  );
}

ElevatedButton optionsLight(context, _optionText) {
  return ElevatedButton(
    onPressed: () {
      if(_optionText == 'Cagayan de Oro'){
        Navigator.popAndPushNamed(context,'/visitUSTP');
      }
      else if(_optionText == 'View Map'){
        Navigator.popAndPushNamed(context,'/inputName');
      }
      else if(_optionText == 'Submit'){
        Navigator.popAndPushNamed(context,'/mapNav'); 
      }
    },
    child: Text(_optionText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Roboto',
        )),
    style: ElevatedButton.styleFrom(
      minimumSize: Size(240, 40),
      primary: Color.fromRGBO(243, 233, 211, 1),
      side: BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    ),
  );
}
