import 'package:wallet_apps/index.dart';

Widget dashboardBody(
  BuildContext context,
  Bloc bloc,
  GlobalKey<AnimatedCircularChartState> _chartKey,
  List<dynamic> portfolioData,
  ModelDashboard _modelDashboard
) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: dashBoardCardHeader(_chartKey, _modelDashboard),
        ),
        /* Token & Profit */
        // Container(
        //   margin: EdgeInsets.only(top: 16.0),
        //   child: cardTokenAndProfit(),
        // ),
        /* Zeetomic token chart */
        Container(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          width: double.infinity,
          child: portfolioList(context, "Portfolios", portfolioData, true, _modelDashboard),
        ),
      ],
    ),
  );
}

Widget dashBoardCardHeader(GlobalKey<AnimatedCircularChartState> _chartKey, ModelDashboard _modelDashboard) { /* Card Header */
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    margin: EdgeInsets.only(top: size4, bottom: 0.0, left: 16.0, right: 16.0),
    child: Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container( /* Pie Chart */ /* Investment rate */
            child: FittedBox(
              child: AnimatedCircularChart(
                holeRadius: 45.0,
                key: _chartKey,
                duration: Duration(seconds: 1),
                // startAngle: 125.0,
                size: Size(190.0, 120),
                percentageValues: true,
                holeLabel: "S",
                labelStyle:TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                edgeStyle: SegmentEdgeStyle.flat,
                initialChartData: <CircularStackEntry>[
                  CircularStackEntry(
                    _modelDashboard.circularChart,
                    rankKey: 'progress',
                  ),
                ],
                chartType: CircularChartType.Radial,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                    // "About ZEETOMIC.",
                    "Total balance",
                    style: TextStyle(fontSize: 16.0, color: Colors.white54),
                  )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 19.42),
                    child: Text(
                      // "The Platform for the Issuance and Management of Digital Asset",
                      "\$426.75",
                      style: TextStyle(
                        fontSize: 20.0,
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
          child: cardToken("Most Active Token", "11,356", downColor, greenColor,
              '-15.8', Icons.arrow_downward, cardPadding6),
        ),
      ),
      /* Most Profitable */
      Expanded(
        child: Card(
          margin: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 8),
          child: cardToken("Most Profitable Token", "21,452", greenColor,
              greenColor, "25.3", Icons.arrow_upward, cardPadding6),
        ),
      )
    ],
  );
}
