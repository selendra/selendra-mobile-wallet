/* Flutter Package */
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/Image_slide_show_widget.dart';
import 'package:flutter/material.dart';
/* File Path */
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard_reuse_widget.dart';

/* body widget */
Widget dashboardBodyWidget(
  Bloc bloc,
  GlobalKey<AnimatedCircularChartState> _chartKey,
  Map<String, dynamic> portfolioData
) {
  /* Widget */
  return SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          /* Welcome to Zeetomic */
          Container(
            child: cardHeader(_chartKey),
          ),
          /* Token & Profit */
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: cardTokenAndProfit(),
          ),
          /* Zeetomic token chart */
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: double.infinity,
            child: portfolioList("My Porfolio", portfolioData),
          ),
        ],
      )
    ),
  );
}

/* Card Header */
Widget cardHeader(GlobalKey<AnimatedCircularChartState> _chartKey) {
  return Card(
    margin: EdgeInsets.only(top: size4, bottom: 0.0),
    child: Container(
      margin: EdgeInsets.only(top: 26.0, bottom: 17.0, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container( /* Pie Chart */ /* Investment rate */
            child: AnimatedCircularChart(
              holeRadius: 45.0,
              key: _chartKey,
              duration: Duration(seconds: 1),
              startAngle: 125.0,
              size: Size(190.0, 120),
              percentageValues: true,
              holeLabel: '88',
              labelStyle: TextStyle(
                color: getHexaColor("#8CC361"),
                fontSize: 28.0,
                fontWeight: FontWeight.bold
              ),
              edgeStyle: SegmentEdgeStyle.flat,
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(
                      65.0,
                      getHexaColor("#8CC361"),
                      rankKey: 'completed',
                    ),
                    CircularSegmentEntry(
                      15.0,
                      getHexaColor("#4B525E"),
                      rankKey: 'remaining',
                    ),
                  ],
                  rankKey: 'progress',
                ),
              ],
              chartType: CircularChartType.Radial,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset("assets/zeetomic-logo-header.png", width: 140.53, height: 21.9,),
                  ),
                  Container(
                    height: 66,
                    margin: EdgeInsets.only(top: 19.42),
                    child: Text(
                      'Blockchain as a service and smart assets issurance and management platform.',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          /* Welcome to zeetomic */
        ],
      ),
    ),
  );
}

/* Token and Profit */
Widget cardTokenAndProfit() {
  String greenColor = "#8CC561";
  String downColor = "#F0416D";
  double cardPadding6 = 6.0;
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      /* Most Token User */
      Expanded(
        child: Card(
          margin: EdgeInsets.only(top: 0.0, bottom: 0.0, right: 8),
          child: cardToken(
            "Most Active Token",
            "11,356",
            downColor,
            greenColor,
            '-15.8',
            Icons.arrow_downward,
            cardPadding6
          ),
        ),
      ),
      /* Most Profitable */
      Expanded(
        child: Card(
          margin: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 8),
          child: cardToken(
            "Most Profitable Token", 
            "21,452", 
            greenColor,
            greenColor,
            "25.3", 
            Icons.arrow_upward,
            cardPadding6 
          ),
        ),
      )
    ],
  );
}

Widget sliderImage() {
  return Card(
    margin: EdgeInsets.all(size4),
    child: Container(
      decoration: BoxDecoration(
      border: Border.all(width: size1, color: getHexaColor(borderColor)),
      borderRadius: BorderRadius.circular(size5)),
      child: Padding(
        padding:
          EdgeInsets.only(top: 25.0, bottom: 25.0, left: size4, right: size4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            slideShow()
          ],
        ),
      ),
    ),
  );
}
