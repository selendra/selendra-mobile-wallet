import 'package:wallet_apps/index.dart';

class HomeBody extends StatelessWidget{

  final Bloc bloc;
  final GlobalKey<AnimatedCircularChartState> chartKey;
  final List<dynamic> portfolioData;
  final HomeModel homeModel;

  HomeBody({
    this.bloc,
    this.chartKey,
    this.portfolioData,
    this.homeModel
  });
  
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          MyHomeAppBar(
            title: "SELENDRA", 
            // margin: const EdgeInsets.fromLTRB(0, 12, 0, 24)
          ),

          Container(
            margin: EdgeInsets.only(bottom: 24.0),
            child: AnimatedCircularChart(
              holeRadius: 70.0,
              key: chartKey,
              duration: Duration(seconds: 1),
              // startAngle: 125.0,
              size: Size(300.0, 250.0),
              percentageValues: true,
              holeLabel: "${homeModel.total}",
              labelStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              edgeStyle: SegmentEdgeStyle.flat,
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  homeModel.circularChart,
                  rankKey: 'progress',
                ),
              ],
              chartType: CircularChartType.Radial,
            )
          ),

          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            padding: EdgeInsets.only(left: 16.0, top: 32, bottom: 16.0, right: 32.0),
            width: double.infinity,
            height: 222,
            decoration: BoxDecoration(
              color: hexaCodeToColor(AppColors.cardColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: LineChart(
              mainData()
            ),
          ),
          /* Token & Profit */
          // Container(
          //   margin: EdgeInsets.only(top: 16.0),
          //   child: cardTokenAndProfit(),
          // ),
          /* Zeetomic token chart */
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            width: double.infinity,
            child: portfolioList(context, "Portfolioes", portfolioData, true, homeModel),
          ),
        ],
      )
    );
  }
}

Widget dashboardBody(
  BuildContext context,
  Bloc bloc,
  GlobalKey<AnimatedCircularChartState> _chartKey,
  List<dynamic> portfolioData,
  HomeModel _homeModel
) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: dashBoardCardHeader(_chartKey, _homeModel),
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
          child: portfolioList(context, "Portfolios", portfolioData, true, _homeModel),
        ),
      ],
    ),
  );
}

Widget dashBoardCardHeader(GlobalKey<AnimatedCircularChartState> _chartKey, HomeModel _homeModel) { /* Card Header */
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
      color: hexaCodeToColor(AppConfig.darkBlue50),
    ),
    margin: EdgeInsets.only(top: size4, bottom: 0.0, left: 16.0, right: 16.0),
    child: Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container( /* Pie Chart */ /* Investment rate */
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
                      "\$${_homeModel.total}",
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
