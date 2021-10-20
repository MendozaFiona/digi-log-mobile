import 'dart:async';

import 'package:image_picker/image_picker.dart';

import 'directions_model.dart';
import 'essentials.dart';

import 'package:digi_logbook/directions_repository.dart';
import 'package:location/location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/foundation.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
      initialRoute: '/',
      routes: {
        '/': (context) => SelectBranch(),
        '/visitUSTP': (context) => VisitUSTP(),
        '/mapNav': (context) => MapScreen(),
      },
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

  Future pickImage() async {
    await ImagePicker().pickImage(
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFormat(context, 'Visit USTP CDO', optionList, 'optSect'),
    );
  }
}

/*class RegisterCode extends StatefulWidget {
  //const RegisterCode({ Key? key }) : super(key: key);

  @override
  _RegisterCodeState createState() => _RegisterCodeState();
}

class _RegisterCodeState extends State<RegisterCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}*/

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    initConnectivity();
    permitLocation();
    super.initState();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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

    _locationData = await location.getLocation();
  }

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  popMapNav() {
    Navigator.pop(context);
  }

  internetChangePrompt() {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        popMapNav();
      },
    );

    WillPopScope alert = WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: Text("Internet Connection Required"),
          content: Text(
              "The routing feature requires Internet connection to function properly. Please turn on your Internet."),
          actions: [
            okButton,
          ],
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  initConnectivity() async {
    ConnectivityResult result;

    print("passes initConnectivity");

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
      } else {
        internetChangePrompt();
      }
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (_connectionStatus == ConnectivityResult.none) {
        internetChangePrompt();
      }
    });
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.484795864552531, 124.65660721180254),
    zoom: 21.0,
  );

  GoogleMapController _googleMapController;
  Marker _origin; // 4now
  Marker _destination; // 4now
  Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final defaultWidth = MediaQuery.of(context).size.width;
    final defaultHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 24, 81, 1),
        centerTitle: true, // positioning of title
        automaticallyImplyLeading: false, // removes back button
        title: Text('Google Maps'),
      ),
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Stack(alignment: Alignment.center, children: [
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
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    )
                },
                onLongPress: _addMarker,
                // 4now
              ),
              if (_info != null)
                Positioned(
                  bottom: defaultHeight / 6 + 10.0,
                  child: navDetails(_info, defaultWidth),
                ),
            ]),
          ),
          Positioned(
              top: 10,
              height: defaultHeight,
              width: defaultWidth,
              child: mapSearchBar(isPortrait)),
          Positioned(
              bottom: 0,
              height: defaultHeight / 6,
              width: defaultWidth,
              child: Container(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 24, 81, 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          txtButtonDefault(
                              _googleMapController, _origin, 'ORIGIN'),
                          txtButtonDefault(
                              _googleMapController, _destination, 'DEST.'),
                        ],
                      ),
                      optionsDark(context, 'Show QR Code')
                    ]),
              )),
        ]),
      ),
    );
  }

  //4now
  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;
        _info = null; // 4now
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }
  //4now
}
