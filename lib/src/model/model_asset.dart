import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelAsset {
  Bloc bloc = Bloc();
  TextEditingController controllerAssetCode = TextEditingController(text: "");
  TextEditingController controllerIssuer = TextEditingController(text: "");

  FocusNode nodeAssetCode = FocusNode();
  FocusNode nodeIssuer = FocusNode();
}