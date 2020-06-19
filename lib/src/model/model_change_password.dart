import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModelChangePassword{

  final formStateChangePassword = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  bool enable = false;

  String responseOldPass, responseNewPass, responseConfirm;

  TextEditingController controlOldPassword = TextEditingController();
  TextEditingController controlNewPassword = TextEditingController();
  TextEditingController controlConfirmPassword = TextEditingController();

  FocusNode nodeOldPassword = FocusNode();
  FocusNode nodeNewPassword = FocusNode();
  FocusNode nodeConfirmPassword = FocusNode();
}