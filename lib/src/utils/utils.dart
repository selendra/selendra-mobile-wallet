// This file hold Calculation And Data Convertion
import 'package:date_format/date_format.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:intl/intl.dart';
import 'package:wallet_apps/index.dart';

class UtilsConvert {

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
  
  static Widget flareAnimation(FlareControls flareControls, String path, String animation){
    return FlareActor(
      path,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      animation: animation,
      controller: flareControls,
    );
  }
}