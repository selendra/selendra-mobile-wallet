import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/fill_pin_dialog.dart';
import './scan_pay_body.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'package:flutter/material.dart';

class SendPayment extends StatefulWidget{

  final String _walletKey;
  final ModelDashboard _modelDashBoard;

  SendPayment(this._walletKey, this._modelDashBoard);
  @override
  State<StatefulWidget> createState() {
    return SendPaymentState();
  }
}

class SendPaymentState extends State<SendPayment>{

  ModelScanPay _modelScanPay = ModelScanPay();

  @override
  void initState() {
    _modelScanPay.destination = widget._walletKey;
    _modelScanPay.portfolio = widget._modelDashBoard.portfolio;
    super.initState();
  }
  
  void fetchIDs() async {
    await Provider.fetchUserIds();
    setState(() {});
  }
  
  Future<bool> validateInput() { /* Check User Fill Out ALL */
    if ( 
      _modelScanPay.controlAmount.text != null && _modelScanPay.controlAmount.text != "" &&
      _modelScanPay.controlMemo.text != null && _modelScanPay.controlMemo.text != "" &&
      _modelScanPay.destination != null &&
      _modelScanPay.asset != null
    ){
      return Future.delayed(Duration(milliseconds: 50), () {
        return true;
      });
    }
    return null;
  }
  
  void clickSend(BuildContext context) async { /* Send payment */
    _modelScanPay.pin = await dialogBox();
    payProgres();
    var _response = await sendPayment(_modelScanPay);
    setState(() {
      _modelScanPay.isPay = false;
    });
    if (_response["status_code"] == 200){
      if (!_response.containsKey('error')){
        await dialog(context, Text(_response["message"]), Icon(Icons.done_outline, color: getHexaColor(blueColor)));
        Navigator.pop(context, _response["status_code"]);
      } else {
        await dialog(context, Text(_response["error"]['message']), Icon(Icons.warning, color: Colors.red));
        Navigator.pop(context, _response);
      }
    } else {
      await dialog(context, Text('Something goes wrong'), Icon(Icons.warning, color: Colors.red));
      Navigator.pop(context, _response);
    }
  }

  Future<String> dialogBox() async { /* Show Pin Code For Fill Out */
    String _result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: FillPin(),
        );
      }
    );
    return _result;
  }

  String validateAmount(String value){
    if (_modelScanPay.nodeAmount.hasFocus){
      _modelScanPay.responseAmount = instanceValidate.validateSendToken(value);
      enableButton();
      if (_modelScanPay.responseAmount != null) return _modelScanPay.responseAmount+="amount";
    }
    return _modelScanPay.responseAmount;
  }

  String validateMemo(String value){
    if (_modelScanPay.nodeMemo.hasFocus){
      _modelScanPay.responseMemo = instanceValidate.validateSendToken(value);
      enableButton();
      if (_modelScanPay.responseMemo != null) return _modelScanPay.responseMemo+="memo";
    }
    return _modelScanPay.responseMemo;
  }

  void onChanged(String value){
    _modelScanPay.formStateKey.currentState.validate();
  }

  void onSubmit(BuildContext context){
    if (_modelScanPay.nodeAmount.hasFocus){
      FocusScope.of(context).requestFocus(_modelScanPay.nodeMemo);
    } else {
      if (_modelScanPay.enable == true) clickSend(context);
    }
  }

  void enableButton(){
    if (
      _modelScanPay.controlAmount.text != '' &&
      _modelScanPay.controlMemo.text != '' &&
      _modelScanPay.asset != null 
    ) setState(() => _modelScanPay.enable = true);
    else if (_modelScanPay.enable == true) setState(() => _modelScanPay.enable = false);
  }

  /* Loading For User Pay */
  void payProgres() {
    setState(() {
      _modelScanPay.isPay = true;
    });
    processingSubmit();
  }

  void processingSubmit() async { /* Loading Processing Animation */
    int perioud = 500;
    while(_modelScanPay.isPay == true){
      await Future.delayed(
        Duration(milliseconds: perioud), 
        () {
          if (this.mounted) setState(() => _modelScanPay.loadingDot = ".");
          perioud = 300;
        } 
      );
      await Future.delayed(
        Duration(milliseconds: perioud), 
        () {
          if (this.mounted) setState(() => _modelScanPay.loadingDot = ". .");
          perioud = 300;
        } 
      );
      await Future.delayed(
        Duration(milliseconds: perioud), 
        () {
          if (this.mounted) setState(() => _modelScanPay.loadingDot = ". . .");
          perioud = 300;
        } 
      );
    }
  }

  void popScreen() { /* Close Current Screen */
    Navigator.pop(context);
  }

  void resetAssetsDropDown(String data) { /* Reset Asset */
    setState(() {
      _modelScanPay.asset = data;
    });
    enableButton();
  }

  PopupMenuItem item(Map<String, dynamic> list){ /* Display Drop Down List */
    return PopupMenuItem(
      value: list.containsKey("asset_code") /* Check Asset Code Key */ 
      ? list["asset_code"] 
      : "XLM",
      child: Align(
        alignment: Alignment.center, 
        child: Text(
          list.containsKey("asset_code") /* Check Asset Code Key */
          ? list["asset_code"] 
          : "XLM",
        ),
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
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
                    containerTitle("Fill Documents", double.infinity, Colors.white, FontWeight.bold)
                  ],
                )
              ),
              Flexible(
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: scanPayBodyWidget(
                      context, 
                      widget._walletKey, dialogBox, 
                      _modelScanPay, 
                      validateAmount, validateMemo,
                      onChanged, onSubmit, payProgres, 
                      validateInput, clickSend, resetAssetsDropDown,
                      item
                    ), /* Scan Pay Body Widget */
                  ),
                ),
              ),
            ],
          ),
          _modelScanPay.isPay == false ? Container() : Container(
            color: Colors.black.withOpacity(0.9),
            child: Center(
              child: Text('Your payment is being processing ${_modelScanPay.loadingDot}', style: TextStyle(fontSize: 20.0, color: getHexaColor(lightBlueSky))),
            ),
          )
        ],
      ),
    );
  }
}