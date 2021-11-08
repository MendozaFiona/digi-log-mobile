import 'dart:io';

import 'package:digi_logbook/general_pages/code_qr.dart';
import 'small_widgets.dart';
import 'ustp_locations.dart';

import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';

optionResponse(context, _imgMap, _optionText, _title, _imageCode, _imgPick,
    _userSaveImage) {
  // For Pages Navigation
  if (_optionText == 'Cagayan de Oro') {
    Navigator.pushNamed(context, '/visitUSTP');
  } else if (_optionText == 'View Map') {
    Navigator.pushNamed(context, '/mapNav');
  } else if (_optionText == 'Show QR Code') {
    Navigator.pushNamed(context, '/showQR');
  } else if (_optionText == 'Register QR Code') {
    Navigator.pushNamed(context, '/regQR');
  }

  // Registering QR Code
  else if (_optionText == 'Pick Gallery') {
    _imgPick();
  } else if (_optionText == 'Save') {
    if (_imageCode == null || _title == '') {
      return null;
    } else {
      registerPrompt(context, _title, _imageCode, _userSaveImage);
    }
  } else {
    codePrompt(context, _imgMap, _optionText, _title);
  }
}

codePrompt(context, _imgMap, _optionText, _title) {
  for (var filename in _imgMap.entries) {
    if (filename.key == _optionText) {
      print(filename.value);
      WillPopScope alert = dialogPrompt(
          context,
          "Title: " + filename.key,
          Image.file(
            File(filename.value),
            width: 800,
            height: 350,
          ));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      break;
    }
  }
}

registerPrompt(context, _title, _imageCode, [_userSaveImage]) {
  if (checkTitle(_title)) {
    WillPopScope alert = dialogPrompt(context, "Duplicate Title",
        "Title is a duplicate of an existing saved image. Please rename.");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } else {
    print('error here maybe');
    WillPopScope alert =
        dialogPrompt(context, "Image Saved", "Image Successfully Saved.");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    print("passed dialogPrompt");
    _userSaveImage(_imageCode, titleController.text);
  }
}

promptContentType([_content, needProperty]) {
  if (_content.runtimeType == String) {
    if (needProperty == "content") {
      return Text(_content);
    } else {
      return EdgeInsets.all(20);
    }
  } else {
    if (needProperty == "content") {
      return _content;
    } else {
      return EdgeInsets.all(5);
    }
  }
}

bool checkTitle(_title) {
  final _imgDir = _title;
  List dirList = directoryList(directory);
  String _filename;
  bool _doesExist = false;

  for (var i = 0; i < dirList.length; i++) {
    _filename = path.basenameWithoutExtension(dirList[i]);
    if (_filename == _imgDir) {
      _doesExist = true;
      break;
    }
  }

  return _doesExist;
}

// ignore: missing_return
String findLoc(_term) {
  for (String num in buildingLoc.keys) {
    if (buildingLoc[num]['name'] == _term) {
      return num;
    }
  }
}
