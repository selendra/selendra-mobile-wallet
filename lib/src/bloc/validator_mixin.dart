import 'dart:async';

class ValidateMixin {

  /* ----------User Login & Sign Up---------- */
  String validateEmails(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return "Fill your email";
    else if (!regex.hasMatch(value)) return "Invalid email";
    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) return "Fill your phone number";
    else if (value.length < 8 || value.length > 9) return "Invalid phone number";
    return null;
  }

  /* ----------User Sign Up Next Step---------- */
  String validatePassword(String value){
    if( value.isEmpty ) return 'Fill password';
    else if ( value.length < 5) return 'Password must be 5digit';
    return null;
  }

  String validateSms(String value){
    return null;
  }
  
  String validateUserInfo(String value){
    return null;
  }

  /* -----------Add User Field---------- */
  String validateOccupation(String value){
    return null;
  }

  String validateNationality(String value){
    return null;
  }

  /* -----------Invoice Field---------- */

  String validateInvoice(String value){
    return null;
  }
  String validateAuthCode(String value){
    return null;
  }

  /* ----------Profile User---------- */
  String validatePin(String value){
    return null;
  }

  String validateAsset(String value){
    return null;
  }

  /* ----------Home Screen---------- */
  String validateDocument(String value) {
    return null;
  }
  
  final validateEmail = StreamTransformer<String, dynamic>.fromHandlers(handleData: (value, sink){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == null) sink.add(null);
    else if (value == '') sink.addError('Fill your email');
    else if (!regex.hasMatch(value)) sink.addError('Invalid email');
    else if (regex.hasMatch(value)) sink.add(value);
  });

  final validatePhoneNums = StreamTransformer<String, dynamic>.fromHandlers(handleData: (value, sink){
    if (value == '') sink.addError('Fill phone number');
    else if (value.length < 8) sink.addError("Invalid phone number");
    else if (value.length >= 8) sink.add(value);
  });

  final validatePasswords = StreamTransformer<String, dynamic>.fromHandlers(handleData: (value, sink){
    if ( value == null ) sink.add(null);
    else if( value == '') { sink.addError('Fill password');}
    else if ( value.length < 5) sink.addError('Password must be 5digit');
    else if ( value.length >= 5) sink.add(value);
  }); 

}

final validateInstance = ValidateMixin();