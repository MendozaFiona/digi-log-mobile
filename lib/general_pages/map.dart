import 'package:digi_logbook/essentials/ustp_locations.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../directions_model.dart';
import 'package:digi_logbook/essentials/small_widgets.dart';
import 'package:digi_logbook/essentials/search_bar.dart';

import 'package:digi_logbook/directions_repository.dart';
import 'package:location/location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

LatLng destPos;
LatLng origPos = LatLng(8.484795864552531, 124.65660721180254); //4NOW
//4NOW TEMP
Marker orig = Marker(
  markerId: MarkerId('origin'),
  infoWindow: InfoWindow(title: 'Origin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  position: origPos,
);
// 4now
Marker dest; // 4now
Directions infoDirect;
String selectedTerm;

class MapScreenState extends State<MapScreen> {
  List<String> _visibleLocs = [];

  // for showing terms according to what's currently typed
  List<String> filteredVisibleLocs;

  List<String> filterLocs({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _visibleLocs
          .where((term) => term.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    } else {
      return _visibleLocs.toList();
    }
  }

  void searchTerms() {
    // to avoid duplicates whenever this method is called
    _visibleLocs.clear();

    for (String num in buildingLoc.keys) {
      _visibleLocs.add(buildingLoc[num]['name']);
    }

    _visibleLocs.sort();

    filteredVisibleLocs = filterLocs(filter: null);
  }

  // for the search bar
  FloatingSearchBarController searchBarController;

  @override
  void initState() {
    initConnectivity();
    permitLocation();
    searchTerms();
    searchBarController = FloatingSearchBarController();
    filteredVisibleLocs = filterLocs(filter: null);
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
    WillPopScope alert = dialogPrompt(
        context,
        "Internet Connection Required",
        "The routing feature requires Internet connection to function properly. Please turn on your Internet.",
        popMapNav);

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
  //Marker _origin; // 4now
  //Marker _destination; // 4now
  //Directions _info;

  @override
  void dispose() {
    if (_googleMapController != null) {
      _googleMapController.dispose();
    }
    _connectivitySubscription.cancel();
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                // 4now - original
                //markers: {if (orig != null) orig, if (dest != null) dest},
                markers: {if (orig != null) orig, if (dest != null) dest},
                polylines: {
                  if (infoDirect != null)
                    Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: infoDirect.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    )
                },
                //onLongPress: _addMarker,
                // 4now
              ),
              Positioned(
                  bottom: 0,
                  height: defaultHeight / 6,
                  width: defaultWidth,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(25, 24, 81, 1),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              txtButtonDefault(
                                  _googleMapController, orig, 'ORIGIN'),
                              txtButtonDefault(
                                  _googleMapController, dest, 'DEST.'),
                            ],
                          ),
                          optionsDark(context, 'Show QR Code')
                        ]),
                  )),
              if (infoDirect != null)
                Positioned(
                  bottom: defaultHeight / 6 + 10.0,
                  child: navDetails(infoDirect, defaultWidth),
                ),
            ]),
          ),
          Positioned(
              top: 10,
              height: defaultHeight,
              width: defaultWidth,
              child: MapSearch()),
        ]),
      ),
    );
  }
}
