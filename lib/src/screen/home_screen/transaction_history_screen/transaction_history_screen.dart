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
  
  final _globalKey = GlobalKey<ScaffoldState>();
  final _containerKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();

  Size  _containerSize = Size(0,0);

  bool isProgress = true; bool isLogout = false;
  var history;

  @override
  void initState() {
    super.initState();
    fetchHistoryUser();
    /* Method Wait For Build COmplete */
    // WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
  }

  void fetchHistoryUser() async {
    var response = await userHistory();
    setState(() {
      isProgress = false;
      history = response['data'];
    });
  }

  /* Trigger Drawer To Open */
  void openDrawer() {
    _globalKey.currentState.openDrawer();
  }

  /* Log Out Method */
  void logOut() {
    /* Loading */
    dialogLoading(context);
    Timer(Duration(seconds: 1), () {
      clearStorage();
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void openSnackBar() {
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _globalKey.currentState.showSnackBar(snackbar);
  }

  /* Scroll Refresh */
  void _reFresh() {
    setState(() {
      isProgress = true;
    });
    fetchHistoryUser();
    _refreshController.refreshCompleted();
  }

  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      drawer: drawerOnly(context, "historyscreen", logOut),
      appBar: appbarWidget(openDrawer, containerTitleAppBar("History"), openSnackBar),
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
        controller: _refreshController,
        child: isProgress == false ? Container(
          margin: EdgeInsets.all(size4),
          child: history == null ? textNotification("No History", context) : bodyWidget(context, history, _containerKey, _containerSize, _height),
        ) : loading(),
        onRefresh: _reFresh,
      ),
    );
  }
  // _getHeight() {
  //   final RenderBox renderBox = _containerKey.currentContext.findRenderObject();
  //   final mySize = renderBox.size;
  //   setState(() {
  //     _containerSize = mySize;
  //   });
  // }
}
