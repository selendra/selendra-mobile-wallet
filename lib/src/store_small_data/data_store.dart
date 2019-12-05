import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

/* Save to XML file in System */

Future<SharedPreferences> setData (Map<String, dynamic> data, String directory) async {
  String convert = jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(directory, convert);
  return prefs;
}

Future<SharedPreferences> setUserID(String data, String directory) async {
  String convert = jsonEncode(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(directory, convert);
  return prefs;
}

Future<Map<String, dynamic>>fetchData(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.getString(path);
  if ( data == null ) return null;
  else {
    Map<String, dynamic> dataParse = json.decode(data);
    return dataParse;
  }
}

Future<String> fetchId(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = jsonDecode(prefs.getString(path));
  return id;
}