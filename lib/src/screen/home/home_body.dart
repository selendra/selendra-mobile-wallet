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
    return Column(
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

        Container( /* Portfolio Title */
          alignment: Alignment.centerLeft,
          child: MyText(
            bottom: 26,
            left: 16,
            text: "Portfolioes",
            fontSize: 20,
            color: "#FFFFFF",
          )
        ),

        MyRowHeader(),

        if (portfolioData == null) Expanded(
          child: SvgPicture.asset('assets/undraw.svg', width: 270, height: 250),
        ),
        
        if (portfolioData.length == 0) loading()

        else Container(
          constraints: BoxConstraints(
            minHeight: 70,
            maxHeight: 300
          ),
          child: buildRowList(portfolioData),
        ),
      ],
    );
  }
}