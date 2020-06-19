import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModelAsset {

  bool enable = false;

  String responseAssetCode; String responseIssuer;

  GlobalKey<FormState> formStateAsset = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> result;

  TextEditingController controllerAssetCode = TextEditingController(text: "");
  TextEditingController controllerIssuer = TextEditingController(text: "");

  FocusNode nodeAssetCode = FocusNode();
  FocusNode nodeIssuer = FocusNode();
}