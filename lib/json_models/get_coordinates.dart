class CoordinatesInfo {
  final int bldgNum;
  final String bldgName;
  final String latitude;
  final String longitude;

  CoordinatesInfo({this.bldgNum, this.bldgName, this.latitude, this.longitude});
  factory CoordinatesInfo.fromJson(Map<String, dynamic> json) {
    return CoordinatesInfo(
      bldgNum: json['id'],
      bldgName: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
