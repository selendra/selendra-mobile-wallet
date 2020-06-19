import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ModelDashboard {
  bool isProgress = false, isQueried = false, loadingHome = true;
  Map<String, dynamic> userData;
  String barcode;
  List<dynamic> portfolio = [];
  GlobalKey<ScaffoldState> scaffoldKey;
  dynamic result; dynamic portFolioResponse; dynamic response;

  final GlobalKey<AnimatedCircularChartState> chartKey =  new GlobalKey<AnimatedCircularChartState>();
  double remainDataChart = 100;
  List<CircularSegmentEntry> circularChart;

  final RefreshController refreshController = RefreshController();
}
