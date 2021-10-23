import 'package:digi_logbook/essentials/page_format.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

class ShowCode extends StatefulWidget {
  //const ShowCode({ Key? key }) : super(key: key);

  @override
  _ShowCodeState createState() => _ShowCodeState();
}

class _ShowCodeState extends State<ShowCode> {
//SingleChildScrollView(child: savedImages(context, imgMap))
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(child: savedImages(context, imgMap))));
  }
}

//ignore: must_be_immutable
class RegisterCode extends StatefulWidget {
  //const RegisterCode({ Key? key }) : super(key: key);

  @override
  _RegisterCodeState createState() => _RegisterCodeState();
}

class _RegisterCodeState extends State<RegisterCode> {
  File imageCode;

  Future imgPick() async {
    try {
      final imageCode =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageCode == null) return;

      final imageTemporary = File(imageCode.path);
      setState(() => this.imageCode = imageTemporary);

      return imageCode;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future userSaveImage(_imageCode, _title) async {
    print('passed user Save Image');
    final imagePermanent = await saveImagePermanently(_imageCode.path, _title);
    setState(() => this.imageCode = imagePermanent);
  }

  Future<File> saveImagePermanently(String imagePath, _title) async {
    final directory = await getApplicationDocumentsDirectory();
    final ext = path.extension(imagePath);
    var name = _title + ext;
    var imageDir = '${directory.path}/$name';

    List dirList = directoryList(directory);

    for (var i = 0; i < dirList.length; i++) {
      if (dirList[i] == imageDir) {
        name = _title + '_copy' + ext;
        imageDir = '${directory.path}/$name';
        i = i - 1;
        continue;
      }
    }

    /*for (String _item in dirList) {
      if (_item == imageDir) {
        name = _title + '_copy' + ext;
        imageDir = '${directory.path}/$name';

        dirList.clear();
        dirList = directoryList(directory);
      }
    }*/

    final image = File(imageDir);

    initImages();

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: bodyFormat(context, '', ['Pick Gallery', 'Save'], 'input', imgPick,
          imageCode, userSaveImage),
    );
  }
}

// Outside Methods

var imgMap = new Map();

directoryList(directory) {
  List _dirList = directory
      .listSync()
      .map((item) => item.path)
      .where((item) => item.endsWith(".jpg") || item.endsWith(".png"))
      .toList(growable: false);

  return _dirList;
}

Future initImages() async {
  final directory = await getApplicationDocumentsDirectory();

  imgMap.clear();
  List dirList = directoryList(directory);

  imgMap = Map.fromIterable(dirList,
      key: (item) => item.split('/').last, value: (item) => item);

  print(imgMap);
}
