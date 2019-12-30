import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/fill_pin_dialog.dart';
import './scan_pay_body.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/material.dart';

class ScanPay extends StatefulWidget{

  final String _walletKey;

  ScanPay(this._walletKey);
  @override
  State<StatefulWidget> createState() {
    return ScanPayState();
  }
}

class ScanPayState extends State<ScanPay>{

  ModelScanPay _modelScanPay = ModelScanPay();

  @override
  void initState() {
    fetchIDs();
    _modelScanPay.wallet = widget._walletKey;
    _modelScanPay.asset = "ZTO";
    // fetchPortfolio();
    super.initState();
  }

  // void fetchPortfolio() async{ /* Fetch Portfolio From Local Storage */
  //   var response = await fetchData('portFolioData');
  //   setState(() {
  //     for (int i = 0; i < response['data'].length; i++) {
  //       if (response['data'][i]['asset_code'] != null) {
  //         portFolio.add(response['data'][i]);
  //       }
  //     }
  //   });
  // }

  void fetchIDs() async {
    await Provider.fetchUserIds();
    setState(() {});
  }
  
  Future<bool> checkFillAll() { /* Check User Fill Out ALL */
    if ( 
      _modelScanPay.amount != null && _modelScanPay.amount != "" &&
      _modelScanPay.memo != null && _modelScanPay.memo != "" &&
      _modelScanPay.wallet != null &&
      _modelScanPay.asset != null
    ){
      return Future.delayed(Duration(milliseconds: 50), () {
        return true;
      });
    }
    return null;
  }
  
  void clickSend() async { /* Click Send Qraph Ql Action */
    // await dialogBox();
    // payProgres();
    // runMutation({
    //   'pins': _modelScanPay.pin,
    //   'assets': _modelScanPay.asset,
    //   'wallets': _modelScanPay.wallet,
    //   'amounts': _modelScanPay.amount,
    //   'memoes': _modelScanPay.memo
    // });
  }

  void dialogBox() async { /* Show Pin Code For Fill Out */
    var _result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: FillPinWidget(),
        );
      }
    );
    setState(() {
      _modelScanPay.pin = _result;
    });
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
      body: Stack(
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
                containerTitleAppBar("Fill Documents")
              ],
            )
          ),
          scanPayBodyWidget(widget._walletKey, dialogBox, _modelScanPay, _modelScanPay.portFolio, payProgres, checkFillAll(), clickSend, resetAssetsDropDown), /* Scan Pay Body Widget */
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