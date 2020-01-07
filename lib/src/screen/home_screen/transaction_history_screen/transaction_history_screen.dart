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
    await trxUserHistory().then((_response) async { /* Get Response Data */
      if ( (_response.runtimeType.toString()) != "List<dynamic>" && (_response.runtimeType.toString()) != "_GrowableList<dynamic>" ){ /* If Response DataType Not List<dynamic> */ 
        if (_response.contains("error")){
          await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.warning, color: Colors.yellow,));
          setState(() {
            _history = null; /* Set Portfolio Equal Null To Close Loading Process */
          });
        }
      } else {
        setState(() {
          _history = _response;
        });
      } 
    });
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
