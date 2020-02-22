import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_asset.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/add_asset_screen/add_asset_body.dart';

class AddAsset extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddAssetState();
  }
}

class AddAssetState extends State<AddAsset> {

  ModelAsset _modelAsset = ModelAsset();

  void onChanged(String value){
    _modelAsset.formStateAsset.currentState.validate();
  }

  void onSubmit(BuildContext context){
    if (_modelAsset.nodeAssetCode.hasFocus){
      FocusScope.of(context).requestFocus(_modelAsset.nodeIssuer);
    } else if (_modelAsset.enable == true){
      submitAddAsset(context);
    }
  }

  void submitAddAsset(BuildContext context) async {
    dialogLoading(context); /* Show Loading Process */
    await addAsset(_modelAsset).then((_response) async {
      if (_response != null){ 
        await dialog(
          context, 
          Text("${_response['message']}"), 
          Icon(
            Icons.done_outline, 
            color: getHexaColor(blueColor)
          )
        );
        Navigator.pop(context); /* Close Loading Process */
        _modelAsset.result = {'widget': 'assetCodeScreen'};
      }
    });
  }

  String validateAssetCode(String value){
    if (_modelAsset.nodeAssetCode.hasFocus){
      _modelAsset.responseAssetCode = instanceValidate.validateAsset(value);
      if (_modelAsset.responseAssetCode != null) _modelAsset.responseAssetCode += "asset code";
      validateAllField();
    }
    return _modelAsset.responseAssetCode;
  }

  String validateAssetIssuer(String value){
    if (_modelAsset.nodeIssuer.hasFocus){
      _modelAsset.responseAssetIssuer = instanceValidate.validateAsset(value);
      if (_modelAsset.responseAssetIssuer != null) _modelAsset.responseAssetIssuer += "asset issuer";
      validateAllField();
    }
    return _modelAsset.responseAssetIssuer;
  }

  void validateAllField() {
    if (
      _modelAsset.controllerAssetCode.text != "" &&
      _modelAsset.controllerIssuer.text != ""
    ) setState(() => _modelAsset.enable = true );
    else if ( _modelAsset.enable == true ) setState( () => _modelAsset.enable = false );
  }

  void popScreen() {
    Navigator.pop(context, _modelAsset.result);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: addAssetBodyWidget(
        context, 
        _modelAsset, 
        validateAssetCode, validateAssetIssuer,
        onChanged, onSubmit,
        submitAddAsset, popScreen,
      ),
    );
  }
}