import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgetModel{

  String countryCode = "+855";

  // Rest Api
  String endpoint; String key;
  
  // Validate Response
  String responseEmail; String responsePhoneNumber;
  String responseNewPassword; String responseConfirmPassword; String responseResetCode;

  bool enable1 = false; bool enable2 = false;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final formStatePhone = GlobalKey<FormState>();
  final formStateResetPass = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  
  TextEditingController controlPhoneNums = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controlNewPasswords = TextEditingController();
  TextEditingController controlConfirmPasswords = TextEditingController();
  TextEditingController controlResetCode = TextEditingController();

  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodeEmail = FocusNode();
  FocusNode nodePasswords = FocusNode();
  FocusNode nodeConfirmPasswords = FocusNode();
  FocusNode nodeResetCode = FocusNode();
  
}