import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void clearStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
}

int timeStampConvertor(String userDate){ /* Convert date to timestamp */
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = dateFormat.parse(userDate);
  return dateTime.millisecondsSinceEpoch;
}

String timeStampToDateTime(String timeStamp){ /* Convert Time Stamp To Date time ( Format yyyy-MM-ddTHH:mm:ssZ ) */
  DateTime parse = DateTime.parse(timeStamp).toUtc(); /* Parse Time Stamp String to DateTime Format */
  return formatDate(parse, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]); /* Return Real Date Time */
}

void timer(Function fc, int period) async { /* Timer */
  Timer(Duration(seconds: period), (){
    fc();
  });
}

int convertHexaColor(String colorhexcode){ /* Convert Hexa Color */
  String colornew = '0xff' + colorhexcode;
  colornew = colornew.replaceAll('#', '');
  int colorint = int.parse(colornew);
  return colorint;
}