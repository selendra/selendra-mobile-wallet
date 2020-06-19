import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelLogin {

  final formState1 = GlobalKey<FormState>();

  final formState2 = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  bool enable1 = false, enable2 = false; bool securePassword = true;

  String token; String phoneNumber = "", countryCode = "+855", label;

  var colorSubmitted = Colors.transparent;
  var responseEmailPhone, responsePassword;

  /* User login Property*/
  FocusNode nodeEmails = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodePasswords = FocusNode();
  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();

  Bloc bloc = Bloc();
}
