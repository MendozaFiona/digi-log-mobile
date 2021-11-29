class EntryInfo {
  final String id;
  final String name;
  final int buildingNum;
  final String status;

  EntryInfo({this.id, this.name, this.buildingNum, this.status});
  factory EntryInfo.fromJson(Map<String, dynamic> json) {
    return EntryInfo(
      id: json['id'],
      name: json['name'],
      buildingNum: json['building_num'],
      status: json['status'],
    );
  }
}
