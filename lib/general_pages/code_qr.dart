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
    return Scaffold(body: Center(child: savedImages(context, imgMap)));
  }
}

class RefreshCode extends ShowCode {
  //const RefreshCode({ Key? key }) : super(key: key);

  @override
  _RefreshCodeState createState() => _RefreshCodeState();
}

class _RefreshCodeState extends _ShowCodeState {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (imgMap != null) {
      super.setState(() {
        initImages();
        Future.delayed(Duration.zero, () {
          Navigator.popAndPushNamed(context, "/showQR");
        });
        //Navigator.pushNamed(context, "/showQR");
      });
    }
    return Container();
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
    final imagePermanent = await saveImagePermanently(_imageCode.path, _title);
    setState(() => this.imageCode = imagePermanent);
  }

  Future<File> saveImagePermanently(String imagePath, _title) async {
    final directory = await getDir();
    final ext = path.extension(imagePath);
    final name = _title + ext;
    final imageDir = '${directory.path}/$name';

    List dirList = directoryList(directory);

    for (var i = 0; i < dirList.length; i++) {
      if (dirList[i] == imageDir) {}
    }

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
var directory;

directoryList(directory) {
  List _dirList = directory
      .listSync()
      .map((item) => item.path)
      .where((item) => item.endsWith(".jpg") || item.endsWith(".png"))
      .toList(growable: false);

  return _dirList;
}

Future initImages() async {
  final directory = await getDir();

  imgMap.clear();
  List dirList = directoryList(directory);

  imgMap = Map.fromIterable(dirList,
      key: (item) => item.split('/').last, value: (item) => item);
}

Future deleteImage(filename) async {
  final directory = await getDir();
  final file = File('${directory.path}/$filename');

  await file.delete();
  initImages();
}

Future getDir() async {
  directory = await getApplicationDocumentsDirectory();
  return directory;
}
