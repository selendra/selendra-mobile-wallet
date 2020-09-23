import 'package:flutter/material.dart';

class ModelGetWalletFromContact{
  
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool enable = false;

  String responseToContactField;

  TextEditingController controllerToContact = TextEditingController();

  FocusNode nodeToContact = FocusNode();

}