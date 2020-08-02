import 'package:wallet_apps/index.dart';

class StorageServices{

  static String _decode;
  static SharedPreferences _preferences;

  static Future<SharedPreferences> setData(dynamic _data, String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonEncode(_data);
    _preferences.setString(_path, _decode);
    return _preferences;
  }

  static Future<SharedPreferences> setUserID(String _data, String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonEncode(_data);
    _preferences.setString(_path, _decode);
    return _preferences;
  }

  static Future<dynamic>fetchData(String _path) async {
    _preferences = await SharedPreferences.getInstance();
    var _data = _preferences.getString(_path);
    if ( _data == null ) return null;
    else {
      return json.decode(_data);
    }
  }

  static Future<void> removeKey(String path) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.remove(path);
  }

  static Future<String> fetchId(String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonDecode(_preferences.getString(_path));
    return _decode;
  }
}