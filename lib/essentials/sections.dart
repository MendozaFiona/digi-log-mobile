import 'package:flutter/material.dart';
import 'small_widgets.dart';

Column optionSection(context,
    [_optionList, _imgPick, _imageCode, _userSaveImage]) {
  return Column(children: [
    for (var options in _optionList)
      optionsLight(context, null, options.toString(), _imgPick, _imageCode,
          _userSaveImage),
  ]);
}

Align upperContent(_title, [_functOption, _imageCode]) {
  if (_functOption == 'optSect') {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(_title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Nunito',
          )),
    );
  } else {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: [
        Spacer(),
        _imageCode != null
            ? Image.file(
                _imageCode,
                width: 350,
                height: 300,
              )
            : Text(
                'no image set',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontSize: 18,
                ),
              )
      ]),
    );
  }
}
