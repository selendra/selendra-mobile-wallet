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

  bool disableButton = true, isProgress = false;
  Map<String, dynamic> popData;

  Backend _backend = Backend();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  
  PostRequest _postRequest = PostRequest();

  TextEditingController _pinPutController = TextEditingController();

  FocusNode _pinNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      // border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.grey.withOpacity(0.5)
    );
  }

  @override
  initState() {
    _pinNode.requestFocus();
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  Future<void> getWallet() async {
    /* Loading */
    dialogLoading(context);
    try {
      /* If PIN Equal Confirm PIN */
      if (_pinPutController.text == widget._pin) {
        // Store PIN In Database
        StorageServices.setData({'pin': _pinPutController.text}, 'pin');
        // Request Wallet
        _backend.response = await _postRequest.retreiveWallet(_pinPutController.text); 
        // Convert String To Objects
        _backend.mapData = json.decode(_backend.response.body);
        _backend.mapData.addAll({
          "dialog_name": "confirmPin",
          "confirm_pin": _pinPutController.text,
          "compare": true,
        });
        // Close Cicular Loading
        Navigator.pop(context);
        // Throw Data & Close Dialog 
        Navigator.pop(context, _backend.mapData);
      } 
      // If PIN Not Equal Confirm PIN
      else if (_pinPutController.text != widget._pin) {
        Navigator.pop(context);
        Navigator.pop(context, {
          "dialog_name": "confirmPin",
          "compare": false
        });
      }
    } on SocketException catch (e) {
      await Future.delayed(
        Duration(milliseconds: 300), () {
          setState(() {});
        }
      );
      Navigator.pop(context);
      AppServices.openSnackBar(_globalKey, AppText.contentConnection);
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Align(
        alignment: Alignment.center,
        child: Text("Confirm PIN"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PinPut(
            focusNode: _pinNode,
            controller: _pinPutController,
            fieldsCount: 4,
            selectedFieldDecoration: _pinPutDecoration,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              color: Colors.grey.withOpacity(0.5)
            ),
            followingFieldDecoration: _pinPutDecoration,
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: (){
            _pinPutController.clear();
          },
          child: MyText(
            right: 5,
            text: "Clear"
          ),
        ),

        GestureDetector(
          onTap: _pinPutController.text == null
            ? null
            : () async {
              await getWallet();
          },
          child: MyText(
            right: 5,
            text: "Submit",
          ),
        ),

        GestureDetector(
          child: MyText(
            right: 5,
            text: "Close",
          ),
          onTap: (){
            Navigator.pop(context, AppServices.emptyMapData());
          },
        )
      ],
    );
  }
}
