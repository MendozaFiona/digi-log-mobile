import 'package:flutter/material.dart';
import 'essentials.dart';
import 'package:location/location.dart';
//import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

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
        //'/mapNav': (context) => MapNav(),
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
      : this.optionList =
            optionList ?? ['View Map', 'Show QR Code', 'Register QR Code'];
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
        return Navigator.pop(context);
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
  Marker _origin; // 4now
  Marker _destination; // 4now

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final defaultWidth = MediaQuery.of(context).size.width;
    final defaultHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Stack(children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                // 4now
                markers: {
                  if (_origin != null) _origin,
                  if (_destination != null) _destination
                },
                // 4now
              ),
              Positioned(
                  top: defaultHeight / 10 + 5, child: mapSearchBar(isPortrait))
            ]),
          ),
          Positioned(
              top: 0,
              height: defaultHeight / 10,
              width: defaultWidth,
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 24, 81, 1),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50)),
                ),
              )),
          Positioned(
              bottom: 0,
              height: defaultHeight / 10,
              width: defaultWidth,
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 24, 81, 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
              )),
          /*Positioned(
            top: 80,
            width: defaultWidth,
            child: mapSearchBar(isPortrait),
          ),*/
        ]),
      ),
    );
  }
}
