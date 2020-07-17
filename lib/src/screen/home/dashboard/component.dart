import 'package:wallet_apps/index.dart';


final fontSizePort = 17.0;

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
            MaterialPageRoute(builder: (context) => SendPayment(value['wallet'], false, listPortfolio))  
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
                  await dialog(context, Text(_response['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor)));
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
      MaterialPageRoute(builder: (context) => SendPayment("", true, portfolioList))
    );
    if (response['status_code'] == 200) {
      resetDbdState(null, "portfolio");
    }
  }

  /* Scan QR Code */
  static Future scanQR(BuildContext context, List<dynamic> portfolioList, Function resetDbdState) async {
    var _response;
    try {
      String _barcode = await BarcodeScanner.scan();
      _response = await Navigator.push(context, transitionRoute(SendPayment(_barcode, false, portfolioList)));
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
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
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
                        width: 30.0, height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          border: Border.all(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Icon(Icons.add)
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Add asset", style: TextStyle(color: Colors.black, fontSize: fontSizePort,))
                      )
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
            child: Text('Your assets',
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
                  fontSize: fontSizePort,
                  color: getHexaColor("#FFFFFF")
                )
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
      return portFolioRowItem(portfolioData, index);
    },
  );
}

Widget portFolioRowItem(List<dynamic> portfolioData, int index){
  return rowDecorationStyle(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Asset Icons */
        Container(
          margin: EdgeInsets.only(right: 9.5),
          width: 30.0,
          height: 30.0,
          child: CircleAvatar(
            backgroundImage: AssetImage(AppConfig.logoPortfolio,)
          ),
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
Widget rowDecorationStyle({Widget child, double marginTop: 10}){
  return Container(
    margin: EdgeInsets.only(top: marginTop),
    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 1, color: Colors.white),
      borderRadius: BorderRadius.circular(2),
    ),
    child: child
  );
}

Widget bottomAppBar(
  BuildContext context,
  ModelDashboard _modelDashboard,
  PostRequest postRequest,
  Function _scanReceipt,
  Function resetDbdState,
  Function _toReceiveToken,
  {
    Function opacityController,
    Function fillAddress,
    Function contactPiker,
  }
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
                      // Stack(
                      //   children: [
                      //     fabsButton(
                      //       degOneTranslationAnimation: _modelDashboard.degOneTranslationAnimation,
                      //       icon: Icons.camera_alt,
                      //       duration: Duration(microseconds: 400),
                      //       visible: _modelDashboard.visible,
                      //       radien: 273,
                      //       distance: 140,
                      //       onPressed: () {
                      //         print("1");
                      //         // TrxOption.scanQR(context, _modelDashboard.portfolioList, resetDbdState);
                      //       }
                      //     ),
                      //     fabsButton(
                      //       degOneTranslationAnimation: _modelDashboard.degOneTranslationAnimation,
                      //       icon: Icons.camera_alt,
                      //       duration: Duration(microseconds: 400),
                      //       visible: _modelDashboard.visible,
                      //       radien: 274.5,
                      //       distance: 100,
                      //       onPressed: (){
                      //         print(2);
                      //         // TrxOption.navigateFillAddress(context, _modelDashboard.portfolioList, resetDbdState);
                      //       },
                      //     ),
                      //     fabsButton(
                      //       degOneTranslationAnimation: _modelDashboard.degOneTranslationAnimation,
                      //       icon: Icons.camera_alt,
                      //       duration: Duration(microseconds: 300),
                      //       visible: _modelDashboard.visible,
                      //       radien: 280,
                      //       distance: 60,
                      //       onPressed: (){
                      //         print("3");
                      //         // TrxOption.selectContact(
                      //         //   context: context, 
                      //         //   postRequest: postRequest, 
                      //         //   listPortfolio: _modelDashboard.portfolioList,
                      //         //   resetDbdState: resetDbdState
                      //         // );
                      //       }
                      //     ),
                      //     Container(
                      //       width: 70.0,
                      //       child: IconButton(
                      //         padding: EdgeInsets.all(0),
                      //         color: Colors.white,
                      //         iconSize: 30.0,
                      //         icon: Icon(
                      //           OMIcons.arrowUpward,
                      //           color: Colors.white,
                      //         ),
                      //         onPressed: (){
                      //           if (_modelDashboard.animationController.isCompleted){
                      //             _modelDashboard.animationController.reverse();
                      //           } else {
                      //             _modelDashboard.animationController.forward();
                      //           }
                      //           opacityController(_modelDashboard.visible);
                      //         }
                      //         // _scanQR == null
                      //         // ? null
                      //         // : () async {
                      //         //   await _scanQR();
                      //         //   // await _scanQR(context, _modelDashboard, resetDbdState);
                      //         // }
                      //       ),
                      //     )
                      //   ]
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
                          onPressed: () async {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => SendWalletOption(_modelDashboard.portfolioList, resetDbdState))
                            );
                          }
                        ),
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
                          onPressed: () => _toReceiveToken(context)
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
        left: (MediaQuery.of(context).size.width / 2 - 30),
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