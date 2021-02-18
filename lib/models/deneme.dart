/*
import 'dart:convert';

import 'package:currency_app/models/currency.dart';
import 'package:http/http.dart' as http;

Future<USD> apiCall() async {
  final response =
      await http.get(Uri.https('finans.truncgil.com', 'v2/today.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return USD.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
*/
