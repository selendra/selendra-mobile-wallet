import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void clearStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
}

/* Convert date to timestamp */
int timeStampConvertor(String userDate){
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = dateFormat.parse(userDate);
  return dateTime.millisecondsSinceEpoch;
}

/* Timer */
void timer(Function fc, int period) async {
  Timer(Duration(seconds: period), (){
    fc();
  });
}

/* Convert Hexa Color */
int convertHexaColor(String colorhexcode){
  String colornew = '0xff' + colorhexcode;
  colornew = colornew.replaceAll('#', '');
  int colorint = int.parse(colornew);
  return colorint;
}