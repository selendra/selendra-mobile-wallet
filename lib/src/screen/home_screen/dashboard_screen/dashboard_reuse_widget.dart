import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/scan_pay.dart';

Widget cardToken(
  String title, 
  String tokenAmount, 
  String rateColor , String greenColor,
  String rate, IconData rateIcon,
  double paddingeBottom6,
){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: size1, 
        color: getHexaColor(borderColor)
      ),
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
                      color: getHexaColor(lightBlueSky),
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
Future scanQR(BuildContext context, ModelDashboard _model, Function resetState, Function fetchPortfolio) async {
  try {
    String barcode = await BarcodeScanner.scan();
    var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => ScanPayWidget(barcode)));
    if (response == "succeed") {
      resetState(null, "portfolio", _model, fetchPortfolio);
    }
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) 
      resetState("The user did not grant the camera permission!", "barcode", _model, fetchPortfolio);
    else 
      resetState("Unknown error: $e", "barcode", _model, fetchPortfolio);
  } on FormatException {
    resetState(
      "null (User returned using the 'back' -button before scanning anything. Result)", "barcode",
      _model, 
      fetchPortfolio
    );
  } catch (e){
    resetState(
      "Unknown error: $e",
      _model, 
      fetchPortfolio
    );
  }
}

Widget textStylePortfolio(String text, String hexaColor){
  return Container(
    margin: EdgeInsets.only(top: 5.0),
    child: Text(text, style: TextStyle(color: getHexaColor(hexaColor)),),
  );
}

Widget portfolioList(String title, Map<String, dynamic> portfolioData) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Column(
      children: <Widget>[
        Container( /* Portfolio Title */
          padding: EdgeInsets.only(bottom: 26.0),
          alignment: Alignment.centerLeft,
          child:Text(
            title, 
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold
            ),
          ) 
        ),
        /* Main Title Assets */
        SingleChildScrollView(
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
                          child: Text(
                            'Assets', 
                            style: TextStyle(
                              color: getHexaColor("#959ca7"), 
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
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
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: getHexaColor("#959ca7")
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(top: 10.5),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 11.5),
                      margin: EdgeInsets.only(left: 4.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5))
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
                                backgroundImage: AssetImage(
                                  'assets/zeeicon_on_screen.png',
                                )
                              ),
                            ),
                            textStylePortfolio("ZTO", "#EFF0F2"),
                            Expanded(child: Container()),
                            textStylePortfolio("145.2500125", "#EFF0F2")
                          ],
                        ),
                      ),
                    )
                  );
                },
              )

              // portfolioData == null
              // ? Padding(
              //     padding: EdgeInsets.all(10.0),
              //     child: loading(),
              //   )
              // :
              /* Check Response For Portfolio */
              // portfolioData['message'] != null ? Container()
              // : Container(
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(
              //           width: size1,
              //           color: getHexaColor(borderColor)
              //         )
              //       )
              //     ),
              //     child: ListView.builder(
              //       physics: BouncingScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: portfolioData['data'].length,
              //         itemBuilder: (BuildContext context, int index) {
              //           // print(portfolioData['data'][1]['asset_code']);
              //           return Container(
              //             decoration: BoxDecoration(
              //                 border: Border(
              //                   top: BorderSide(
              //                   width: size1,
              //                   color: getHexaColor(borderColor)
              //                 )
              //               )
              //             ),
              //             padding: EdgeInsets.all(5.0),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: <Widget>[
              //                 Expanded(
              //                   child: Container(
              //                     alignment: Alignment.centerLeft,
              //                     child: Text(portfolioData['data'][index]['asset_type'] =='native' ? 'XLM' : portfolioData['data'][index]['asset_code'])
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                     child: Align(
              //                       alignment: Alignment.centerLeft,
              //                       child: Text(portfolioData['data'][index]['balance']),
              //                     ),
              //                   ),
              //                 ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          )
        )
        
      ],
    ),
  );
}