import 'widget_methods.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

final titleController = TextEditingController();

setControllerText() {
  titleController.text = '';
}

Container inputField(_imageCode) {
  bool enableField = false;

  @override
  void dispose() {
    titleController.dispose();
    dispose(); // is this right?
  }

  if (_imageCode != null) {
    enableField = true;
  }

  setControllerText(); // remove text when back is pressed

  return Container(
    height: 40,
    width: 240,
    child: TextFormField(
      controller: titleController,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        hintText: 'Title',
        enabled: enableField,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(25, 24, 81, 1),
            ),
            borderRadius: BorderRadius.circular(10.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      ),
    ),
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

ElevatedButton optionsLight(context,
    [_imgMap, _optionText, _imgPick, _imageCode, _userSaveImage]) {
  return ElevatedButton(
    onPressed: () {
      optionResponse(context, _imgMap, _optionText, titleController.text,
          _imageCode, _imgPick, _userSaveImage);
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
    onPressed: () {},
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

TextButton okButton(context, [_additionalFunct]) {
  return TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        if (_additionalFunct != null) {
          _additionalFunct();
        }
      });
}

WillPopScope dialogPrompt(context, _headTxt, _content, [_additionalFunct]) {
  return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: promptContentType(_content, "inpadding"),
        title: Text(_headTxt),
        content: promptContentType(_content, "content"),
        actions: [
          if (_additionalFunct != null) okButton(context, _additionalFunct),
          if (_additionalFunct == null) okButton(context)
        ],
      ));
}

Container navDetails(_info, defaultWidth) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
    width: defaultWidth / 1.5,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.grey),
    ),
    child: Text(
      'Destination: Sample Destination\nDistance: ${_info.totalDistance}, ${_info.totalDuration}',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
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
