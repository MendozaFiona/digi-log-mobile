import 'package:flutter/material.dart';
import 'essentials.dart';
//import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart"; 

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

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: ,
      ),
    );
  }
}

*/

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.mapbox.com/styles/v1/fgxmendoza/cku4vr9dx20fv18nzl1mqfg7q/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmd4bWVuZG96YSIsImEiOiJja3BicWRxYmYxMDQxMm9zY3Y3cTY4YWtiIn0.sM5y5SHRDZDirJVOw5fkug",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) =>
              Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

