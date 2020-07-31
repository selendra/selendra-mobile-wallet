import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';

class PrivateKeyDialog extends StatefulWidget{

  final Map<String, dynamic> _message;

  PrivateKeyDialog(this._message);
  @override
  State<StatefulWidget> createState() {
    return PrivateKeyState();
  }
}

class PrivateKeyState extends State<PrivateKeyDialog>{

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isCheck = false, isSave = false, isCopy = false, disableButton = true;
  
  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  void userCheckBox() {
    setState(() {
      if (isCheck == false) {
        isCheck = true;
      } else {
        isCheck = false;
      }
    });
  }

  /* Clip Private Key */
  void userCopyKey() {
    setState(() {
      isCopy = true;
      Clipboard.setData(ClipboardData(text: widget._message['message']["seed"]));
    });
  }

  Widget build(BuildContext context){
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      key: _globalKey,
      title: Align(
        alignment: Alignment.center, 
        child: Container( 
          // height: 50.0, 
          child: widget._message.containsKey('seed') ? textMessage(text: "SELENDRA Wallet") : textMessage(),
        )
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget._message['message'][0] == null /* Index 0 Will Be Null If It Contains Key */
          ? checkBoxContent("${widget._message['message']["seed"]}", isCheck, isCopy, userCheckBox) /* Display Private Key */
          : Text(widget._message['message'], textAlign: TextAlign.center), /* Display Message When Index 0 As A String */
        ],
      ),
      actions: /* Button */
      widget._message['message'][0] == null /* Index 0 Will Be Null If It Contains Key */
      ? listButton(context, widget._message['message']['seed'],  isCopy, isCheck, userCopyKey) /* Display Multi Button */
      : [
        closeButton(context, widget._message)
      ]
    );
  }
}

Widget closeButton(BuildContext context, Map<String, dynamic> data){
  return data.containsKey('code')
  ? Row(
    children: <Widget>[
      CupertinoButton( /* Display Only Close Button */
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
        child: Text('Add phone', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPhone()));
        },
      ),
      /*Close Button */
      CupertinoButton(
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
        child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: (){
          Navigator.pop(context);
        },
      )
    ],
  )
  : CupertinoButton( /* Display Only Close Button */
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
    child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
    onPressed: (){
      Navigator.pop(context, null);
    },
  );
}

