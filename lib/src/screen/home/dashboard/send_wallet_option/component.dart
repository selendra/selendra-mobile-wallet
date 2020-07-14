import 'package:wallet_apps/index.dart';

class TrxOption {
  
  static void selectContact({
    BuildContext context,
    PostRequest postRequest,
    List<dynamic> listPortfolio,
    Function resetDbtState
  }) async {
    var response;
    final PhoneContact _contact = await FlutterContactPicker.pickPhoneContact();
    if (_contact != null) {
      await postRequest.getWalletFromContact(
        "+855${AppServices.removeZero(_contact.phoneNumber.number.replaceFirst("0", "", 0))}" // Replace 0 At The First Index To Empty
      ).then((value) async {
        if(value['status_code'] == 200 && value.containsKey('wallet')){
          response = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => SendPayment(value['wallet'], false, listPortfolio))  
          );
          if (response["status_code"] == 200) {
            resetDbtState(null, "portfolio");
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
                var _response = await postRequest.inviteFriend("+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
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
}