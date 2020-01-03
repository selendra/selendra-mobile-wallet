import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';

Widget scanPayBodyWidget(
  String _walletKey,
  dynamic dialog,
  ModelScanPay _modelScanPay,
  Function payProgress, Function validateInput, Function clickSend, Function resetAssetsDropDown
) {
  return Container(
    padding: EdgeInsets.only(top: 16.0, left: 40.0, right: 40.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* Wallet Key or address */
        Text(_walletKey, style: TextStyle(color: getHexaColor(lightBlueSky), fontSize: 18.0), textAlign: TextAlign.center,),
        Theme( /* Type of payment */
          data: ThemeData(canvasColor: getHexaColor("#36363B")),
          child: DropdownButton(
            value: _modelScanPay.asset,
            onChanged: (data) {
              resetAssetsDropDown(data);
            },
            items: _modelScanPay.portfolio.length != 0 ? _modelScanPay.portfolio.map((list){
              return DropdownMenuItem(
                value: list.containsKey("asset_code") /* Check Asset Code Key */ 
                ? list["asset_code"] 
                : "XLM",
                child: Align(
                  alignment: Alignment.center, 
                  child: Text(
                    list.containsKey("asset_code") /* Check Asset Code Key */
                    ? list["asset_code"] 
                    : "XLM",
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
          child: userInput("Amount", _modelScanPay, TextInputType.number),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: userInput("Memo", _modelScanPay, null),
        ),
        /* Button Send */
        FutureBuilder(
          future: validateInput(),
          builder: (_context, snapshot) {
            return lightBlueButton(_context, snapshot, clickSend, "Send", EdgeInsets.only(top: 20.0));
          },
        )
      ],
    ),
  );
}

Widget userInput(String text, ModelScanPay _scanPay, var keyBoardType) {
  return TextField(
    style: TextStyle(color: Colors.white),
    onChanged: (changed){
      if (text == "Amount") _scanPay.controlAmount.text = changed; 
      else if (text == "Memo") _scanPay.controlMemo.text = changed;
    },
    decoration: InputDecoration(
      filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
      hintText: text,
      contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0),
      hintStyle: TextStyle(color: Colors.white),
      enabledBorder: outlineInput(getHexaColor(lightBlueSky)),
      focusedBorder: outlineInput(getHexaColor(lightBlueSky)),
      /* Error Handler */
      focusedErrorBorder: errorOutline(),
    ),
    keyboardType: keyBoardType,
  );
}