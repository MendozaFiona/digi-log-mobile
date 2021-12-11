import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:digi_logbook/json_models/get_coordinates.dart';

import 'config.dart';

List<CoordinatesInfo> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<CoordinatesInfo>((json) => CoordinatesInfo.fromJson(json))
      .toList();
}

Future<List<CoordinatesInfo>> getCoordinatess(String name) async {
  var response = await http.get(Uri.parse('$API_URL/get_coordinates/$name'));
  if (response.statusCode == 200) {
    return parseData(response.body);
  } else if (response.statusCode == 204) {
    return null;
  } else {
    throw Exception('An error occured while fetching data');
  }
}
