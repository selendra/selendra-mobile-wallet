/* Flutter Package */
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Home/ImageSlideShow.dart';
import 'package:flutter/material.dart';
/* File Path */
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Bloc/Bloc.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

/* body widget */
Widget bodyWidget(
  Bloc bloc,
  GlobalKey<AnimatedCircularChartState> _chartKey,
  var portfolioData
) {
  /* Widget */
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
    // margin: EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        /* Welcome to Zeetomic */
        Container(
          child: cardHeader(_chartKey),
        ),
        /* Token & Profit */
        Container(
          margin: EdgeInsets.only(top: margin4),
          child: cardTokenAndProfit(),
        ),
        /* Zeetomic token chart */
        Container(
          width: double.infinity,
          child: portFolio(portfolioData),
        ),
        Container(
          width: double.infinity,
          child: cardRealTimeChart(),
        ),
      ],
    )
  ),
  );
  /* Card Header */
}

Widget cardHeader(GlobalKey<AnimatedCircularChartState> _chartKey){
  return Card(
    margin: EdgeInsets.only(left: margin4, top: margin4, right: margin4, bottom: 0.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
        borderRadius: BorderRadius.circular(defaultBorderRadius)
      ),
      padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* Investment rate */
          Expanded(
            child: Column(
              children: <Widget>[
                /* Pie Chart */
                AnimatedCircularChart(
                  key: _chartKey,
                  duration: Duration(milliseconds: 800),
                  startAngle: 180.0,
                  size: Size(160.0, 0.0),
                  percentageValues: true,
                  holeLabel: '88',
                  labelStyle: TextStyle(
                    color: Color(convertHexaColor(lightGreenColor)),
                    fontSize: 26.0,
                  ),
                  edgeStyle: SegmentEdgeStyle.flat,
                  initialChartData: <CircularStackEntry>[
                    CircularStackEntry(
                      <CircularSegmentEntry>[
                        CircularSegmentEntry(
                          40.0,
                          Color(convertHexaColor(lightBlueSky)), 
                          rankKey: 'completed',
                        ),
                        CircularSegmentEntry(
                          10.0,
                          Colors.grey,
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                ),
                /* Investment Text */
                // Text('Investment', style: TextStyle(color: Color(convertHexaColor("#2FC8DE"))),),
                // Text('Score', style: TextStyle(color: Color(convertHexaColor("#2FC8DE"))),),
              ],
            ),
          ),
          // Expanded(
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Text('88', 
          //           style: TextStyle(
          //             fontSize: 28.0,
          //             fontWeight: FontWeight.w300,
          //             color: Color(convertHexaColor(lightGreen))
          //           ),
          //         ),
          //         Text('Investment',
          //           style: TextStyle(
          //             color: Color(convertHexaColor("#2FC8DE"))
          //           ),                    
          //         ),
          //         Text('Score',
          //           style: TextStyle(
          //             color: Color(convertHexaColor("#2FC8DE"))
          //           ),                    
          //         )
          //       ],
          //     ),
          //   ),
          // ), 
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ZEETOMIC',style: TextStyle(fontSize: 21.0, foreground: Paint()..shader = linearGradient),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text('Blockchain as a service and smart assets issurance and management platform.', style: TextStyle(fontSize: 13.0, color: Colors.white),),
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
Widget cardTokenAndProfit(){
  return Row(
    children: <Widget>[
      /* Most Token User */
      Expanded(
        child: Container(
          child: Card(
            margin: EdgeInsets.only(left: margin4, right: 2.0, top: 0.0, bottom: 0.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
                borderRadius: BorderRadius.circular(defaultBorderRadius)
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: Text("Most Active Token", style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: Row(
                        children: <Widget>[
                          Text('1,168', style: TextStyle(color: Color(convertHexaColor(lightBlueSky)), fontSize: 23.0),),
                          Container(
                            margin: EdgeInsets.only(bottom: 3.0, left: 3.0),
                            child: Text("Token", style: TextStyle(color: Color(convertHexaColor(lightGreenColor))),),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_downward, color: Color(convertHexaColor("#C20404")), size: 17.0,),
                        Text('-7.8%', style: TextStyle(color: Color(convertHexaColor("#C20404"))),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /* Most Profitable */
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              // shadow("#4F4F55")
            ]
          ),
          // margin: EdgeInsets.only(left: 3.0),
          child: Card(
            margin: EdgeInsets.only(left: 2.0, right: margin4, top: 0.0, bottom: 0.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
                borderRadius: BorderRadius.circular(defaultBorderRadius)
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: Text("Most Profitable Token", style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('1,168', style: TextStyle(color: Color(convertHexaColor(lightBlueSky)), fontSize: 23.0),),
                          Container(
                            margin: EdgeInsets.only(bottom: 3.0, left: 3.0),
                            child: Text("Token", style: TextStyle(color: Color(convertHexaColor(lightGreenColor))),),
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.arrow_upward, color: Color(convertHexaColor(lightGreenColor)), size: 17.0,),
                        Text('-7.8%', style: TextStyle(color: Color(convertHexaColor(lightGreenColor))),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

/* My Portfolio */
Widget portFolio(var portfolioData) {
  return Card(
    margin: EdgeInsets.only(left: margin4, right: margin4, top: margin4, bottom: 0.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
        borderRadius: BorderRadius.circular(defaultBorderRadius)
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            /* Title */
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('My Portfolio', style: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 25.0)),
            ),
            /* Date Time Last Updated */
            // Container(
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            //   width: double.infinity,
            //   color: Color(convertHexaColor("#36363B")),
            //   child: Text('Last upadated 1:07:28 AM', style: TextStyle(color: Colors.white, fontSize: 10.0),),
            // ),
            /* Main Title Assets */
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('ASSETS', style: TextStyle(color: Colors.white))
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('QTY', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 100.0,
                        //   child: Align(
                        //     alignment: Alignment.centerRight,
                        //     child: Text('PRICE', style: TextStyle(color: Colors.white)),
                        //   ),
                        // ),
                        // Container(
                        //   width: 100.0,
                        //   child: Align(
                        //     alignment: Alignment.centerRight,
                        //     child: Text('BALANCE', style: TextStyle(color: Colors.white)),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  portfolioData == null ? Padding(padding: EdgeInsets.all(10.0), child: loading(),) : 
                  /* Check Response For Portfolio */ 
                  portfolioData['message'] != null ? Container() : Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))))
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: portfolioData['data'].length,
                      itemBuilder: (BuildContext context, int index){
                        // print(portfolioData['data'][1]['asset_code']);
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))))
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    portfolioData['data'][index]['asset_type'] == 'native' ? 'XLM' : portfolioData['data'][index]['asset_code'], 
                                    style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(portfolioData['data'][index]['balance'], style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    )
  );
}

Widget cardRealTimeChart() {
  return Card(
    margin: EdgeInsets.all(margin4),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
        borderRadius: BorderRadius.circular(defaultBorderRadius)
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: margin4, right: margin4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   child: Text('ZEE Chart', style: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 25.0)),
            // ),
            slideShow()
          ],
        ),
      ),
    ),
  );
}