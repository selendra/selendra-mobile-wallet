import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/activity_screen/activity_details_screen/activity_details_body.dart';

class MyActivityDetails extends StatefulWidget {
  final Map<String, dynamic> _trxInfo;

  MyActivityDetails(this._trxInfo);

  @override
  State<StatefulWidget> createState() {
    return MyActivityDetailsState();
  }
}

class MyActivityDetailsState extends State<MyActivityDetails> {
  final RefreshController _refreshController = RefreshController();

  bool isProgress = true;
  bool isLogout = false;

  @override
  void initState() {
    super.initState();
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
