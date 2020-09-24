import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';

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
              MyBottomSheet().notification(context: context);
            },
          ),

          MyCircularChart(
            amount: "\$ ${homeModel.total}",
            chartKey: chartKey,
            listChart: homeModel.circularChart,
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