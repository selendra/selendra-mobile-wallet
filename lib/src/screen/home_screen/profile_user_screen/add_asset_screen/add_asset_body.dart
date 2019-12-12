import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_asset.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget addAssetBodyWidget(
  BuildContext context,
  ModelAsset _modelAsset,
  Function popScreen, Function onChanged, Function submitAddAsset
) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitleAppBar("Add Assets")
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
                      _modelAsset.bloc, context, 
                      "Asset Code", null, "addAssetScreen", 
                      false, 
                      TextInputType.text, 
                      _modelAsset.controllerAssetCode, _modelAsset.nodeAssetCode, 
                      onChanged, 
                      null
                    ),
                  ),
                  Container( /* Issuer Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _modelAsset.bloc, context, 
                      "Issuer", null, "addAssetScreen", 
                      false, 
                      TextInputType.text, 
                      _modelAsset.controllerIssuer, _modelAsset.nodeIssuer,
                      onChanged, 
                      null
                    ),
                  ),
                  blueButton( /* Add Asset Button */
                    _modelAsset.bloc, 
                    context, 
                    "Add assets", "addAssetScreen", 
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