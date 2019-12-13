import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelForgotPassword {
  Bloc bloc = Bloc();

  TextEditingController controllerPhone = TextEditingController(text: "");
  TextEditingController controllerSMS = TextEditingController(text: "");

  FocusNode nodePhone = FocusNode();
  FocusNode nodeSMS = FocusNode();
}