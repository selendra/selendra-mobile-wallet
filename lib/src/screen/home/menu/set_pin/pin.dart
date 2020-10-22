import 'package:wallet_apps/index.dart';

class SetPinDialog extends StatefulWidget{

  final String showError;

  SetPinDialog(this.showError);

  @override
  State<StatefulWidget> createState() {
    return SetPinDialogState();
  }
}

class SetPinDialogState extends State<SetPinDialog> {

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool disableButton = true;
  String _pin;
  String _showError;

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

    if (_pin != null) { /* If PIN Not Have Data Assign To Empty */
      _showError = '';
    } else _showError = widget.showError; /* If PIN Have Data */

    super.initState();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      key: _globalKey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Align(alignment: Alignment.center, child: Text("Set pin")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _showError == '' ? Container() : Container(
            padding: EdgeInsets.all(10.0),
            child: Text(_showError, style: TextStyle(color: Colors.red), textAlign: TextAlign.center),
          ),
          PinPut(
            focusNode: _pinNode,
            controller: _pinPutController,
            fieldsCount: 4,
            selectedFieldDecoration: _pinPutDecoration,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              color: Colors.grey.withOpacity(0.5)
            ),
            followingFieldDecoration: _pinPutDecoration,
            onSubmit: (String value){
              setState(() {
                disableButton = false;
              });
            },
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
          onTap: disableButton == true ? null : () {
            Map<String, dynamic> popData = {
              "dialog_name": "Pin",
              "pin": _pinPutController.text
            };
            Navigator.pop(context, popData);
          },
          child: MyText(
            right: 5,
            text: "Next",
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