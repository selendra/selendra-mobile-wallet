import 'package:wallet_apps/index.dart';

class  PortfolioBody extends StatelessWidget{

  final List<dynamic> listData;

  final PortfolioM portfolioM;

  PortfolioBody({
    @required this.listData,
    @required this.portfolioM
  });

  Widget build(BuildContext context) {
    return Column(
      children: [

        MyAppBar(
          title: "Portfolio",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        Row(
          children: [
            MyCircularChart(
              alignment: Alignment.centerLeft,
              chartKey: portfolioM.chartKey,
              listChart: portfolioM.circularChart,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
            )
          ],
        ),

        MyRowBuilder(
          margin: EdgeInsets.only(left: 16, right: 16),
          data: listData
        )
      ],
    );
  }
}