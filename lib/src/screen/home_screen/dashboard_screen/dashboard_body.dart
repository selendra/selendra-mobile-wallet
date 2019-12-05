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
  var portfolioData
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
            child: portFolio(portfolioData),
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
              duration: Duration(seconds: 2),
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

/* My Portfolio */
Widget portFolio(var portfolioData) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Column(
      children: <Widget>[
        /* Title */
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          alignment: Alignment.centerLeft,
          child:Text(
            "My Porfolio", 
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold
            ),
          ) 
        ),
        /* Main Title Assets */
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 7.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 1.5),
                        alignment: Alignment.centerLeft,
                          child: Text(
                            'Assets', 
                            style: TextStyle(
                              color: getHexaColor("#959ca7"), 
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                            )
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('QTY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: getHexaColor("#959ca7")
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.5),
                    child: Container(
                      height: 33.5,
                      margin: EdgeInsets.only(left: 4.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5))
                      ),
                      child: InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /* Asset Icons */
                            Container(
                              margin: EdgeInsets.only(right: 9.5),
                              width: 22.0, 
                              height: 22.0,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/zeeicon_on_screen.png',
                                )
                              ),
                            ),
                            textPortfolio("ZTO", "#EFF0F2"),
                            Expanded(child: Container()),
                            textPortfolio("145.2500125", "#EFF0F2")
                          ],
                        ),
                      ),
                    )
                  );
                },
              )

              // portfolioData == null
              // ? Padding(
              //     padding: EdgeInsets.all(10.0),
              //     child: loading(),
              //   )
              // :
              /* Check Response For Portfolio */
              // portfolioData['message'] != null ? Container()
              // : Container(
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(
              //           width: size1,
              //           color: getHexaColor(borderColor)
              //         )
              //       )
              //     ),
              //     child: ListView.builder(
              //       physics: BouncingScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: portfolioData['data'].length,
              //         itemBuilder: (BuildContext context, int index) {
              //           // print(portfolioData['data'][1]['asset_code']);
              //           return Container(
              //             decoration: BoxDecoration(
              //                 border: Border(
              //                   top: BorderSide(
              //                   width: size1,
              //                   color: getHexaColor(borderColor)
              //                 )
              //               )
              //             ),
              //             padding: EdgeInsets.all(5.0),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: <Widget>[
              //                 Expanded(
              //                   child: Container(
              //                     alignment: Alignment.centerLeft,
              //                     child: Text(portfolioData['data'][index]['asset_type'] =='native' ? 'XLM' : portfolioData['data'][index]['asset_code'])
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                     child: Align(
              //                       alignment: Alignment.centerLeft,
              //                       child: Text(portfolioData['data'][index]['balance']),
              //                     ),
              //                   ),
              //                 ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          )
        )
        
      ],
    ),
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
