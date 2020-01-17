import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ModelDashboard {
  final String titleAppBar = "CBM-V4-01.png"; //"CBM-V4-01.png"; //"zeetomic-logo-header.png";
  bool isProgress = false, isQueried = false, loadingHome = true;
  Map<String, dynamic> userData, userWallet;
  String userId; String barcode, token;
  List<dynamic> portfolio = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedCircularChartState> chartKey = new GlobalKey<AnimatedCircularChartState>();
  final RefreshController refreshController = RefreshController();
}