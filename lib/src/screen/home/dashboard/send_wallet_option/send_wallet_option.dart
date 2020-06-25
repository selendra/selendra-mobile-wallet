import 'package:wallet_apps/index.dart';

class SendWalletOption extends StatelessWidget {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final List<dynamic> _listPortfolio; final Function _resetState;

  final PostRequest _postRequest = PostRequest();

  SendWalletOption(this._listPortfolio, this._resetState){
    AppServices.noInternetConnection(_globalKey);
  }

  void selectContact(BuildContext context) async {
    var response;
    final PhoneContact _contact = await FlutterContactPicker.pickPhoneContact();
    if (_contact != null) {
      await _postRequest.getWalletFromContact(
        "+855${AppServices.removeZero(_contact.phoneNumber.number.replaceFirst("0", "", 0))}" // Replace 0 At The First Index To Empty
      ).then((value) async {
        if(value['status_code'] == 200 && value.containsKey('wallet')){
          response = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => SendPayment(value['wallet'], false, _listPortfolio))  
          );
          if (response["status_code"] == 200) {
            _resetState(null, "portfolio");
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
                var _response = await _postRequest.inviteFriend("+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
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

  Widget build(BuildContext context){

    dynamic response;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(
        child: Column(
          children: <Widget>[
            containerAppBar( /* AppBar */
              context, 
              Row(
                children: <Widget>[
                  iconAppBar( /* Arrow Back Button */
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Alignment.centerLeft,
                    EdgeInsets.all(0),
                    (){
                      Navigator.pop(context);
                    },
                  ),
                  containerTitle("Transaction option", double.infinity, Colors.white, FontWeight.normal)
                ],
              )
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
                              response = await scanQR(context, _listPortfolio, _resetState);
                              if (response == null) Navigator.pop(context);
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
                              response = await Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SendPayment("", true, _listPortfolio))
                              );
                              if (response['status_code'] == 200) {
                                _resetState(null, "portfolio");
                              }
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
                            selectContact(context);
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