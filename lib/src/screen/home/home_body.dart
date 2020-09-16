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
            action: () {

            },
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