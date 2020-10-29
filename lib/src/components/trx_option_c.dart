// import 'dart:html';

import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallet_apps/index.dart';

class MyBottomSheetItem extends StatelessWidget {

  final String subTitle;
  final String icon;
  final Function action;

  MyBottomSheetItem({
    @required this.subTitle,
    @required this.icon,
    @required this.action
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          
          SvgPicture.asset('assets/$icon', width: 30, height: 30, color: Colors.white),

          MyText(
            top: 6,
            text: subTitle,
            fontSize: 12,
          )
        ],
      )
    );
  }
}


/* -------------------------Transaction Method--------------------------- */

class TrxOptionMethod {

  static PostRequest _postRequest = PostRequest();
  
  static void selectContact(
    BuildContext context,
    List<dynamic> listPortfolio,
    Function resetDbdState
  ) async {

    if (await Permission.contacts.request().isGranted){
      String number = '';
      var response;
      final Contact _contact = await ContactsService.openDeviceContactPicker();
      // Get Contact And Asign To Number Variable 
      _contact.phones.forEach((element) async {
        number = element.value;
      });
      
      if (_contact != null) {
        await _postRequest.getWalletFromContact(
          "+855${number.replaceFirst("0", "", 0)  }" // Replace 0 At The First Index To Empty
        ).then((value) async {
          if(value['status_code'] == 200 && value.containsKey('wallet')){
            response = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => SubmitTrx(value['wallet'], false, listPortfolio))  
            );
            if (response["status_code"] == 200) {
              resetDbdState(null, "portfolio");
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
                    child: textAlignCenter(text: "Do you want to invite this number 0${number.replaceFirst("0", "", 0)}?")
                  )
                ],
              ), 
              textMessage(), 
              action: FlatButton(
                child: Text("Invite"),
                onPressed: () async {
                  Navigator.pop(context); // Close Dialog Invite
                  dialogLoading(context); // Process Loading
                  var _response = await _postRequest.inviteFriend("+855${number.replaceFirst("0", "", 0)}");
                  Navigator.pop(context); // Close Dialog Loading
                  if (_response != null) {
                    await dialog(context, Text(_response['message'], textAlign: TextAlign.center,), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor)));
                  }
                },
              )
            );
          }
        });
      }
    }
  }

  static void navigateFillAddress(BuildContext context, List<dynamic> portfolioList, Function resetDbdState) async {
    var response = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SubmitTrx("", true, portfolioList))
    );
    if (response['status_code'] == 200) {
      resetDbdState(null, "portfolio");
    }
  }

  /* Scan QR Code */
  static void scanQR(BuildContext context, List<dynamic> portfolioList, Function resetDbdState) async {
    
    var _response = await Navigator.push(context, transitionRoute(QrScanner(portList: portfolioList)));

    if (_response['status_code'] == 200) {
      resetDbdState(null, "portfolio");
    }
  }
  
}
