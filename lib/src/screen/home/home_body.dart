import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeBody extends StatelessWidget{

  final Bloc bloc;
  final GlobalKey<AnimatedCircularChartState> chartKey;
  final List<dynamic> portfolioData;
  final HomeModel homeM;
  final PortfolioM portfolioM;
  final PortfolioRateModel portfolioRateM;
  final Function getWallet;

  HomeBody({
    this.bloc,
    this.chartKey,
    this.portfolioData,
    this.homeM,
    this.portfolioM,
    this.portfolioRateM,
    this.getWallet
  });
  
  Widget build(BuildContext context) {
    return Column(
      children: [

        MyHomeAppBar(
          title: "SELENDRA Secure Wallet", 
          action: () {
            MyBottomSheet().notification(context: context);
          },
        ),

        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: hexaCodeToColor(AppColors.cardColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(right: 16),
                          width: 70, height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey
                          ),
                          
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: 'SELENDRA',
                              color: "#FFFFFF",
                              fontSize: 20,
                            ),
                            MyText(
                              text: 'SEL',
                              color: AppColors.secondary_text,
                              fontSize: 30,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),

                        Expanded(child: Container()),

                        MyText(
                          text: '0',
                          fontSize: 30,
                          color: AppColors.secondary_text,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),

                    MyText(
                      top: 16,
                      width: 200,
                      text: "e02e0cee0378be204a51d4cffb72fbf565bcf215", 
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 5,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: hexaCodeToColor(AppColors.secondary)
                      ),
                    ),

                    MyText(
                      text: 'Assets',
                      fontSize: 27,
                      color: "#FFFFFF",
                      left: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    
                    Expanded(
                      child: Container()
                    ),

                    GestureDetector(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: hexaCodeToColor(AppColors.secondary_text)),
                          MyText(text: "Add", color: AppColors.secondary_text, left: 6),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => AddAsset(),
                          )
                        );
                      },
                    )
                  ],
                )
              )
            ],
          )
        ),


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
                  builder: (context) => Portfolio(listData: portfolioM.list, listChart: homeM.circularChart),
                )
              );
            },
            child: buildRowList(portfolioM.list, portfolioRateM.totalRate)
          ),
        ),

        // GestureDetector(
        //   onTap: (){
        //     Navigator.push(
        //       context, 
        //       MaterialPageRoute(
        //         builder: (context) => AddAsset(),
        //       )
        //     );
        //   },
        //   child: rowDecorationStyle(
        //     child: Row(
        //       children: <Widget>[

        //         MyCircularImage(
        //           padding: EdgeInsets.all(6),
        //           margin: EdgeInsets.only(right: 20
        //           ),
        //           decoration: BoxDecoration(
        //             color: hexaCodeToColor(AppColors.secondary),
        //             borderRadius: BorderRadius.circular(40)
        //           ),
        //           imagePath: 'assets/icons/plus_math.svg',
        //           width: 50,
        //           height: 50,
        //           colorImage: Colors.white,
        //         ),

        //         Flexible(
        //           child: Align(
        //             alignment: Alignment.centerLeft,
        //             child: MyText(
        //               text: "Add asset",
        //               color: "#EFF0F2",
        //               fontSize: 16,
        //             )
        //           )
        //         ),
        //       ],
        //     )
        //   ),
        // )

        // Expanded(
        //   child: Stack(
        //     children: [

        //       if (portfolioM.list.isEmpty) loading()

        //       else if (portfolioM.list.isNotEmpty && portfolioM.list[0].containsKey('error')) Container(
        //         height: MediaQuery.of(context).size.height,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [

        //             Expanded(
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   SvgPicture.asset('assets/no_data.svg', width: 200, height: 200),
                          
        //                   MyFlatButton(
        //                     edgeMargin: EdgeInsets.only(top: 50),
        //                     width: 200,
        //                     textButton: "Get wallet",
        //                     action: getWallet,
        //                   )
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       )

        //       else if (!portfolioM.list[0].containsKey('error')) SingleChildScrollView(
        //         child: Column(
        //           children: <Widget>[
        //             MyCircularChart(
        //               amount: "${homeM.total}",
        //               chartKey: chartKey, 
        //               listChart: homeM.circularChart,
        //             ),

        //             Container(
        //               margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        //               padding: EdgeInsets.all(16.0),
        //               width: double.infinity,
        //               height: 222,
        //               decoration: BoxDecoration(
        //                 color: hexaCodeToColor(AppColors.cardColor),
        //                 borderRadius: BorderRadius.circular(8.0),
        //               ),
        //               child: LineChart(
        //                 mainData(),
        //                 swapAnimationDuration: Duration(seconds: 1),
        //               ),
        //             ),

        //             Container( /* Portfolio Title */
        //               alignment: Alignment.centerLeft,
        //               child: MyText(
        //                 bottom: 26,
        //                 left: 16,
        //                 text: "Portfolioes",
        //                 fontSize: 20,
        //                 color: "#FFFFFF",
        //               )
        //             ),

        //             MyRowHeader(),

        //             Container(
        //               constraints: BoxConstraints(
        //                 minHeight: 70,
        //                 maxHeight: 300
        //               ),
        //               child: GestureDetector(
        //                 onTap: (){
        //                   Navigator.push(
        //                     context, 
        //                     MaterialPageRoute(
        //                       builder: (context) => Portfolio(listData: portfolioM.list, listChart: homeM.circularChart),
        //                     )
        //                   );
        //                 },
        //                 child: buildRowList(portfolioM.list, portfolioRateM.totalRate)
        //               ),
        //             ),
                    
        //             // Add Asset
        //             GestureDetector(
        //               onTap: (){
        //                 Navigator.push(
        //                   context, 
        //                   MaterialPageRoute(
        //                     builder: (context) => AddAsset(),
        //                   )
        //                 );
        //               },
        //               child: rowDecorationStyle(
        //                 child: Row(
        //                   children: <Widget>[

        //                     MyCircularImage(
        //                       padding: EdgeInsets.all(6),
        //                       margin: EdgeInsets.only(right: 20
        //                       ),
        //                       decoration: BoxDecoration(
        //                         color: hexaCodeToColor(AppColors.secondary),
        //                         borderRadius: BorderRadius.circular(40)
        //                       ),
        //                       imagePath: 'assets/icons/plus_math.svg',
        //                       width: 50,
        //                       height: 50,
        //                       colorImage: Colors.white,
        //                     ),

        //                     Flexible(
        //                       child: Align(
        //                         alignment: Alignment.centerLeft,
        //                         child: MyText(
        //                           text: "Add asset",
        //                           color: "#EFF0F2",
        //                           fontSize: 16,
        //                         )
        //                       )
        //                     ),
        //                   ],
        //                 )
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}