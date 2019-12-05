import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Widget bodyWidget(
  RunMutation runMutation,
  String _walletKey,
  dynamic dialog,
  ModelScanPay modelPay,
  List portFolio,
  Function payProgress,
  Future<bool> checkFillAll,
  Function clickSend, Function resetAssetsDropDown
) {
  return Container(
    padding: EdgeInsets.all(20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* Wallet Key or address */
        Text(_walletKey, style: TextStyle(color: getHexaColor(lightBlueSky), fontSize: 18.0),),
        /* Type of payment */
        Theme(
          data: ThemeData(canvasColor: getHexaColor("#36363B")),
          child: DropdownButton(
            value: modelPay.asset,
            onChanged: (data) {
              resetAssetsDropDown(data);
            },
            items: portFolio != null ? portFolio.map((list){
              return DropdownMenuItem(
                value: list['asset_code'],
                child: Align(
                  alignment: Alignment.center, 
                  child: Text(
                    list['asset_code'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList() : null,
          ),
        ),
        /* User Fill Out Amount */
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: userInput("Amount", modelPay, TextInputType.number),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: userInput("Memo", modelPay, null),
        ),
        /* Button Send */
        FutureBuilder(
          future: checkFillAll,
          builder: (context, snapshot) {
            return lightBlueButton(snapshot, clickSend, "Send", EdgeInsets.only(top: 20.0), runMutation);
          },
        )
      ],
    ),
  );
}

Widget userInput(String text, ModelScanPay scanPay, var keyBoardType) {
  return TextField(
    style: TextStyle(color: Colors.white),
    onChanged: (changed){
      if (text == "Amount") scanPay.amount = changed; 
      else if (text == "Memo") scanPay.memo = changed;
    },
    decoration: InputDecoration(
      fillColor: black38, filled: true,
      hintText: text,
      contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0),
      hintStyle: TextStyle(color: Colors.white),
      enabledBorder: outlineInput(getHexaColor(lightBlueSky)),
      focusedBorder: outlineInput(getHexaColor(lightBlueSky)),
      /* Error Handler */
      focusedErrorBorder: errorOutline(),
    ),
    keyboardType: keyBoardType,
  );
}