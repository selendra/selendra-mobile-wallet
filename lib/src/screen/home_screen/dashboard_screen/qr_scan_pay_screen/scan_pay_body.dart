import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';

Widget scanPayBodyWidget(
  BuildContext context,
  String _walletKey,
  dynamic dialog,
  ModelScanPay _modelScanPay,
  Function validateAmount, Function validateMemo,
  Function onChanged, Function onSubmit,
  Function payProgress, Function validateInput, Function clickSend, Function resetAssetsDropDown,
  PopupMenuItem Function(Map<String, dynamic>) item
) {
  return Container(
    padding: EdgeInsets.only(top: 16.0, left: 40.0, right: 40.0),
    child: Form(
      key: _modelScanPay.formStateKey,
      child: Column(
        children: <Widget>[
          /* Wallet Key or address */
          Text(
            _walletKey, 
            style: TextStyle(
              color: getHexaColor(lightBlueSky), fontSize: 18.0,
              decoration: TextDecoration.underline,
            ), 
            textAlign: TextAlign.center,
          ),
          Container( /* Type of payment */
            margin: EdgeInsets.only(top: 20.0),
            child: customDropDown(
              _modelScanPay.asset != null ? _modelScanPay.asset : "Asset name", 
              _modelScanPay.portfolio, 
              _modelScanPay, 
              resetAssetsDropDown,
              item
            ),
          ),
          /* User Fill Out Amount */
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: inputField(
              context, 
              "Amount", null, 'sendTokenScreen', 
              false, 
              [LengthLimitingTextInputFormatter(TextField.noMaxLength)], 
              TextInputType.number, 
              TextInputAction.next, 
              _modelScanPay.controlAmount, 
              _modelScanPay.nodeAmount, 
              validateAmount, 
              onChanged, onSubmit
            )
            // userInput("Amount", _modelScanPay, TextInputType.number),userInput("Memo", _modelScanPay, null)
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: inputField(
              context, 
              "Memo", null, "sendTokenScreen", 
              false, 
              [LengthLimitingTextInputFormatter(TextField.noMaxLength)], 
              TextInputType.text, 
              TextInputAction.done,
              _modelScanPay.controlMemo, 
              _modelScanPay.nodeMemo, 
              validateMemo, 
              onChanged, 
              onSubmit
            ),
          ),
          /* Button Send */
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: customFlatButton(
              context, 
              "Send", "sendTokenScreen", blueColor, 
              FontWeight.bold,
              size18,
              EdgeInsets.only(top: size10, bottom: size10),
              EdgeInsets.only(top: size15, bottom: size15),
              BoxShadow(
                color: Color.fromRGBO(0,0,0,0.0),
                blurRadius: 0.0
              ), 
              _modelScanPay.enable == false ? null : clickSend
            ),
          )
        ],
      ),
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