// import 'dart:html';

import 'package:contacts_service/contacts_service.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:wallet_apps/index.dart';

class MyBottomSheetItem extends StatelessWidget {
  final String subTitle;
  final String icon;
  final Function action;

  MyBottomSheetItem(
      {@required this.subTitle, @required this.icon, @required this.action});

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: action,
        child: Column(
          children: [
            SvgPicture.asset('assets/$icon',
                width: 30, height: 30, color: Colors.white),
            MyText(
              top: 6,
              text: subTitle,
              fontSize: 12,
            )
          ],
        ));
  }
}

/* -------------------------Transaction Method--------------------------- */

class TrxOptionMethod {
  static PostRequest _postRequest = PostRequest();

  static void selectContact(BuildContext context, List<dynamic> listPortfolio,
      Function resetDbdState) async {
    if (await Permission.contacts.request().isGranted) {
      String number = '';
      var response;
      final PhoneContact _contact =
          await FlutterContactPicker.pickPhoneContact();
      // final Contact _contact = await ContactsService.openDeviceContactPicker();
      //Get Contact And Asign To Number Variable

      if (_contact != null) {
        // await _postRequest.getWalletFromContact(
        //   "+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)  }" // Replace 0 At The First Index To Empty
        // ).then((value) async {
        //   if(value['status_code'] == 200 && value.containsKey('wallet')){
        //     response = await Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => SubmitTrx(value['wallet'], false, listPortfolio))
        //     );
        //     if (response["status_code"] == 200) {
        //       resetDbdState(null, "portfolio");
        //       Navigator.pop(context);
        //     }
        //   } else {
        //     await dialog(
        //       context,
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           textAlignCenter(text: value['message']),
        //           Container(
        //             margin: EdgeInsets.only(top: 5.0),
        //             child: textAlignCenter(text: "Do you want to invite this number 0${_contact.phoneNumber.number.replaceFirst("0", "", 0)}?")
        //           )
        //         ],
        //       ),
        //       textMessage(),
        //       action: FlatButton(
        //         child: Text("Invite"),
        //         onPressed: () async {
        //           Navigator.pop(context); // Close Dialog Invite
        //           dialogLoading(context); // Process Loading
        //           var _response = await _postRequest.inviteFriend("+855${_contact.phoneNumber.number.replaceFirst("0", "", 0)}");
        //           Navigator.pop(context); // Close Dialog Loading
        //           if (_response != null) {
        //             await dialog(context, Text(_response['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor)));
        //           }
        //         },
        //       )
        //     );
        //   }
        // });
      }
    }
  }

  static void navigateFillAddress(
      BuildContext context,
      List<dynamic> portfolioList,
      Function resetDbdState,
      WalletSDK sdk,
      Keyring keyring) async {
    var response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SubmitTrx("", true, portfolioList, sdk, keyring)));
    if (response['status_code'] == 200) {
      resetDbdState(null, "portfolio");
    }
  }

  /* Scan QR Code */
  static Future scanQR(BuildContext context, List<dynamic> portfolioList,
      Function resetDbdState, WalletSDK sdk, Keyring keyring) async {
    var _response = await Navigator.push(
        context,
        transitionRoute(QrScanner(
          portList: portfolioList,
          sdk: sdk,
          keyring: keyring,
        )));
    if (_response != null) {
      resetDbdState(null, "portfolio");
    }
  }
}
