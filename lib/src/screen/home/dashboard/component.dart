import 'package:wallet_apps/index.dart';

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
      border: Border.all(width: size1, color: getHexaColor(AppColors.borderColor)),
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
                      color: getHexaColor(AppColors.lightBlueSky),
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: paddingeBottom6, left: paddingeBottom6),
                  child: Text(
                    "Token",
                    style: TextStyle(color: getHexaColor(greenColor)),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                rateIcon,
                color: getHexaColor(rateColor),
                size: 17.0,
              ),
              Text(
                rate,
                style: TextStyle(color: getHexaColor(rateColor)),
              )
            ],
          )
        ],
      ),
    ),
  );
}

/* Scan QR Code */
Future scanQR(BuildContext context, List<dynamic> _modelDashBoard, Function _resetState) async {
  var _response;
  try {
    String _barcode = await BarcodeScanner.scan();
    _response = await Navigator.push(context, transitionRoute(SendPayment(_barcode, false, _modelDashBoard)));
    if (_response['status_code'] == 200) {
      _resetState(null, "portfolio");
    }
  } catch (e) {}
  // try {
  //   String _barcode = await BarcodeScanner.scan();
  //   var _response = await Navigator.push(context, transitionRoute(SendPayment(_barcode, _modelDashBoard)));
  //   if (_response == 200) {
  //     if (!_response.containsKey('error'))
  //      _resetState(null, "portfolio", _modelDashBoard);
  //   }
  // } on PlatformException catch (e) {
  //   if (e.code == BarcodeScanner.CameraAccessDenied)
  //     _resetState("The user did not grant the camera permission!", "barcode", _modelDashBoard);
  //   else
  //     _resetState("Unknown error: $e", "barcode", _modelDashBoard);
  // } on FormatException {
  //   _resetState(
  //     "null (User returned using the 'back' -button before scanning anything. Result)", "barcode",
  //     _modelDashBoard,
  //   );

  // } catch (e){
  //   _resetState(
  //     "Unknown error: $e",
  //     "portfolio",
  //     _modelDashBoard,
  //   );
  // }
}

Widget textStylePortfolio(String text, String hexaColor) {
  /* Style Text Inside Portfolio List */
  return Container(
    margin: EdgeInsets.only(top: 5.0),
    child: Text(text, style: TextStyle(color: getHexaColor("#BCFF87"))),
  );
}

Widget portfolioList(BuildContext context, String title, List<dynamic> portfolioData, bool enable, ModelDashboard _modelDashboard) { /* List Of Portfolio */
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Column(
      children: <Widget>[
        Container( /* Portfolio Title */
          padding: EdgeInsets.only(bottom: 26.0),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontSize: 25.0),
          )
        ),
        GestureDetector( /* Main Title Assets */
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 1.5),
                            alignment: Alignment.centerLeft,
                            child: Text('Assets',
                              style: TextStyle(
                                color: getHexaColor("#FFFFFF"),
                                fontSize: 17.0,
                                // fontWeight: FontWeight.w400
                              )
                            )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('QTY',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: getHexaColor("#FFFFFF")
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    : ListView.builder(
                        /* Build Portfolio If Have List Of Portfolio */
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: portfolioData.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(top: 10.5),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 11.5),
                                margin: EdgeInsets.only(left: 4.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1.5
                                    )
                                  )
                                ),
                                child: InkWell(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /* Asset Icons */
                                      Container(
                                        margin: EdgeInsets.only(right: 9.5),
                                        width: 22.0,
                                        height: 22.0,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(AppConfig.logoPortfolio,)
                                        ),
                                      ),
                                      textStylePortfolio(
                                        portfolioData[index].containsKey("asset_code")
                                        ? portfolioData[index]["asset_code"]
                                        : "XLM",
                                        "#EFF0F2"
                                      ),
                                      /* Asset Code */
                                      Expanded(child: Container()),
                                      textStylePortfolio(portfolioData[index]["balance"], "#00FFE8") /* Balance */
                                    ],
                                  ),
                                ),
                              ));
                        },
                    )
              ],
            )
          ),
        )
      ],
    ),
  );
}


Widget bottomAppBar(
  BuildContext _context,
  ModelDashboard _modelDashboard,
  Function _scanQR,
  Function _scanReceipt,
  Function _resetState,
  Function _toReceiveToken
) {
  return Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(color: getHexaColor(AppConfig.darkBlue50), boxShadow: [
          shadow(getHexaColor("#000000").withOpacity(0.5), 5.0, 3.0)
        ]),
        child: BottomAppBar(
          elevation: 10.0,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 83.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          fabsButton(
                            degOneTranslationAnimation: _modelDashboard.degOneTranslationAnimation,
                            icon: Icons.camera_alt,
                            duration: Duration(microseconds: 300),
                            visible: _modelDashboard.visible,
                            distance: 300,
                          ),
                          // fabsButton(
                          //   degOneTranslationAnimation: _modelDashboard.degOneTranslationAnimation,
                          //   icon: Icons.camera_alt,
                          //   duration: Duration(microseconds: 300),
                          //   visible: _modelDashboard.visible,
                          //   radien: 270,
                          //   distance: 120,
                          // ),
                          // fabsButton(
                          //   degOneTranslationAnimation: _modelDashboard.degOneTranslationAnimation,
                          //   icon: Icons.camera_alt,
                          //   duration: Duration(microseconds: 200),
                          //   visible: _modelDashboard.visible,
                          //   radien: 270,
                          //   distance: 180,
                          // ),
                          Container(
                            width: 70.0,
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              color: Colors.white,
                              iconSize: 30.0,
                              icon: Icon(
                                OMIcons.arrowUpward,
                                color: Colors.white,
                              ),
                              onPressed: _scanQR == null
                              ? null
                              : () async {
                                await _scanQR();
                                // await _scanQR(_context, _modelDashboard, _resetState);
                              }
                            ),
                          )
                        ]
                      ),
                      Text("Send Token", style: TextStyle(color: Colors.white, fontSize: 13.0))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          iconSize: 30.0,
                          icon: Icon(OMIcons.arrowDownward),
                          onPressed: () => _toReceiveToken(_context)
                        ),
                      ),
                      Text("Receive Token", style: TextStyle(color: Colors.white, fontSize: 13.0))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      /* Logo Z Button */
      Positioned(
        left: (MediaQuery.of(_context).size.width / 2 - 30),
        child: FractionalTranslation(
          translation: Offset(0.0, -0.18),
          child: Container(
            width: 60,
            height: 60,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: getHexaColor("#8CC361"),
                child: Image.asset(
                  AppConfig.logoBottomAppBar,
                  color: Colors.white, width: 30.0, height: 30.0
                ),
                onPressed: _scanReceipt == null
                ? null
                : () async {
                  _scanReceipt();
                },
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget fabsButton({
  Animation degOneTranslationAnimation,
  IconData icon, Duration duration, bool visible, double radien = 300, double distance, Function method
}){
  return AnimatedOpacity(
    duration: duration,
    opacity: 1.0,
    child: Transform.translate(
      offset: Offset.fromDirection(AppServices.getRadienFromDegree(radien), degOneTranslationAnimation.value * 180),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: method,
      ),
    ),
  );
}
