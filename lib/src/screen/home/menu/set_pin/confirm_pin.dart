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

  Backend _backend = Backend();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  
  PostRequest _postRequest = PostRequest();

  @override
  initState() {
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  Future<void> getWallet() async {
    /* Loading */
    dialogLoading(context);
    try {
      /* If PIN Equal Confirm PIN */
      if (_confirmPin == widget._pin) {
        popData = {
          "dialog_name": "confirmPin",
          "confirm_pin": _confirmPin,
          "compare": true,
          
        };
        // Post Request Api
        _backend.response = await _postRequest.retreiveWallet(_confirmPin); /* Request Wallet */
        // Convert String To Objects
        _backend.decode = json.decode(_backend.response.body);
        print("Confirm ${_backend.decode}");
        _backend.decode.addAll(popData);
        // Close Cicular Loading
        Navigator.pop(context);
        // Throw Data & Close Dialog 
        Navigator.pop(context, _backend.decode);
      } else if (_confirmPin != widget._pin) {
        // If PIN Not Equal Confirm PIN
        Navigator.pop(context);
        popData = {
          "dialog_name": "confirmPin",
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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Stack(
        children: <Widget>[
          AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
                      child: Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _confirmPin == null
                      ? null
                      : () async {
                        await getWallet();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: RaisedButton(
                        child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context, AppServices.emptyMapData());
                        }
                      ),
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
