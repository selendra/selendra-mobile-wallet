import 'dart:async';

/* Package of flutter */
import 'package:intl/intl.dart';

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