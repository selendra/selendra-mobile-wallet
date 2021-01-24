import 'package:wallet_apps/index.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:wallet_apps/src/components/portfolio_c.dart';

class PortfolioBody extends StatelessWidget {
  final List<dynamic> listData;

  final PortfolioM portfolioM;

  PortfolioBody({@required this.listData, @required this.portfolioM});

  Widget build(BuildContext context) {
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

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
      hexaCodeToColor(AppColors.bgdColor)
    ];

    return Column(
      children: [
        MyAppBar(
          title: "Portfolio",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        if (listData == null)
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/no_data.svg', height: 200),
              MyText(text: "There are no portfolio found")
            ],
          ))
        else
          Column(
            children: [
              Hero(
                tag: 'chart',
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  padding: EdgeInsets.only(left: 25, top: 25, bottom: 25),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: hexaCodeToColor(AppColors.cardColor),
                      borderRadius: BorderRadius.circular(8)),
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
                              centerText: "10%",
                              legendOptions: LegendOptions(
                                showLegends: false,
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValues: false,
                                  // showChartValuesInPercentage: true,
                                  showChartValueBackground: false,
                                  chartValueStyle: TextStyle(
                                      color: hexaCodeToColor("#FFFFFF"),
                                      fontSize: 16)),
                            ),
                          ),
                        ),
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
                            endText: "50%",
                          ),
                          MyPieChartRow(
                            color: pieColorList[2],
                            centerText: "POK",
                            endText: "25%",
                          ),
                          MyPieChartRow(
                            color: pieColorList[3],
                            centerText: "Emp",
                            endText: "0%",
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),

              Container(
                height: 150,
                margin: EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(bottom: 16, text: "Wallet"),
                          MyPercentText(
                            value: "+10.5",
                          ),
                          LinearPercentIndicator(
                            alignment: MainAxisAlignment.center,
                            width: 100.0,
                            lineHeight: 5.0,
                            percent: 0.5,
                            backgroundColor:
                                hexaCodeToColor(AppColors.cardColor),
                            progressColor:
                                hexaCodeToColor(AppColors.secondary_text),
                            animation: true,
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: hexaCodeToColor(AppColors.cardColor),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(bottom: 16, text: "Market"),
                          MyPercentText(
                            value: "0.0",
                          ),
                          LinearPercentIndicator(
                            alignment: MainAxisAlignment.center,
                            width: 100.0,
                            lineHeight: 5.0,
                            percent: 0.5,
                            backgroundColor:
                                hexaCodeToColor(AppColors.cardColor),
                            progressColor: hexaCodeToColor("#00FFF0"),
                            animation: true,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Container(
              //   height: 250,
              //   margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: hexaCodeToColor(AppColors.cardColor),
              //     borderRadius: BorderRadius.circular(8)
              //   ),
              //   child: GroupedBarChart.withSampleData(),
              // ),

              // Container(
              //   margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              //   height: 50,
              //   child: ListView.builder(
              //     itemCount: months.length,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int i){
              //       return Align(
              //         alignment: Alignment.center,
              //         child: GestureDetector(
              //           child: MyText(
              //             width: 60,
              //             text: "${months[i]}"
              //           ),
              //         )
              //       );
              //     }
              //   )
              // ),

              MyRowHeader(),

              Container(
                constraints: BoxConstraints(minHeight: 100, maxHeight: 500),
                child: MyColumnBuilder(data: listData),
              )
            ],
          )
      ],
    );
  }
}
