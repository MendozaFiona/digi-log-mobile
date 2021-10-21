import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage(_this, _setState) async {
  try {
    final imageCode =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageCode == null) return;

    final imageTemporary = File(imageCode.path);
    _setState(() => _this.imageCode = imageTemporary);

    return imageCode;
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
}
