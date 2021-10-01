/*

# backup

Column(children: [
  Flexible(
      flex: 2,
      child: Container(
        padding: EdgeInsets.only(bottom: 40.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(25, 24, 81, 1),
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        /*child: Align(
          //optional
          alignment: Alignment.bottomCenter,
          child: Text('You Are Now Visiting USTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              )),
        ),*/
      )),
  Flexible(
    flex: 20,
    child: Stack(children: [
      Center(
        child: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) =>
              _googleMapController = controller,
          // 4now
          markers: {
            if (_origin != null) _origin,
            if (_destination != null) _destination
          },
          // 4now
        ),
      ),
      mapSearchBar(isPortrait),
    ]),
  ),
  Flexible(
      flex: 3,
      child: Center(
          child: Container(
        padding: EdgeInsets.only(bottom: 40.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(25, 24, 81, 1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
      )))
]),

# FOR IMAGES:
# make sure to put in pubspec.yaml
# in the body: Center: child

Image(
  image: NetworkImage('url')
  or
  image: AssetImage('path')
),

#shortened
Image.asset or Image.network

# FOR ICONS:

Icon(
  Icons.airport_shuttle,
  color: Color.fromRGBO(),
  size: 50.0
)

# For Buttons

or FlatButton - deprecated use TextButton
RaisedButton( - deprecated use ElevatedButton
  onPressed: () {},
  child: Text(''),
  color: Color.fromRGBO
)

# if inside has icon

RaisedButton.icon( -use elevated
  onPressed: () {},
  icon: Icon(
    Icons.mail
  ),
  Label: Text(''),
  color: ,
)

# icon button
IconButton(
  onPressed() {},
  icon: Icon(Icons.dadada),
  color: Color.,
)

# floating buttons
floatingActionButton: FloatingActionButton(
  onPressed: () {},
  child: Text('CDO'),
  backgroundColor: Color.fromRGBO(243, 233, 211, 1),
),

# for spaces between paragraphs/text
SizedBox(height: xx)

# horizontal line
Divider(
  height: ,
  color:
)

*/