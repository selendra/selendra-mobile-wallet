import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelLogin {

  final formState1 = GlobalKey<FormState>();

  final formState2 = GlobalKey<FormState>();
  
  final String directory = "userID";

  bool isProgress = false, isLogedin = false, enable1 = false, enable2 = false;

  String token; String phoneNumber = "", countryCode = "+855", label;

  var colorSubmitted = Colors.transparent;

  /* User login Property*/
  final FocusNode nodeEmails = FocusNode();
  final FocusNode nodePhoneNums = FocusNode();
  final FocusNode nodePasswords = FocusNode();
  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();

  Bloc bloc = Bloc();
}
