import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeBody extends StatelessWidget{

  final Bloc bloc;
  final GlobalKey<AnimatedCircularChartState> chartKey;
  final List<dynamic> portfolioData;
  final HomeModel homeM;
  final PortfolioM portfolioM;
  final Function getWallet;

  HomeBody({
    this.bloc,
    this.chartKey,
    this.portfolioData,
    this.homeM,
    this.portfolioM,
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

              if (portfolioM.list.isEmpty) loading()

              else if (portfolioM.list.isNotEmpty && portfolioM.list[0].containsKey('error')) Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/no_data.svg', width: 200, height: 200),
                          
                          MyFlatButton(
                            edgeMargin: EdgeInsets.only(top: 50),
                            width: 200,
                            textButton: "Get wallet",
                            action: getWallet,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )

              else if (!portfolioM.list[0].containsKey('error')) SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MyCircularChart(
                      amount: "${homeM.total}",
                      chartKey: chartKey, 
                      listChart: homeM.circularChart,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      padding: EdgeInsets.all(16.0),
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
                              builder: (context) => Portfolio(listData: portfolioM.list, listChart: homeM.circularChart),
                            )
                          );
                        },
                        child: buildRowList(portfolioM.list)
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