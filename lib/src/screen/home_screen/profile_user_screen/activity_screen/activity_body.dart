import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/activity_screen/reuse_activity_widget.dart';

Widget activityBodyWidget(
    BuildContext context, List<dynamic> _activityList, Function _popScreen) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context,
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                _popScreen,
              ),
              containerTitle("My Activity", double.infinity, Colors.white, FontWeight.bold),
            ],
          )
        ),
        Expanded(
          child: buildListBodyWidget(_activityList),
        )
      ],
    ),
  );
}
