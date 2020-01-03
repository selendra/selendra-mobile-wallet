import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/my_activity_screen/reuse_activity_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/tab_bars_list/received_transaction.dart';

Widget activityBodyWidget(
  BuildContext context, 
  List<dynamic> _activityList,
  Function _popScreen
) {
  
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                _popScreen,
              ),
              containerTitle("My Activity", double.infinity, Colors.white, FontWeight.bold),
            ],
          )
        ),
        buildListBodyWidget(_activityList)
      ],
    ),
  );
}