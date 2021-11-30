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
                                  dest = Marker(
                                    markerId: MarkerId('destination'),
                                    infoWindow:
                                        InfoWindow(title: 'destination'),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRed),
                                    position: destPos,
                                    onTap: () {
                                      mapPopUp._getOffices(int.parse(_key),
                                          context); // this is bldg num
                                    },
                                  );
                                });
                              });
                              // Get directions
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
  _getOffices(int bldg, context) async {
    WillPopScope alert = buildingOffices(bldg);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  buildingOffices(bldg) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          insetPadding: EdgeInsets.all(10),
          //contentPadding: ,
          title: Text('test title'),
          content: officesColumn(bldg),
          actions: [
            //if (_additionalFunct != null)
            //  okButton(context, _additionalFunct),
          ],
        ));
  }

  officesColumn(bldg) {
    return FutureBuilder<List<OfficeInfo>>(
      future: getOffices(bldg),
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data.length; i++) {
            print(snapshot.data[i].id);
          }

          return Column(
            children: [Text('test')],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
