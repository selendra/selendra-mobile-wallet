import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';

final fontSizePort = 17.0;
final fontColorPort = Colors.white;

Widget cardToken( /* Card Token Display */
  String title,
  String tokenAmount,
  String rateColor,
  String greenColor,
  String rate,
  IconData rateIcon,
  double paddingeBottom6,
) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: size1, color: hexaCodeToColor(AppColors.borderColor)),
      borderRadius: BorderRadius.circular(size5)
    ),
    child: Padding(
      padding: EdgeInsets.all(19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: paddingeBottom6),
            child: Text("Most Active Token"),
          ),
          Container(
            margin: EdgeInsets.only(bottom: paddingeBottom6),
            child: Row(
              children: <Widget>[
                Container(
                  height: 38.0,
                  alignment: Alignment.center,
                  child: textDisplay( /* Token number */
                    tokenAmount,
                    TextStyle(
                      color: hexaCodeToColor(AppColors.lightBlueSky),
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: paddingeBottom6, left: paddingeBottom6),
                  child: Text(
                    "Token",
                    style: TextStyle(color: hexaCodeToColor(greenColor)),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                rateIcon,
                color: hexaCodeToColor(rateColor),
                size: 17.0,
              ),
              Text(
                rate,
                style: TextStyle(color: hexaCodeToColor(rateColor)),
              )
            ],
          )
        ],
      ),
    ),
  );
}

class AddAssetRowButton extends StatelessWidget{
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => AddAsset())
        );
      },
      child: rowDecorationStyle(
        child: Row(
          children: [
            Container(
              width: 40.0, height: 40.0,
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: hexaCodeToColor(AppColors.secondary),
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(40.0)
              ),
              alignment: Alignment.center,
              child: Icon(LineAwesomeIcons.plus, color: Colors.white,)
            ),

            Text("Add asset", style: TextStyle(color: fontColorPort, fontSize: fontSizePort,))
          ]
        )
      )
    );
  }
}



/* Build Portfolio If Have List Of Portfolio */
Widget buildRowList(List<dynamic> portfolioData){
  print(portfolioData);
  return ListView.builder(
    padding: EdgeInsets.all(0),
    shrinkWrap: true,
    itemCount: portfolioData.length,
    physics: BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return portFolioItemRow(portfolioData, index);
    },
  );
}

Widget portFolioItemRow(List<dynamic> portfolioData, int index){
  return rowDecorationStyle(
    child: Row(
      children: <Widget>[

        /* Stellar Icons */
        ! portfolioData[index].containsKey("asset_code") ? 
        MyCircularImage(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: hexaCodeToColor(AppColors.secondary),
            borderRadius: BorderRadius.circular(40)
          ),
          imagePath: 'assets/stellar.svg',
          width: 40,
          height: 40,
          colorImage: Colors.white,
        )

        // Another Crypto Images
        : MyCircularImage(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(right: 16),
          boxColor: AppColors.secondary,
          decoration: BoxDecoration(
            color: hexaCodeToColor(AppColors.secondary),
            borderRadius: BorderRadius.circular(40)
          ),
          imagePath: 'assets/stellar.svg',
          width: 40,
          height: 40,
          colorImage: Colors.white,
        ),

        MyText(
          text: portfolioData[index].containsKey("asset_code")
          ? portfolioData[index]["asset_code"]
          : "XLM",
          color: "#EFF0F2",
          fontSize: 16,
        ),

        /* Asset Code */
        Expanded(child: Container()),

        MyText(text: portfolioData[0]["balance"], color: "#FFFFFF", fontSize: 16,) /* Balance */
      ],
    )
  );
}

// Portfolow Row Decoration
Widget rowDecorationStyle({Widget child, double marginTop: 15}){
  return Container(
    margin: EdgeInsets.only(top: marginTop, left: 16, right: 16),
    padding: EdgeInsets.fromLTRB(15, 9, 15, 9 ),
    height: 70,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2.0,
          offset: Offset(1.0, 1.0)
        )
      ],
      color: hexaCodeToColor(AppColors.cardColor),
      borderRadius: BorderRadius.circular(8),
    ),
    child: child
  );
}

class MyBottomAppBar extends StatelessWidget{

  final HomeModel model;
  final PostRequest postRequest;
  final Function scanReceipt;
  final Function resetDbdState;
  final Function toReceiveToken;
  final Function opacityController;
  final Function fillAddress;
  final Function contactPiker;
  final Function openDrawer;
  
  MyBottomAppBar({
    this.model, this.postRequest, this.scanReceipt, this.resetDbdState,
    this.toReceiveToken, this.opacityController, this.fillAddress, this.contactPiker,
    this.openDrawer
  });
  
  Widget build(BuildContext context){
    return Container(
      color: Colors.transparent,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(
                child: MyIconButton(
                  icon: 'telegram.svg',
                  onPressed: () async {
                    MyBottomSheet().trxOptions(context: context, portfolioList: model.portfolioList, resetHomeData: resetDbdState);
                  },
                )
              ),

              Expanded(
                child: MyIconButton(
                  icon: 'qr_code.svg',
                  onPressed: () async {
                    toReceiveToken();
                  },
                )
              ),

              Expanded(child: Container()),

              Expanded(
                child: MyIconButton(
                  icon: 'combo_chart.svg',
                  onPressed: () async {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => Portfolio(listData: model.portfolioList, listChart: model.circularChart,))
                    );
                  },
                )
              ),

              Expanded(
                child: MyIconButton(
                  icon: 'menu.svg',
                  onPressed: openDrawer,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


Widget fabsButton({
  Animation degOneTranslationAnimation,
  IconData icon, Duration duration, bool visible, double radien, double distance, Function onPressed
}){
  return AnimatedOpacity(
    duration: duration,
    opacity: visible ? 1.0 : 0.0,
    child: Transform.translate(
      offset: Offset.fromDirection(AppServices.getRadienFromDegree(radien), degOneTranslationAnimation.value * distance),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    ),
  );
}

class MyHomeAppBar extends StatelessWidget{

  final double pLeft; final double pTop; final double pRight; final double pBottom;
  final EdgeInsetsGeometry margin;
  final String title; 
  final Function action;

  MyHomeAppBar({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.margin = const EdgeInsets.fromLTRB(0, 12, 0, 0),
    @required this.title,
    this.action
  });
  
  Widget build(BuildContext context) {
    return Container(
      height: 65.0, 
      width: MediaQuery.of(context).size.width, 
      margin: margin,
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyLogo(
            width: 30, height: 30,
            logoPath: "assets/sld_logo.svg",
          ),

          MyText(
            color: "#FFFFFF",
            text: title,
            left: 15,
            fontSize: 20,
          ),
          
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  action();
                },
                child: Icon(
                  LineAwesomeIcons.bell,
                  color: Colors.white,
                  size: 30,
                ),
              )
            )
          )
        ],
      )
    );
  }
}

LineChartData mainData() {

  List<Color> gradientColors = [
    hexaCodeToColor(AppColors.secondary),
  ];

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        // textStyle: TextStyle(color: hexaCodeToColor(AppColors.textColor), fontWeight: FontWeight.bold, fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'MAR';
            case 5:
              return 'JUN';
            case 8:
              return 'SEP';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        // textStyle: TextStyle(
        //   color: hexaCodeToColor(AppColors.textColor),
        //   fontWeight: FontWeight.bold,
        //   fontSize: 15,
        // ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '10k';
            case 3:
              return '30k';
            case 5:
              return '50k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}