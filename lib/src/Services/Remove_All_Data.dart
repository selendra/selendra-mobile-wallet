import 'package:shared_preferences/shared_preferences.dart';

clearStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
}