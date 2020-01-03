import 'dart:async';
import 'package:wallet_apps/src/screen/home_screen/drawer_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_body.dart';
import 'package:flutter/material.dart';

import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionHistoryWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TracsactionHistoryState();
  }
}

class TracsactionHistoryState extends State<TransactionHistoryWidget>{

  final RefreshController _refreshController = RefreshController();

  bool isProgress = true; bool isLogout = false;

  List<dynamic> _history = [];

  @override
  void initState() {
    super.initState();
    fetchHistoryUser();
    /* Method Wait For Build COmplete */
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    _history = await trxUserHistory();
    setState(() { });
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
    fetchHistoryUser();
    _refreshController.refreshCompleted();
  }

  void popScreen() => Navigator.pop(context);

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: transactionBodyWidget(context, _history, popScreen),
      ),
    );
  }
}
