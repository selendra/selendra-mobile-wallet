import 'dart:async';
import 'package:wallet_apps/index.dart'; 

final instanceValidate = ValidateMixin();

class ValidateMixin {
  
  /* ----------User Login & Sign Up---------- */
  String validateEmails(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return "Please fill your email";
    else if (!regex.hasMatch(value)) return "Invalid email";
    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) return "Please fill your phone number";
    else if (value.length < 8) return "Invalid phone number";
    return null;
  }

  /* ----------User Sign Up Next Step---------- */
  String validatePassword(String value) {
    if (value.isEmpty) return 'Please fill password';
    else if (value.length < 5) return 'Password less than 5 digit';
    return null;
  }

  String validateSms(String value) {
    return null;
  }

  String validateUserInfo(String value) {
    if (value.isEmpty) return "Please fill your ";
    return null;
  }

  String validateSendToken(String value) {
    if (value.isEmpty) return "Please fill your ";
    return null;
  }

  /* -----------Add User Field---------- */
  String validateOccupation(String value) {
    return null;
  }

  String validateNationality(String value) {
    return null;
  }

  /* -----------Invoice Field---------- */

  String validateInvoice(String value) {
    if (value.isEmpty) return "Please fill your ";
    return null;
  }

  /* ----------Profile User---------- */
  String validateChangePin(String value) {
    if (value.isEmpty) return "Please fill your ";
    else if (value.length < 4) return "Pin must be 4 digit";
    return null;
  }

  String validateAsset(String value) {
    if (value.isEmpty) return "Please fill your ";
    return null;
  }

  /* ----------Home Screen---------- */
  String validateDocument(String value) {
    return null;
  }
  
  String validateResetCode(String value){
    if (value.isEmpty) return "Please input your code";
    else if (value.length < 6 || value.length > 6) return "Your code does not correct";
    return null;
  }

  final validateEmail = StreamTransformer<String, dynamic>.fromHandlers(
      handleData: (value, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == null)
      sink.add(null);
    else if (value == '')
      sink.addError('Fill your email');
    else if (!regex.hasMatch(value))
      sink.addError('Invalid email');
    else if (regex.hasMatch(value)) sink.add(value);
  });

  final validatePhoneNums = StreamTransformer<String, dynamic>.fromHandlers(
      handleData: (value, sink) {
    if (value == '')
      sink.addError('Fill phone number');
    else if (value.length < 8)
      sink.addError("Invalid phone number");
    else if (value.length >= 8) sink.add(value);
  });

  final validatePasswords = StreamTransformer<String, dynamic>.fromHandlers(
      handleData: (value, sink) {
    if (value == null)
      sink.add(null);
    else if (value == '') {
      sink.addError('Fill password');
    } else if (value.length < 5)
      sink.addError('Password must be 5digit');
    else if (value.length >= 5) sink.add(value);
  });
}
