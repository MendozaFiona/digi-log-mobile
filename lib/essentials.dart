import 'package:flutter/material.dart';

SafeArea bodyFormat(_title, _optionList) {
  // i think dapat i array ning optionText
  return SafeArea(
    child: Column(children: [
      Expanded(
          flex: 5,
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
          flex: 5,
          child: Center(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  //need ba icolumn??? for equal box sizing throughout
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.15),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  //i think dayon dapat i loop ni siya if array/list ang options and probably isulod ug column widget
                  child: Column(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          for (var options in _optionList)
                            optionsLight(options.toString()),
                        ],
                      ),
                      Spacer(),
                    ],
                  ))))
    ]),
  );
}

ElevatedButton optionsLight(_optionText) {
  return ElevatedButton(
    onPressed: () {},
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
