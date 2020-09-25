import 'package:wallet_apps/index.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:wallet_apps/src/components/portfolio_c.dart';

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

    List<Color> pieColorList = [
      hexaCodeToColor("#08B952"),
      hexaCodeToColor("#40FF90"),
      hexaCodeToColor("#00FFF0"),
      hexaCodeToColor("#000000")
    ];

    return Column(
      children: [

        MyAppBar(
          title: "Portfolio",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.only(left: 25, top: 25, bottom: 25),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: hexaCodeToColor(AppColors.cardColor),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: PieChart(
                      ringStrokeWidth: 15,
                      dataMap: dataMap,
                      chartType: ChartType.ring,
                      colorList: pieColorList,
                      centerText: "15%",
                      legendOptions: LegendOptions(
                        showLegends: false,
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValues: false,
                        // showChartValuesInPercentage: true,
                        showChartValueBackground: false,
                        chartValueStyle: TextStyle(color: hexaCodeToColor("#FFFFFF"), fontSize: 16)
                      ),
                    ),
                  ),
                )
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    MyPieChartRow(
                      color: pieColorList[0],
                      centerText: "SEL",
                      endText: "25%",
                    ),

                    MyPieChartRow(
                      color: pieColorList[1],
                      centerText: "XML",
                      endText: "35%",
                    ),

                    MyPieChartRow(
                      color: pieColorList[2],
                      centerText: "POK",
                      endText: "25%",
                    ),

                    MyPieChartRow(
                      color: pieColorList[3],
                      centerText: "Emp",
                      endText: "50%",
                    ),
                  ],
                )
              )
            ],
          )
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            text: "Assets",
            color: "#FFFFFF",
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