import 'package:flutter/material.dart';
import 'essentials.dart';
//import 'dart:async';
//import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
      //home: SelectBranch(),
      //home: VisitUSTP(),
      //home: InputName(),
      home: MapNav(),
    ));

//maybe move this to pages folder under visitor
class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat('Select BRANCH', 'Cagayan de Oro', 'optSect'),
    );
  }
}

class VisitUSTP extends StatelessWidget {
  VisitUSTP({List<String> optionList})
      : this.optionList = optionList ?? ['View Map', 'Scan Office QR Code'];
  final List<String> optionList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat('Visit USTP CDO', optionList, 'optSect'),
    );
  }
}

class InputName extends StatefulWidget {
  //const InputName({ Key? key }) : super(key: key);

  @override
  _InputNameState createState() => _InputNameState();
}

class _InputNameState extends State<InputName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat('Visit USTP CDO', 'Please Input Your Name', 'fillForm'),
    );
  }
}

class MapNav extends StatefulWidget {
  //const InputName({ Key? key }) : super(key: key);

  @override
  _MapNavState createState() => _MapNavState();
}

class _MapNavState extends State<MapNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapBody('Testing Map Body Title'),
    );
  }
}

/* uncomment once gmaps free trial starts
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.484795864552531, 124.65660721180254),
    zoom: 21.0,
  );

  GoogleMapController _googleMapController;

  @override
  void dispose(){
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
      ),
    );
  }
}

*/

