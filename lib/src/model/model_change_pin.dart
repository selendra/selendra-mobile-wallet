import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelChangePin {

  final formStateChangePin = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  bool enable = false;

  Bloc bloc = Bloc();

  String responseOldPin, responseNewPin, responseConfirmPin;

  TextEditingController controllerOldPin = TextEditingController(text: "");
  TextEditingController controllerNewPin = TextEditingController(text: "");
  TextEditingController controllerConfirmPin = TextEditingController(text: "");

  FocusNode nodeOldPin = FocusNode();
  FocusNode nodeNewPin = FocusNode();
  FocusNode nodeConfirmPin = FocusNode();
}
