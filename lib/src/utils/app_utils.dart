// This file hold Calculation And Data Convertion
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:wallet_apps/index.dart';

class AppUtils {

  static int timeStampConvertor(String userDate) {
    /* Convert date to timestamp */
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = dateFormat.parse(userDate);
    return dateTime.millisecondsSinceEpoch;
  }

  static String timeStampToDateTime(String timeStamp) { /* Convert Time Stamp To Date time ( Format yyyy-MM-ddTHH:mm:ssZ ) */
    DateTime parse = DateTime.parse(timeStamp).toLocal(); /* Parse Time Stamp String to DateTime Format */
    return formatDate(
      parse, 
      [ yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]
    ); /* Return Real Date Time */
  }

  static String timeStampToDate(String timeStamp){
    DateTime parse = DateTime.parse(timeStamp).toLocal(); /* Parse Time Stamp String to DateTime Format */
    return formatDate(
      parse, 
      [ yyyy, '/', mm, '/', dd]
    ); /* Return Real Date Time */
  }

  static int convertHexaColor(String colorhexcode) { /* Convert Hexa Color */
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  static int versionConverter(String _version) {
    String convert = _version.replaceAll(".", '');
    convert = convert.replaceAll('+', '');
    int parse = int.parse(convert);
    return parse;
  }

  static InstanceTrxOrder trxMonthOrder(List<dynamic> _trxHistory){ 
    InstanceTrxOrder _instanceTrxOrder = InstanceTrxOrder();
    DateTime date;
    _trxHistory.forEach((element) {
      date = DateTime.parse(element['created_at']).toLocal();
      if (date.month == 1) {
        _instanceTrxOrder.m1.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m1.add(element);

      } else if (date.month == 2){
        _instanceTrxOrder.m2.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m2.add(element);

      } else if (date.month == 3){
        _instanceTrxOrder.m3.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m3.add(element);

      } else if (date.month == 4){
        _instanceTrxOrder.m4.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m4.add(element);

      } else if (date.month == 5){
        if ( _instanceTrxOrder.m5.length == 0 ) _instanceTrxOrder.m5.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m5.add(element);

      } else if (date.month == 6){
        if ( _instanceTrxOrder.m6.length == 0 ) _instanceTrxOrder.m6.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m6.add(element);

      } else if (date.month == 7){
        _instanceTrxOrder.m7.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m7.add(element);

      } else if (date.month == 8){
        _instanceTrxOrder.m8.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m8.add(element);

      } else if (date.month == 9){
        _instanceTrxOrder.m9.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m9.add(element);

      } else if (date.month == 10){
        _instanceTrxOrder.m10.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m10.add(element);

      } else if (date.month == 11){
        _instanceTrxOrder.m11.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m11.add(element);

      } else if (date.month == 12){
        _instanceTrxOrder.m12.add({"date": AppUtils.timeStampToDate(element['created_at'])});
        _instanceTrxOrder.m12.add(element);
      }
    });
    return _instanceTrxOrder;
  }
}