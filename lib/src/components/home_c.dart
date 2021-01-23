import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wallet_apps/src/components/route_animation.dart';

final fontSizePort = 17.0;
final fontColorPort = Colors.white;

List<Color> gradientColors = [
  hexaCodeToColor(AppColors.secondary),
  hexaCodeToColor("#00ff6b")
];

final portfolioChart = LineChartData(
  borderData: FlBorderData(show: false),
  gridData: FlGridData(
    show: false,
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: const Color(0xff37434d),
        strokeWidth: 0.3,
      );
    },
    getDrawingVerticalLine: (value) {
      return FlLine(
        color: const Color(0xff37434d),
        strokeWidth: 0.3,
      );
    },
  ),

  titlesData: FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      // showTitles: true,
      reservedSize: 6,
      // textStyle: TextStyle(color: hexaCodeToColor(AppColors.textColor), fontWeight: FontWeight.bold, fontSize: 16),
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return '';
          case 1:
            return '2h';
          case 2:
            return '4h';
          case 3:
            return '6h';
          case 4:
            return '8h';
          case 5:
            return '10h';
        }
        return '12h';
      },
      margin: 0,
    ),
    leftTitles: SideTitles(
      // showTitles: true,
      // textStyle: TextStyle(
      //   color: hexaCodeToColor(AppColors.textColor),
      //   fontWeight: FontWeight.bold,
      //   fontSize: 15,
      // ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return '';
          case 1:
            return '50';
          case 2:
            return '100';
          case 3:
            return '150';
        }
        return '200';
      },
      reservedSize: 3,
      margin: 0,
    ),
  ),
  // borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
  minX: 0,
  maxX: 6,
  minY: 0,
  maxY: 4,
  lineBarsData: [
    LineChartBarData(
      spots: [
        FlSpot(0, 0),
        FlSpot(0.5, 0.5),
        FlSpot(1, 1),
        FlSpot(1.5, 2),
        FlSpot(2, 2.5),
        FlSpot(2.5, 3),
        FlSpot(3, 3),
        FlSpot(3.5, 3),
        FlSpot(4, 4),
        FlSpot(4.5, 3.5),
        FlSpot(5, 2),
        FlSpot(5.5, 2),
        FlSpot(6, 1),
      ],
      isCurved: true,
      colors: gradientColors,
      barWidth: 2.5,
      // isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    ),
  ],
);

Widget cardToken(
  /* Card Token Display */
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
        border: Border.all(
            width: size1, color: hexaCodeToColor(AppColors.borderColor)),
        borderRadius: BorderRadius.circular(size5)),
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
                  child: textDisplay(
                      /* Token number */
                      tokenAmount,
                      TextStyle(
                          color: hexaCodeToColor(AppColors.lightBlueSky),
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0)),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: paddingeBottom6, left: paddingeBottom6),
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

class AddAssetRowButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAsset()));
        },
        child: rowDecorationStyle(
            child: Row(children: [
          Container(
              width: 40.0,
              height: 40.0,
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                  color: hexaCodeToColor(AppColors.secondary),
                  border: Border.all(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(40.0)),
              alignment: Alignment.center,
              child: Icon(
                LineAwesomeIcons.plus,
                color: Colors.white,
              )),
          Text("Add asset",
              style: TextStyle(
                color: fontColorPort,
                fontSize: fontSizePort,
              ))
        ])));
  }
}

/* Build Portfolio If Have List Of Portfolio */
Widget buildRowList(List<dynamic> portfolioData, int rate) {
  return ListView.builder(
    padding: EdgeInsets.all(0),
    shrinkWrap: true,
    itemCount: 1,
    physics: BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return portFolioItemRow(portfolioData, index, rate);
    },
  );
}

Widget portFolioItemRow(List<dynamic> portfolioData, int index, int rate) {
  print(rate.isEven);
  return rowDecorationStyle(
      child: Row(
    children: <Widget>[
      MyCircularImage(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: hexaCodeToColor(AppColors.secondary),
            borderRadius: BorderRadius.circular(40)),
        imagePath: 'assets/sld_logo.svg',
        width: 50,
        height: 50,
        colorImage: Colors.white,
      ),

      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: "KPI",
                color: "#FFFFFF",
                fontSize: 18,
              ),
              MyText(text: "Koompi", fontSize: 15),
            ],
          ),
        ),
      ),

      // Container(
      //   width: 80,
      //   margin: EdgeInsets.only(right: 20),
      //   alignment: Alignment.center,
      //   child: SizedBox(
      //     height: 25,
      //     child: LineChart(
      //       portfolioChart
      //     ),
      //   ),
      // ),

      Expanded(
          child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                width: double.infinity,
                text: "0", //portfolioData[0]["data"]['balance'],
                color: "#FFFFFF",
                fontSize: 18,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis),
            // MyText(
            //   width: double.infinity,
            //   text: "+",//"${!rate.isNegative ? '+' : ''}$rate",
            //   textAlign: TextAlign.right,
            //   color: AppColors.secondary_text,//!rate.isNegative ? AppColors.secondary_text : "#ff1900",
            //   fontSize: 15
            // ),
          ],
        ),
      ))
    ],
  ));
}

// Portfolow Row Decoration
Widget rowDecorationStyle({Widget child, double mTop: 0, double mBottom = 16}) {
  return Container(
      margin: EdgeInsets.only(top: mTop, left: 16, right: 16, bottom: 16),
      padding: EdgeInsets.fromLTRB(15, 9, 15, 9),
      height: 90,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 2.0, offset: Offset(1.0, 1.0))
        ],
        color: hexaCodeToColor(AppColors.cardColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child);
}

class MyBottomAppBar extends StatelessWidget {
  final HomeModel homeM;
  final PortfolioM portfolioM;
  final PostRequest postRequest;
  final Function scanReceipt;
  final Function resetDbdState;
  final Function toReceiveToken;
  final Function opacityController;
  final Function fillAddress;
  final Function contactPiker;
  final Function openDrawer;
  final WalletSDK sdk;
  final Keyring keyring;

  MyBottomAppBar({
    this.homeM,
    this.portfolioM,
    this.postRequest,
    this.scanReceipt,
    this.resetDbdState,
    this.toReceiveToken,
    this.opacityController,
    this.fillAddress,
    this.contactPiker,
    this.openDrawer,
    this.sdk,
    this.keyring,
  });

  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: MyIconButton(
                icon: 'telegram.svg',
                onPressed: () async {
                  MyBottomSheet().trxOptions(
                    context: context,
                    portfolioList: homeM.portfolioList,
                    resetHomeData: resetDbdState,
                    sdk: sdk,
                    keyring: keyring,
                  );
                },
              )),
              Expanded(
                  child: MyIconButton(
                icon: 'qr_code.svg',
                onPressed: () async {
                  toReceiveToken();
                },
              )),
              Expanded(child: Container()),
              Expanded(
                  child: MyIconButton(
                icon: 'combo_chart.svg',
                onPressed: () async {
                  Navigator.push(
                      context,
                      RouteAnimation(
                          enterPage: Portfolio(
                        listData: portfolioM.list,
                        listChart: homeM.circularChart,
                      )));
                },
              )),
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

Widget fabsButton(
    {Animation degOneTranslationAnimation,
    IconData icon,
    Duration duration,
    bool visible,
    double radien,
    double distance,
    Function onPressed}) {
  return AnimatedOpacity(
    duration: duration,
    opacity: visible ? 1.0 : 0.0,
    child: Transform.translate(
      offset: Offset.fromDirection(AppServices.getRadienFromDegree(radien),
          degOneTranslationAnimation.value * distance),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    ),
  );
}

class MyHomeAppBar extends StatelessWidget {
  final double pLeft;
  final double pTop;
  final double pRight;
  final double pBottom;
  final EdgeInsetsGeometry margin;
  final String title;

  final Function action;

  MyHomeAppBar(
      {this.pLeft = 0,
      this.pTop = 0,
      this.pRight = 0,
      this.pBottom = 0,
      this.margin = const EdgeInsets.fromLTRB(0, 12, 0, 0),
      @required this.title,
      this.action});

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
              width: 50,
              height: 50,
              logoPath: "assets/sld_logo.svg",
            ),
            MyText(
              color: "#FFFFFF",
              text: title,
              left: 15,
              fontSize: 18,
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        action();
                      },
                      child: Icon(
                        LineAwesomeIcons.bell,
                        color: Colors.white,
                        size: 30,
                      ),
                    )))
          ],
        ));
  }
}

LineChartData mainData() {
  return LineChartData(
    borderData: FlBorderData(show: false),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 0.3,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 0.3,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 6,
        getTextStyles: (value) => TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '';
            case 1:
              return '2h';
            case 2:
              return '4h';
            case 3:
              return '6h';
            case 4:
              return '8h';
            case 5:
              return '10h';
          }
          return '';
        },
        margin: 0,
      ),
      leftTitles: SideTitles(
        // showTitles: true,
        // textStyle: TextStyle(
        //   color: hexaCodeToColor(AppColors.textColor),
        //   fontWeight: FontWeight.bold,
        //   fontSize: 15,
        // ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '';
            case 1:
              return '50';
            case 2:
              return '100';
            case 3:
              return '150';
          }
          return '200';
        },
        reservedSize: 3,
        margin: 0,
      ),
    ),
    // borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 6,
    minY: 0,
    maxY: 4,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(0.5, 2.5),
          FlSpot(1, 1),
          FlSpot(1.5, 2),
          FlSpot(2, 2.5),
          FlSpot(2.5, 3),
          FlSpot(3, 3),
          FlSpot(3.5, 3),
          FlSpot(4, 2),
          FlSpot(4.5, 3.5),
          FlSpot(5, 2),
          FlSpot(5.5, 2),
          FlSpot(6, 1),
        ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 3,
        // isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}
