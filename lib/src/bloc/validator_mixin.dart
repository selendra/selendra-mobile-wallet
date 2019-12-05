import 'dart:async';

class ValidatorMixin {
  
  final validateEmail = StreamTransformer<String, dynamic>.fromHandlers(handleData: (value, sink){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == null) sink.add(null);
    else if (value == '') sink.addError('Fill your email');
    else if (!regex.hasMatch(value)) sink.addError('Invalid email');
    else if (regex.hasMatch(value)) sink.add(value);
  });

  final validatePassword = StreamTransformer<String, dynamic>.fromHandlers(handleData: (value, sink){
    if ( value == null ) sink.add(null);
    else if( value == '') { sink.addError('Fill password');}
    else if ( value.length < 5) sink.addError('Password must be 5digit');
    else if ( value.length >= 5) sink.add(value);
  }); 

}