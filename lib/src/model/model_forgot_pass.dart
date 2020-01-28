import 'package:flutter/widgets.dart';

class ModelForgotPassword{

  String countryCode = "+855";

  final formStatePhone = GlobalKey<FormState>();
  final formStateResetPass = GlobalKey<FormState>();
  
  TextEditingController controlPhoneNums = TextEditingController();
  TextEditingController controlNewPasswords = TextEditingController();
  TextEditingController controlConfirmPasswords = TextEditingController();
  TextEditingController controlResetCode = TextEditingController();

  FocusNode nodePhoneNums = FocusNode();
  FocusNode nodePasswords = FocusNode();
  FocusNode nodeConfirmPasswords = FocusNode();
  FocusNode nodeResetCode = FocusNode();
  
}