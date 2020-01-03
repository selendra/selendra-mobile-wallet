import 'dart:async';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/my_activity_screen/my_activity_body.dart';
import 'package:flutter/material.dart';

import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/my_activity_screen/my_activity_details_screen/my_activity_details_body.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyActivityDetails extends StatefulWidget{

  final Map<String, dynamic> _trxInfo;

  MyActivityDetails(this._trxInfo);

  @override
  State<StatefulWidget> createState() {
    return MyActivityDetailsState();
  }
}

class MyActivityDetailsState extends State<MyActivityDetails>{

  final RefreshController _refreshController = RefreshController();

  bool isProgress = true; bool isLogout = false;

  @override
  void initState() {
    super.initState();
  }

  /* Log Out Method */
  void logOut() {
    /* Loading */
    dialogLoading(context);
    clearStorage();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /* Scroll Refresh */
  void _reFresh() {
    setState(() {
      isProgress = true;
    });
    _refreshController.refreshCompleted();
  }

  void popScreen() => Navigator.pop(context);


  Widget build(BuildContext context) {
    return Scaffold(
      body: activityDetailsBodyWidget(context, widget._trxInfo, popScreen),
    );
  }
}
