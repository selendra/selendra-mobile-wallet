import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_asset.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/add_asset_screen/add_asset_body.dart';

class AddAsset extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddAssetState();
  }
}

class AddAssetState extends State<AddAsset> {

  ModelAsset _modelAsset = ModelAsset();

  void onChanged(String label, String textChange){
    if (label == "Add Assets") _modelAsset.controllerAssetCode.text = textChange;
    else if (label == "Issuer")_modelAsset.controllerIssuer.text = textChange;
  }

  void submitAddAsset(BuildContext context) {
    
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: addAssetBodyWidget(context, _modelAsset, popScreen, onChanged, submitAddAsset),
    );
  }
}