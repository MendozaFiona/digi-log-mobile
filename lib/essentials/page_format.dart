import 'package:flutter/material.dart';
import 'small_widgets.dart';
import 'sections.dart';

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

SafeArea bodyFormat(context, _title, _optionList, _functOption,
    [_imgPick, _imageCode, _userSaveImage]) {
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
            child: upperContent(_title, _functOption, _imageCode),
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
                      if (_functOption == 'input') inputField(_imageCode),
                      if (_optionList != null)
                        optionSection(context, _optionList, _imgPick,
                            _imageCode, _userSaveImage)
                    ],
                  ))))
    ]),
  );
}

SafeArea savedImages(context, _imgMap) {
  return SafeArea(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(25, 24, 81, 1),
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50), top: Radius.circular(50)),
        ),
        child: Text('Saved QR Images',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Nunito',
            )),
      ),
      Container(
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
              if (_imgMap != null)
                for (var title in _imgMap.keys)
                  optionsLight(context, _imgMap, title),
            ],
          ))
    ],
  ));
}
