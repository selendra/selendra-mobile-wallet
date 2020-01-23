import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/activity_screen/reuse_activity_widget.dart';
import 'package:wallet_apps/src/service/services.dart';

Widget trxHistoryDetailsBodyWidget(
  String title, 
  BuildContext _context,
  Map<String, dynamic> _trxInfo,
  Function _popScreen
){
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                _popScreen,
              ),
              containerTitle("$title Details", double.infinity, Colors.white, FontWeight.bold),
            ],
          )
        ),
        Container( /* Activity Information */ 
          margin: EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              // rowInformation("Receipt no: ", _trxInfo['receipt_no']),
              rowInformation("Amount: ", _trxInfo['amount'] ?? "0.00"),
              // rowInformation("Location: ", _trxInfo['location']),
              rowInformation("Type: ", _trxInfo['type'] == "payment" ? "Payment" : "Fee"),
              rowInformation("From: ", _trxInfo['type'] == "payment" ? _trxInfo['from'] : ""),
              rowInformation("To: ", _trxInfo['type'] == "payment" ? _trxInfo['to'] : ""),
              rowInformation("Date: ", timeStampToDateTime(_trxInfo['created_at'])),
              // Divider(height: 1, color: Colors.white.withOpacity(0.1), thickness: 1.0,),
            ],
          ),
        )
      ],
    ),
  );
} 