import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget invoiceSummary(String storeProperties, String storeData, FontWeight fontWeight){
  return Container(
    margin: EdgeInsets.only(top: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(storeProperties, style: TextStyle(fontSize: 18.0),),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 15.0),
          child: Text(":", style: TextStyle(fontSize: 18.0),),
        ),
        Expanded(
          flex: 3,
          child: Text(storeData, style: TextStyle(fontSize: 20.0, fontWeight: fontWeight, color: getHexaColor(greenColor)),),
        )
      ],
    ),
  );
}