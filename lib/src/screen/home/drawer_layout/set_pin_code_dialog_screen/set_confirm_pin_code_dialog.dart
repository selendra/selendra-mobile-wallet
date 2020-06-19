import 'package:wallet_apps/index.dart';

class SetConfirmPin extends StatefulWidget {
  final String _pin;

  SetConfirmPin(this._pin);
  @override
  State<StatefulWidget> createState() {
    return SetConfirmPinState();
  }
}

class SetConfirmPinState extends State<SetConfirmPin> {
  String _confirmPin;
  bool disableButton = true, isProgress = false;
  Map<String, dynamic> popData;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        body: Stack(children: <Widget>[
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            title: Align(
              alignment: Alignment.center,
              child: Text("Confirm PIN"),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PinPut(
                  clearButtonIcon: Icon(Icons.close),
                  pasteButtonIcon: Icon(Icons.close),
                  isTextObscure: true,
                  fieldsCount: 4,
                  onSubmit: (String pins) {
                    _confirmPin = pins;
                    disableButton = false;
                    setState(() {});
                  },
                  onClear: (clear) {
                    _confirmPin = null;
                    disableButton = true;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Confirm",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _confirmPin == null
                          ? null
                          : () async {
                              /* Loading */
                              dialogLoading(context);
                              try {
                                if (_confirmPin == widget._pin) {
                                  /* If PIN Equal Confirm PIN */
                                  popData = {
                                    "widget": "confirmPin",
                                    "confirm_pin": _confirmPin,
                                    "compare": true
                                  };
                                  Map<String, dynamic> _response = await retreiveWallet(_confirmPin); /* Request Wallet */
                                  _response.addAll(popData);
                                  Navigator.pop(
                                      context); /* Close Cicular Loading */
                                  Navigator.pop(context,
                                      _response); /* Close Dialog And Push Back Data */
                                } else if (_confirmPin != widget._pin) {
                                  /* If PIN Not Equal Confirm PIN */
                                  Navigator.pop(context);
                                  popData = {
                                    "widget": "confirmPin",
                                    "compare": false
                                  };
                                  Navigator.pop(context, popData);
                                }
                              } on SocketException catch (e) {
                                await Future.delayed(
                                    Duration(milliseconds: 300), () {
                                  setState(() {});
                                });
                                Navigator.pop(context);
                                AppServices.mySnackBar(_globalKey, AppText.contentConnection);
                              } catch (e) {}
                            },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: RaisedButton(
                          child: Text('Close',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ]
      )
    );
  }
}
