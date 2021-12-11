class PlaceInfo {
  final String name;

  PlaceInfo({this.name});
  factory PlaceInfo.fromJson(Map<String, dynamic> json) {
    return PlaceInfo(
      name: json['name'],
    );
  }
}
