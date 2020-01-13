import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/service/services.dart';

Widget receivedTrxBodyWidget(List<dynamic> _trxHistory, ModelSignUp _modelSignUp) {
  return _trxHistory == null ? Container(
    child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
    alignment: Alignment.center,
  ) /* Retreive Porfolio Null => Have No List */ 
  : _trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
  : ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: _trxHistory.length,
    itemBuilder: (BuildContext context, int index) {
      return _trxHistory[index]["source_account"] != _modelSignUp.wallet /* Send Trx If Source Account Address Not Equal Wallet Adddress */
      ? Container(
        margin: EdgeInsets.only(bottom: 10.5),
        child: Container(
          margin: EdgeInsets.only(left: 4.0),
          padding: EdgeInsets.only(top: 20.38, bottom: 16.62),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5))
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /* Asset Icons */
              Container(
                margin: EdgeInsets.only(right: 9.5),
                width: 31.0, 
                height: 31.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/zeeicon_on_screen.png',
                  )
                ),
              ),
              Expanded(
                flex: 2,
                child: Column( /* Asset name and date time */
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _trxHistory[index].containsKey("asset_code") 
                      ? Text(_trxHistory[index]["asset_code"])
                      : Text("XLM"),
                    Container(
                      child: Text(timeStampToDateTime(_trxHistory[index]['created_at'])),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Text(
                  "Completed", 
                  style: TextStyle(color: getHexaColor(greenColor)),
                ),
              )
            ],
          ),
        )
      )
      : Container();
    },
  );
}