import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:digi_logbook/json_models/get_offices.dart';

import 'config.dart';

List<OfficeInfo> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<OfficeInfo>((json) => OfficeInfo.fromJson(json)).toList();
}

Future<List<OfficeInfo>> getOffices(int bldg) async {
  var response = await http.get(Uri.parse('$API_URL/get_offices/$bldg'));
  if (response.statusCode == 200) {
    //var decoded = jsonDecode(response.body.toString());
    return parseData(response.body);
  } else if (response.statusCode == 204) {
    return null;
  } else {
    throw Exception('An error occured while fetching data');
  }
}
