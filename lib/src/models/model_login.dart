import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelLogin {

  final formState = GlobalKey<FormState>();

  bool enable = false; bool securePassword = true; bool hidePassword = true;

  String token; String phoneNumber = "", prefixText = "+855", label;

  var colorSubmitted = Colors.transparent;

  var responseEmailPhone, responsePassword;

  int myNumCount = 0;

  /* User login Property*/
  FocusNode nodeEmails = FocusNode();
  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodePasswords = FocusNode();
  
  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();

  Bloc bloc = Bloc();
  
}
