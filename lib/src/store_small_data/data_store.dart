import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

/* Save to XML file in System */
String _decode;
SharedPreferences _preferences;

Future<SharedPreferences> setData (dynamic _data, String _path) async {
  _preferences = await SharedPreferences.getInstance();
  _decode = jsonEncode(_data);
  _preferences.setString(_path, _decode);
  return _preferences;
}

Future<SharedPreferences> setUserID(String _data, String _path) async {
  _preferences = await SharedPreferences.getInstance();
  _decode = jsonEncode(_data);
  _preferences.setString(_path, _decode);
  return _preferences;
}

Future<dynamic>fetchData(String _path) async {
  _preferences = await SharedPreferences.getInstance();
  var _data = _preferences.getString(_path);
  if ( _data == null ) return null;
  else {
    return json.decode(_data);
  }
}

Future<String> fetchId(String _path) async {
  _preferences = await SharedPreferences.getInstance();
  _decode = jsonDecode(_preferences.getString(_path));
  return _decode;
}