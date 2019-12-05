import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/private_key_dialog_screen/private_key_dialog_body.dart';

class DialogPrivateKeyWidget extends StatefulWidget{

  final String _privateKey;

  DialogPrivateKeyWidget(this._privateKey);
  @override
  State<StatefulWidget> createState() {
    return DialogPrivateKeyState();
  }
}

class DialogPrivateKeyState extends State<DialogPrivateKeyWidget>{

  bool isCheck = false, isSave = false, isCopy = false, disableButton = true;

  userCheckBox() {
    setState(() {
      if (isCheck == false) {
        isCheck = true;
      } else {
        isCheck = false;
      }
    });
  }

  /* Clip Private Key */
  userCopyKey() {
    setState(() {
      isCopy = true;
      Clipboard.setData(ClipboardData(text: widget._privateKey));
    });
  }

  Widget build(BuildContext context){
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Align(alignment: Alignment.center, child: containerTitleAppBar("Private Key")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          checkBoxContent(widget._privateKey, isCheck, isCopy, userCheckBox),
        ],
      ),
      actions: listButton(context, widget._privateKey,  isCopy, isCheck, userCopyKey)
    );
  }
}

