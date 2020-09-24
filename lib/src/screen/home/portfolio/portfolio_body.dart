import 'package:wallet_apps/index.dart';

import 'package:pie_chart/pie_chart.dart';

class  PortfolioBody extends StatelessWidget{

  final List<dynamic> listData;

  final PortfolioM portfolioM;

  PortfolioBody({
    @required this.listData,
    @required this.portfolioM
  });

  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "FLutter": 5,
      "React": 3,
      "Xamain": 2,
      "Ionic": 2,
    };

    return Column(
      children: [

        MyAppBar(
          title: "Portfolio",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        SizedBox(
          width: 100,
          height: 100,
          child: PieChart(
            dataMap: dataMap,
            chartType: ChartType.ring,
            colorList: [
              hexaCodeToColor("#08B952"),
              hexaCodeToColor("#40FF90"),
              hexaCodeToColor("#00FFF0"),
              hexaCodeToColor("#181C35")
            ],
            legendOptions: LegendOptions(
              showLegends: false,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              chartValueStyle: TextStyle(color: hexaCodeToColor("#181C35"))
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.only(right: 40, left: 40),
          // decoration: BoxDecoration(
          //   color: hexaCodeToColor(AppColors.cardColor)
          // ),
          child: Row(
            children: [
              // MyCircularChart(
              //   alignment: Alignment.centerLeft,
              //   chartKey: portfolioM.chartKey,
              //   listChart: portfolioM.circularChart,
              //   width: 250, height: 250,
              // ),
              // ,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: hexaCodeToColor(AppColors.secondary),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),

                        MyText(
                          text: "SEL",
                          fontSize: 16.0,
                          color: "#FFFFFF",
                        ),

                        MyText(
                          text: "25%",
                          fontSize: 16.0,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        MyRowBuilder(
          margin: EdgeInsets.only(left: 16, right: 16),
          data: listData
        )
      ],
    );
  }
}