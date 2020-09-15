import 'package:wallet_apps/index.dart';


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

/* -------------------------Transaction--------------------------- */

class TrxOption {
  
  static void selectContact(
    BuildContext context,
    PostRequest postRequest,
    List<dynamic> listPortfolio,
    Function resetDbdState
  ) async {
    var response;
    final PhoneContact _contact = await FlutterContactPicker.pickPhoneContact();
    if (_contact != null) {
      await postRequest.getWalletFromContact(
        "+855${AppServices.removeZero(_contact.phoneNumber.number.replaceFirst("0", "", 0))}" // Replace 0 At The First Index To Empty
      ).then((value) async {
        if(value['status_code'] == 200 && value.containsKey('wallet')){
          response = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => SubmitTrx(value['wallet'], false, listPortfolio))  
          );
          if (response["status_code"] == 200) {
            resetDbdState(null, "portfolio");
            Navigator.pop(context);
          }
        } else {
          await dialog(
            context, 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                textAlignCenter(text: value['message']),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: textAlignCenter(text: "Do you want to invite this number 0${_contact.phoneNumber.number.replaceFirst("0", "", 0)}?")
                )
              ],
            ), 
            textMessage(), 
            action: FlatButton(
              child: Text("Invite"),
              onPressed: () async {
                Navigator.pop(context); // Close Dialog Invite
                dialogLoading(context); // Process Loading
                var _response = await postRequest.inviteFriend("+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
                Navigator.pop(context); // Close Dialog Loading
                if (_response != null) {
                  await dialog(context, Text(_response['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor)));
                }
              },
            )
          );
        }
      });
    }
  }

  static void navigateFillAddress(BuildContext context, List<dynamic> portfolioList, Function resetDbdState) async {
    var response = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SubmitTrx("", true, portfolioList))
    );
    if (response['status_code'] == 200) {
      resetDbdState(null, "portfolio");
    }
  }

  /* Scan QR Code */
  static Future scanQR(BuildContext context, List<dynamic> portfolioList, Function resetDbdState) async {
    var _response;
    try {
      // String _barcode = await BarcodeScanner.scan();
      Navigator.push(context, transitionRoute(QrScanner(portList: portfolioList)));
      if (_response['status_code'] == 200) {
        resetDbdState(null, "portfolio");
      }
    } catch (e) {}
  }
  
}

// Dashboard Style
class DbdStyle{
  static Widget textStylePortfolio(String text, String hexaColor) {
    /* Style Text Inside Portfolio List */
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}

Widget portfolioList(BuildContext context, String title, List<dynamic> portfolioData, bool enable, HomeModel model) { /* List Of Portfolio */
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Column(
      children: <Widget>[
        Container( /* Portfolio Title */
          padding: EdgeInsets.only(bottom: 26.0),
          alignment: Alignment.centerLeft,
          child: MyText(
            text: title,
            fontSize: 20,
            color: "#FFFFFF",
          )
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              headerPortfolio(),
              portfolioData == null
              ? Container(/* Retreive Porfolio Null => Have No List */
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 11.5),
                margin: EdgeInsets.only(left: 4.0, top: 10.5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.5
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[Text("You have no wallet yet")],
                ),
              )
              : portfolioData.length == 0
              ? Padding(
                padding: EdgeInsets.all(10.0),
                child: loading()
              ) /* Show Loading Process At Portfolio List When Requesting Data */
              : buildRowList(portfolioData),
              
              // Add Asset
              portfolioData == null || portfolioData.length == 0 ? Container()
              : GestureDetector(
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
                          color: Colors.black26,
                          border: Border.all(width: 1, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        alignment: Alignment.center,
                        // child: Icon(FontAwesomeIcons.plus, color: Colors.white,)
                      ),

                      Text("Add asset", style: TextStyle(color: fontColorPort, fontSize: fontSizePort,))
                    ]
                  )
                )
              )
            ],
          )
        )
      ],
    ),
  );
}

Widget headerPortfolio(){
  return Container(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 1.5),
            alignment: Alignment.centerLeft,
            child: MyText(
              text: "Your assets"
            )
          ),
        ),
        Expanded(
          child: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: MyText(
                text: "QTY"
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/* Build Portfolio If Have List Of Portfolio */
Widget buildRowList(List<dynamic> portfolioData){
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
        /* Asset Icons */
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 35.0,
          height: 35.0,
          child: !portfolioData[index].containsKey("asset_code") ? Image.asset(
            "assets/stellar.svg",
            color: Colors.white
          )
          : MyIllustrate(
            decoration: BoxDecoration(
              color: hexaCodeToColor(AppColors.secondary),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.3), 
                  blurRadius: 40.0, 
                  spreadRadius: 2.0, 
                  offset: Offset(2.0, 5.0),
                )
              ],
              borderRadius: BorderRadius.circular(40)
            ),
            imagePath: 'assets/stellar.svg',
          )
          // CircleAvatar(
          //   backgroundColor: Colors.black26,
          //   backgroundImage: AssetImage(
          //     portfolioData[index].containsKey("asset_code") ? AppConfig.logoPortfolio : "assets/images/stellar_xlm_logo.png",
          //   ),
          // )
        ),
        DbdStyle.textStylePortfolio(
          portfolioData[index].containsKey("asset_code")
          ? portfolioData[index]["asset_code"]
          : "XLM",
          "#EFF0F2"
        ),
        /* Asset Code */
        Expanded(child: Container()),
        DbdStyle.textStylePortfolio(portfolioData[index]["balance"], "#00FFE8") /* Balance */
      ],
    )
  );
}

// Portfolow Row Decoration
Widget rowDecorationStyle({Widget child, double marginTop: 15}){
  return Container(
    margin: EdgeInsets.only(top: marginTop),
    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
    height: 60,
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

class CustomBottomAppBar extends StatelessWidget{
  final HomeModel model;
  final PostRequest postRequest;
  final Function scanReceipt;
  final Function resetDbdState;
  final Function toReceiveToken;
  final Function opacityController;
  final Function fillAddress;
  final Function contactPiker;
  
  CustomBottomAppBar({
    this.model, this.postRequest, this.scanReceipt, this.resetDbdState,
    this.toReceiveToken, this.opacityController, this.fillAddress, this.contactPiker
  });
  
  Widget build(BuildContext context){
    return Container(
      color: hexaCodeToColor(AppColors.bgdColor),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.only(left: 36.0),
              //   child: IconButton(
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     icon: Icon(LineAwesomeIcons.telegram),
              //     onPressed: () async {
              //       Navigator.push(
              //         context, 
              //         MaterialPageRoute(builder: (context) => SendWalletOption(model.portfolioList, resetDbdState))
              //       );
              //     }
              //   ),
              // ),
              Expanded(
                child: MyIconButton(
                  icon: LineAwesomeIcons.telegram,
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context, 
                      builder: (context) {
                      return Container(
                        height: 153,
                      );
                    });
                    //   Navigator.push(
                    //   context, 
                    //   MaterialPageRoute(builder: (context) => SendWalletOption(model.portfolioList, resetDbdState))
                    // );
                  },
                )
              ),

              Expanded(
                child: MyIconButton(
                  icon: LineAwesomeIcons.qrcode,
                  onPressed: () async {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => SendWalletOption(model.portfolioList, resetDbdState))
                    );
                  },
                )
              ),

              Expanded(child: Container()),

              Expanded(
                child: MyIconButton(
                  icon: LineAwesomeIcons.bar_chart_1,
                  onPressed: () async {
                  },
                )
              ),

              Expanded(
                child: MyIconButton(
                  icon: LineAwesomeIcons.list,
                  onPressed: () async {
                  },
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

  final double  pLeft; final double pTop; final double pRight; final double pBottom;
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
              child: Icon(
                LineAwesomeIcons.bell,
                color: hexaCodeToColor(AppColors.textColor),
                size: 30,
              ),
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
        textStyle:
            const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
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
        textStyle: const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
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