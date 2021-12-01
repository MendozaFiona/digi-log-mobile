import 'package:digi_logbook/essentials/small_widgets.dart';
import 'package:digi_logbook/essentials/ustp_locations.dart';
import 'package:digi_logbook/essentials/widget_methods.dart';
import 'package:digi_logbook/directions_repository.dart';
import 'package:digi_logbook/json_models/get_offices.dart';
import 'package:digi_logbook/services/offices_service.dart';
import 'package:flutter/material.dart';
import 'package:digi_logbook/general_pages/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapSearch extends MapScreen {
  @override
  _MapSearchState createState() => _MapSearchState();
}

class _MapSearchState extends MapScreenState {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: searchBarController,
      hint: 'Search Location...',
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      debounceDelay: Duration(milliseconds: 500),
      onQueryChanged: (query) {
        setState(() {
          filteredVisibleLocs = filterLocs(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          selectedTerm = query;
        });
        searchBarController.close();
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Builder(builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredVisibleLocs
                      .map<Widget>((term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(Icons.place),
                            onTap: () async {
                              super.setState(() {
                                selectedTerm = term;
                                var _key = findLoc(term);
                                double _lat = buildingLoc[_key]['latitude'];
                                double _long = buildingLoc[_key]['longitude'];
                                LatLng _latLng = LatLng(_lat, _long);
                                destPos = _latLng;

                                dest = null;
                                infoDirect = null;

                                MapPopUp mapPopUp = MapPopUp();

                                setState(() {
                                  //super.setOriginalPosition();
                                  print(origPos);
                                  dest = Marker(
                                    markerId: MarkerId('destination'),
                                    infoWindow:
                                        InfoWindow(title: 'destination'),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRed),
                                    position: destPos,
                                    draggable: false,
                                    onTap: () {
                                      mapPopUp._getOffices(int.parse(_key),
                                          context, term); // this is bldg num
                                    },
                                  );
                                });
                              });
                              // Get directions
                              print('before directions:' + origPos.toString());
                              final directions = await DirectionsRepository()
                                  .getDirections(
                                      origin: origPos, destination: destPos);
                              setState(() => infoDirect = directions);
                              searchBarController.close();
                            },
                          ))
                      .toList(),
                );
              })),
        );
      },
    );
  }
}

class MapPopUp extends MapSearch {
  _getOffices(int bldg, context, label) async {
    WillPopScope alert = buildingOffices(bldg, context, label);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  buildingOffices(bldg, context, label) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          insetPadding: EdgeInsets.all(10),
          title: Text(label),
          content: officesColumn(bldg),
          actions: [
            okButton(context),
          ],
        ));
  }

  officesColumn(bldg) {
    return FutureBuilder<List<OfficeInfo>>(
      future: getOffices(bldg),
      builder: (context, snapshot) {
        double fullHeight = MediaQuery.of(context).size.height;
        double fullWidth = MediaQuery.of(context).size.width;

        if (snapshot.hasData) {
          return Container(
            height: fullHeight * 0.3,
            width: fullWidth * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < snapshot.data.length; i++)
                    officeTile(
                      name: snapshot.data[i].name,
                      floor: snapshot.data[i].floor.toString(),
                      status: snapshot.data[i].status,
                      boxWidth: fullWidth,
                    ),
                ],
              ),
            ),
          );
        }
        return Container(
            padding: EdgeInsets.only(top: fullHeight * 0.02),
            height: fullHeight * 0.05,
            child: Center(child: Text('No offices available')));
      },
    );
  }

  officeTile({name, floor, status, boxWidth}) {
    var mainColor = Color.fromRGBO(25, 24, 81, 1);
    var circleColor = Colors.green;

    if (status == 'offline') {
      circleColor = Colors.grey;
    }
    return Container(
      decoration: tileStyle(mainColor),
      padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
      child: Center(
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 5,
                  child: Container(
                    width: (boxWidth / 8) * 5,
                    child: Text(
                      name,
                      style: officeFont(),
                    ),
                  )),
              VerticalDivider(
                color: Color.fromRGBO(253, 180, 23, 1),
                thickness: 2,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Floor Level: " + floor,
                      style: officeFont(),
                    ),
                    Divider(
                      thickness: 2,
                      color: mainColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          status,
                          style: officeFont(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: circleColor,
                            shape: BoxShape.circle,
                          ),
                          child: null,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tileStyle(color) {
    return BoxDecoration(
        border: Border(top: BorderSide(width: 2, color: color)));
  }

  officeFont() {
    return TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontFamily: 'Roboto',
    );
  }
}
