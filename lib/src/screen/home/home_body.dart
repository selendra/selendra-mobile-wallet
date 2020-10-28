import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeBody extends StatelessWidget{

  final Bloc bloc;
  final GlobalKey<AnimatedCircularChartState> chartKey;
  final List<dynamic> portfolioData;
  final HomeModel homeModel;
  final Function getWallet;

  HomeBody({
    this.bloc,
    this.chartKey,
    this.portfolioData,
    this.homeModel,
    this.getWallet
  });
  
  Widget build(BuildContext context) {
    return Column(
      children: [

        MyHomeAppBar(
          title: "SELENDRA", 
          action: () {
            MyBottomSheet().notification(context: context);
          },
        ),

        Expanded(
          child: Stack(
            children: [

              // if (portfolioData == null) Container(
              //   height: MediaQuery.of(context).size.height,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [

              //       Expanded(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             SvgPicture.asset('assets/no_data.svg', width: 200, height: 200),
                    
              //             GestureDetector(
              //               onTap: (){
              //                 getWallet(context);
              //               },
              //               child: MyText(
              //                 text: "Get wallet",
              //                 fontSize: 25,
              //                 color: AppColors.secondary_text,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )

              // else if (portfolioData.length == 0) loading()

              // else 
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    MyCircularChart(
                      amount: "12",//"\$ ${homeModel.total}",
                      chartKey: chartKey, 
                      listChart: homeModel.circularChart,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      // padding: EdgeInsets.all(16.0),
                      width: double.infinity,
                      height: 222,
                      decoration: BoxDecoration(
                        color: hexaCodeToColor(AppColors.cardColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: LineChart(
                        mainData(),
                        swapAnimationDuration: Duration(seconds: 1),
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

                    Container(
                      constraints: BoxConstraints(
                        minHeight: 70,
                        maxHeight: 300
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => Portfolio(listData: homeModel.portfolioList, listChart: homeModel.circularChart),
                            )
                          );
                        },
                        child: buildRowList(portfolioData)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}