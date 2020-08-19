import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:http/http.dart' as _http;

class ModelLogin {

  final formState1 = GlobalKey<FormState>();

  final formState2 = GlobalKey<FormState>();

  bool enable = false; bool securePassword = true;

  String token; String phoneNumber = "", countryCode = "+855", label;

  var colorSubmitted = Colors.transparent;

  var responseEmailPhone, responsePassword;

  _http.Response res;

  /* User login Property*/
  FocusNode nodeEmails = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodePasswords = FocusNode();
  
  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();

  Bloc bloc = Bloc();
}
