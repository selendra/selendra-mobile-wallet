import 'package:wallet_apps/index.dart';

class SendWalletOption extends StatelessWidget {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final List<dynamic> _portfolioList; final Function _resetDbdState;

  final PostRequest _postRequest = PostRequest();

  SendWalletOption(this._portfolioList, this._resetDbdState){
    AppServices.noInternetConnection(_globalKey);
  }

  Widget build(BuildContext context){

    dynamic response;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(
        child: Column(
          children: <Widget>[
            MyAppBar(
              title: "Transaction option"
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: (width/2) + 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container( // Scan Wallet Field
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          height: 50.0,
                          child: customFlatButton(
                            context, 
                            "Scan wallet", "sendWalletOptionScreen", AppColors.blueColor, 
                            FontWeight.normal, 
                            16.0, 
                            EdgeInsets.all(0), 
                            EdgeInsets.only(top: 10, bottom: 10),
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.3), 
                              blurRadius: 10.0, 
                              spreadRadius: 2.0, 
                              offset: Offset(2.0, 5.0),
                            ),
                            (context) async {
                              await TrxOptionMethod.scanQR(context, _portfolioList, _resetDbdState);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: SizedBox( // Fill Wallet Field
                          height: 50.0,
                          child: customFlatButton(
                            context, 
                            "Fill wallet", "sendWalletOptionScreen", AppColors.greenColor, 
                            FontWeight.normal, 
                            16.0, 
                            EdgeInsets.all(0), 
                            EdgeInsets.only(top: 10, bottom: 10),
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.3), 
                              blurRadius: 10.0, 
                              spreadRadius: 2.0, 
                              offset: Offset(2.0, 5.0),
                            ),
                            (context) async {
                              TrxOptionMethod.navigateFillAddress(context, this._portfolioList, this._resetDbdState);
                            },
                          ),
                        )
                      ),
                      SizedBox( // Fill Wallet Field
                        height: 50.0,
                        child: customFlatButton(
                          context, 
                          "To contact", "sendWalletOptionScreen", AppColors.blueColor, 
                          FontWeight.normal, 
                          16.0, 
                          EdgeInsets.all(0), 
                          EdgeInsets.only(top: 10, bottom: 10),
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.3), 
                            blurRadius: 10.0, 
                            spreadRadius: 2.0, 
                            offset: Offset(2.0, 5.0),
                          ),
                          (context) async {
                            // TrxOptionMethod.selectContact(context, _postRequest,this._portfolioList, this._resetDbdState);
                          },
                        ),
                      ) 
                    ]
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }
}