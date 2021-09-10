/*
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

*/