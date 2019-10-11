import 'dart:async';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Drawer.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/History/HistoryBodyWidget.dart';
import 'package:flutter/material.dart';

import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Rest_Api/Rest_Api.dart';
import 'package:Wallet_Apps/src/Services/Remove_All_Data.dart';

class HistroyWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<HistroyWidget>{
  
  final _globalKey = GlobalKey<ScaffoldState>();
  final _containerKey = GlobalKey<ScaffoldState>();

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

  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      drawer: drawerOnly(context, logOut),
      appBar: appbarWidget(openDrawer, titleAppBar("History"), openSnackBar),
      body: Stack(
        children: <Widget>[
          isProgress == false ? Container(
            margin: EdgeInsets.all(margin4),
            child: history == null ? textNotification("No History", context) : bodyWidget(context, history, _containerKey, _containerSize, _height),
          ) : loading()
        ],
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
