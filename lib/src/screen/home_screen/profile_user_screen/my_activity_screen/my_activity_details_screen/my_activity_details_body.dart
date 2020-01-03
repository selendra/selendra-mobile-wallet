import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/my_activity_screen/reuse_activity_widget.dart';

Widget activityDetailsBodyWidget(
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
              containerTitle("My Activity Details", double.infinity, Colors.white, FontWeight.bold),
            ],
          )
        ),
        Container( /* Activity Information */ 
          margin: EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              rowInformation("Receipt no: ", _trxInfo['receipt_no']),
              rowInformation("Amount: ", _trxInfo['amount']),
              rowInformation("Rewards: ", _trxInfo['rewards']),
              rowInformation("Status", _trxInfo['status']),
              rowInformation("Created date: ", _trxInfo['created_at']),
              Divider(height: 1, color: Colors.white.withOpacity(0.1), thickness: 1.0,),
            ],
          ),
        )
      ],
    ),
  );
} 