import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ModelDashboard {
  bool isProgress = false, isQueried = false, loadingHome = true;
  final GlobalKey<AnimatedCircularChartState> chartKey = new GlobalKey<AnimatedCircularChartState>();
  final RefreshController refreshController = RefreshController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> userData, userWallet, portfolioData;
  String userId; String barcode, token;
}