import 'package:wallet_apps/src/graphql/services/mutation_document.dart';
import 'package:wallet_apps/src/model/model_scan_pay.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/fill_pin_dialog.dart';
import './scan_pay_body.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ScanPayWidget extends StatefulWidget{

  final String _walletKey;

  ScanPayWidget(this._walletKey);
  @override
  State<StatefulWidget> createState() {
    return ScanPayState();
  }
}

class ScanPayState extends State<ScanPayWidget>{
  bool isSuccessPin = false, isPay = false;
  ModelScanPay modelPay = ModelScanPay();
  List portFolio = [];

  @override
  void initState() {
    fetchIDs();
    modelPay.wallet = widget._walletKey;
    modelPay.asset = "ZTO";
    fetchPortfolio();
    super.initState();
  }

  void fetchPortfolio() async{
    var response = await fetchData('portFolioData');
    setState(() {
      for (int i = 0; i < response['data'].length; i++) {
        if (response['data'][i]['asset_code'] != null) {
          portFolio.add(response['data'][i]);
        }
      }
    });
  }

  void fetchIDs() async {
    await Provider.fetchUserIds();
    setState(() {});
  }

  void popAndBackResult(){
    Navigator.of(context).pop();
  }


  /* Check User Fill Out ALL */
  Future<bool> checkFillAll() {
    if ( 
      modelPay.amount != null && modelPay.amount != "" &&
      modelPay.memo != null && modelPay.memo != "" &&
      modelPay.wallet != null &&
      modelPay.asset != null
    ){
      return Future.delayed(Duration(milliseconds: 50), () {
        return true;
      });
    }
    return null;
  }

  /* Click Send Qraph Ql Action */
  void clickSend(RunMutation runMutation) async {
    await dialogBox();
    payProgres();
    runMutation({
      'pins': modelPay.pin,
      'assets': modelPay.asset,
      'wallets': modelPay.wallet,
      'amounts': modelPay.amount,
      'memoes': modelPay.memo
    });
  }

  /* Show Pin Code For Fill Out */
  dialogBox() async {
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
      modelPay.pin = _result;
    });
  }

  /* Loading For User Pay */
  void payProgres() {
    setState(() {
      isPay = true;
    });
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void resetAssetsDropDown(String data) {
    setState(() {
      modelPay.asset = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          appBar('Pay to', popScreen),
          Mutation(
            options: MutationOptions(document: scanPay),
            builder: (RunMutation runMutation, QueryResult results){
              return bodyWidget(runMutation, widget._walletKey, dialogBox, modelPay, portFolio, payProgres, checkFillAll(), clickSend, resetAssetsDropDown);
            },
            update: (Cache cache, QueryResult result) async {
              if (result.hasErrors) {
                dialog(context, Text(result.errors[0].message), Icon(Icons.error_outline, color: Colors.red, size: 30.0,));
                return;
              } 
              await dialog(context, Text(result.data['payment']['message']), Icon(Icons.check_circle, color: Colors.greenAccent, size: 30.0,));
              Navigator.of(context).pop("succeed");
            },
            onCompleted: (dynamic resultData){
              setState(() {
                isPay = false;
              });
            },
          ),
          isPay == false ? Container() : Container(
            color: Colors.black.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loading(),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text('Your payment is being processed . . .', style: TextStyle(fontSize: 20.0, color: getHexaColor(lightBlueSky)),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}