import 'package:flutter/material.dart';
import 'essentials.dart';
import 'package:location/location.dart';
//import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
      initialRoute: '/',
      routes: {
        '/': (context) => SelectBranch(),
        '/visitUSTP': (context) => VisitUSTP(),
        '/inputName': (context) => InputName(),
        '/mapNav': (context) => MapScreen(),
      },
      //home: VisitUSTP(),
      //home: InputName(),
      //home: MapNav(),
    ));

//maybe move this to pages folder under visitor
class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat(context, 'Select BRANCH', ['Cagayan de Oro'], 'optSect'),
    );
  }
}

class VisitUSTP extends StatelessWidget {
  VisitUSTP({List<String> optionList})
      : this.optionList = optionList ?? ['View Map'];
  final List<String> optionList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat(context, 'Visit USTP CDO', optionList, 'optSect'),
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
      body: bodyFormat(
          context, 'Visit USTP CDO', 'Please Input Your Name', 'fillForm'),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    permitLocation();
    super.initState();
  }

  permitLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Navigator.pop(context);
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    /*ValueListenableBuilder<bool>(
      valueListenable: ,
      builder: ,
    
    );*/

    _locationData = await location.getLocation();
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.484795864552531, 124.65660721180254),
    zoom: 21.0,
  );

  GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Flexible(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 24, 81, 1),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50)),
                ),
                child: Align(
                  //optional
                  alignment: Alignment.bottomCenter,
                  child: Text('You Are Now Visiting USTP',
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
              child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Center(
                  child: Container(
                color: Colors.green,
              )))
        ]),
      ),
    );
  }

  /*Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }*/
}
