import 'package:flutter/material.dart';
import 'small_widgets.dart';
import 'sections.dart';

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
    //mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(25, 24, 81, 1),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          ),
          child: upperContent('Saved QR Images', 'optSect'),
        ),
      ),
      Flexible(
        flex: 1,
        child: Center(
          child: SingleChildScrollView(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_imgMap != null)
                        for (var title in _imgMap.keys)
                          optionsLight(context, _imgMap, title),
                      if (_imgMap.isEmpty)
                        Text(
                          'no images saved yet.',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontSize: 18,
                          ),
                        )
                    ],
                  ),
                )),
          ),
        ),
      )
    ],
  ));
}
