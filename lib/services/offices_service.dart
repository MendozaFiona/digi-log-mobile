import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:digi_logbook/json_models/get_offices.dart';

import 'config.dart';

Future<List<EntryInfo>> getEntries(String bldg) async {
  var response = await http.get(Uri.parse('$API_URL/offices/$bldg'));
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    return List<EntryInfo>.from(
        decoded['data'].map((e) => EntryInfo.fromJson(e)));
  } else {
    throw Exception('An error occured when fetching entries');
  }
}
