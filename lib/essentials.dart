import 'dart:ffi';

import 'package:digi_logbook/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

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
                      if (_functOption == 'optSect')
                        optionSection(context, _textList),
                      if (_functOption == 'fillForm')
                        fillupForm(context, _textList)
                    ],
                  ))))
    ]),
  );
}

Column optionSection(context, _optionList) {
  return Column(children: [
    for (var options in _optionList) optionsLight(context, options.toString()),
  ]);
}

Column fillupForm(context, _formTitle) {
  return Column(
    children: [
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(25, 24, 81, 1),
                ),
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          ),
        ),
      ),
      SizedBox(height: 15),
      optionsLight(context, 'Submit')
    ],
  );
}

TextButton txtButtonDefault(cntrlr, pos, title) {
  bool _isBtnEnabled = false;

  if (pos != null) {
    _isBtnEnabled = true;
  }

  return TextButton(
    onPressed: _isBtnEnabled
        ? () => cntrlr.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: pos.position,
                  zoom: 21.0,
                  tilt: 50.0,
                ),
              ),
            )
        : null,
    style: TextButton.styleFrom(
      primary: Colors.white,
      textStyle: TextStyle(
        letterSpacing: 3.0,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    child: Text(title),
  );
}

ElevatedButton optionsLight(context, _optionText) {
  return ElevatedButton(
    onPressed: () {
      if (_optionText == 'Cagayan de Oro') {
        Navigator.pushNamed(context, '/visitUSTP');
      } else if (_optionText == 'View Map') {
        Navigator.pushNamed(context, '/inputName');
      } else if (_optionText == 'Submit') {
        Navigator.pushNamed(context, '/mapNav');
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

ElevatedButton optionsDark(context, _optionText) {
  return ElevatedButton(
    onPressed: () {
      if (_optionText == 'Cagayan de Oro') {
        Navigator.pushNamed(context, '/visitUSTP');
      } else if (_optionText == 'View Map') {
        Navigator.pushNamed(context, '/inputName');
      } else if (_optionText == 'Submit') {
        Navigator.pushNamed(context, '/mapNav');
      }
    },
    child: Text(_optionText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Roboto',
        )),
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(253, 180, 23, 1),
      side: BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    ),
  );
}

FloatingSearchBar mapSearchBar(isPortrait) {
  return FloatingSearchBar(
    hint: 'Search...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
