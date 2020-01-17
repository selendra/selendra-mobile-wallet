import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/activity_screen/activity_details_screen/activity_details_body.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/trx_history_details/trx_history_detail_body.dart';

class TrxHistoryDetails extends StatefulWidget {
  final String _title;
  final Map<String, dynamic> _trxInfo;

  TrxHistoryDetails(this._trxInfo, this._title);

  @override
  State<StatefulWidget> createState() {
    return TrxHistoryDetailsState();
  }
}

class TrxHistoryDetailsState extends State<TrxHistoryDetails> {
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
      body: trxHistoryDetailsBodyWidget(widget._title, context, widget._trxInfo, popScreen),
    );
  }
}
