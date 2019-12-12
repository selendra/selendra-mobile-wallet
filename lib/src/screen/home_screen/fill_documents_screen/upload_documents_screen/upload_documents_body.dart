import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget documentsBodyWidget(
  BuildContext context,
  Bloc bloc,
  ModelDocument _modelDocuments,
  Function popScreen, Function navigatePage
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
              containerTitleAppBar("Upload Documents")
            ],
          )
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 22.0),
                  child: Text("Scan the Front", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 29.17),
                  child: Text(
                    "Take photo of your front ID card Passport or other documents", 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Container( /* Card of sample take photo */
                  margin: EdgeInsets.only(bottom: 29.17),
                  child: Image.asset("assets/front_picture.png", width: double.infinity, fit: BoxFit.fill,),
                ),
                Container( /* Upload documents */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker(
                    context, 
                    "Take photo", "addDocumentScreen", 
                    Icons.camera_alt, 
                    _modelDocuments, 
                    navigatePage
                  ),
                ),
                blueButton(
                  bloc, 
                  context, 
                  "Upload", "uploadDocumentScreen",                     
                  FontWeight.normal,
                  size18,
                  EdgeInsets.only(top: 15.0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ), 
                  null
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}