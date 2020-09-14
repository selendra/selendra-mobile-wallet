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

  @override
  initState() {

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
      title: Align(alignment: Alignment.center, child: Text("Set PIN")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _showError == '' ? Container() : Container(
            padding: EdgeInsets.all(10.0),
            child: Text(_showError, style: TextStyle(color: Colors.red), textAlign: TextAlign.center),
          ),
          PinPut(
            clearButtonIcon: Icon(Icons.close),
            pasteButtonIcon: Icon(Icons.close),
            isTextObscure: true,
            fieldsCount: 4,
            onSubmit: (String pins) {
              setState(() {
                disableButton = false;
                _pin = pins;
              });
            },
            onClear: (clear) {
              _pin = null;
              disableButton = true;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: disableButton == true ? null : () {
                  Map<String, dynamic> popData = {
                    "dialog_name": "Pin",
                    "pin": _pin
                  };
                  Navigator.pop(context, popData);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: RaisedButton(
                  child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: (){
                    Navigator.pop(context, AppServices.emptyMapData());
                  }
                ),
              )
            ],
          )
        ],
      )
    );
  }
}