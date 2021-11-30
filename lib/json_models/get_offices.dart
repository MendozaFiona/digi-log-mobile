class OfficeInfo {
  final int id;
  final String name;
  final int buildingNum;
  final String status;

  OfficeInfo({this.id, this.name, this.buildingNum, this.status});
  factory OfficeInfo.fromJson(Map<String, dynamic> json) {
    return OfficeInfo(
      id: json['id'],
      name: json['name'],
      buildingNum: json['building_num'],
      status: json['status'],
    );
  }
}
