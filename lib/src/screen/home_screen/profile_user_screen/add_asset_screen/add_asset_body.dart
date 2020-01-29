import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_asset.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget addAssetBodyWidget(
  BuildContext _context,
  ModelAsset _modelAsset,
  Function popScreen, Function onChanged, Function submitAddAsset
) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Add Assets", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded( /* Add Asset Body */
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField( /* Asset Code Field */
                      _context, 
                      "Asset Code", null, "addAssetScreen", 
                      false, 
                      [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      TextInputType.text, TextInputAction.next, 
                      _modelAsset.controllerAssetCode, _modelAsset.nodeAssetCode, 
                      validateInstance.validateAsset, onChanged, null
                    ),
                  ),
                  Container( /* Issuer Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _context, 
                      "Issuer", null, "addAssetScreen", 
                      false, 
                      [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      TextInputType.text, TextInputAction.done, 
                      _modelAsset.controllerIssuer, _modelAsset.nodeIssuer,
                      validateInstance.validateAsset, onChanged, null
                    ),
                  ),
                  customFlatButton( /* Add Asset Button */
                    _context, 
                    "Add assets", "addAssetScreen", blueColor,
                    FontWeight.normal, 
                    size18,
                    EdgeInsets.only(top: 15.0),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(0,0,0,0.54),
                      blurRadius: 5.0
                    ),
                    submitAddAsset
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}