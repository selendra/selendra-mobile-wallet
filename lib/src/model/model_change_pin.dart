import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelChangePin {

  Bloc bloc = Bloc();
  TextEditingController controllerOldPin = TextEditingController(text: "");
  TextEditingController controllerNewPin = TextEditingController(text: "");
  TextEditingController controllerConfirmPin = TextEditingController(text: "");

  FocusNode nodeOldPin = FocusNode();
  FocusNode nodeNewPin = FocusNode();
  FocusNode nodeConfirmPin = FocusNode();
}