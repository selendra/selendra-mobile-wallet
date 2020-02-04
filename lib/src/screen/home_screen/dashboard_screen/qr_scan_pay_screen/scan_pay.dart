import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/fill_pin_dialog.dart';
import './scan_pay_body.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
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
    _modelScanPay.asset = "ZTO";
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
  
  void clickSend(BuildContext _context) async { /* Send payment */
    _modelScanPay.pin = await dialogBox();
    payProgres();
    var _response = await sendPayment(_modelScanPay);
    setState(() {
      _modelScanPay.isPay = false;
    });
    if (_response["status_code"] == 200 ){
      await dialog(_context, Text(_response["message"]), Icon(Icons.done_outline, color: getHexaColor(blueColor)));
      Navigator.pop(context, _response["status_code"]);
    }
  }

  dialogBox() async { /* Show Pin Code For Fill Out */
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

  /* Loading For User Pay */
  void payProgres() {
    setState(() {
      _modelScanPay.isPay = true;
    });
  }

  void popScreen() { /* Close Current Screen */
    Navigator.pop(context);
  }

  void resetAssetsDropDown(String data) { /* Reset Asset */
    setState(() {
      _modelScanPay.asset = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: scanPayBodyWidget(widget._walletKey, dialogBox, _modelScanPay, payProgres, validateInput, clickSend, resetAssetsDropDown), /* Scan Pay Body Widget */
              ),
            ),
          ),
          _modelScanPay.isPay == false ? Container() : Container(
            color: Colors.black.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loading(),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text('Your payment is being processing . . .', style: TextStyle(fontSize: 20.0, color: getHexaColor(lightBlueSky)),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}