import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/index.dart';

class MenuBody extends StatelessWidget{
  
  final bool isHaveWallet; /* isHaveWallet By Default false */
  final Map<String, dynamic> userInfo;
  final MenuModel model;
  final PackageInfo packageInfo;
  final Function editProfile; final Function trxHistory;
  final Function trxActivity; final Function wallet;
  final Function changePin; final Function password;
  final Function addAssets; final Function signOut;
  final Function snackBar; final Function popScreen;
  final Function switchBio;
  final Function createPin;
  final Function callBack;

  MenuBody({
    this.isHaveWallet, this.userInfo, this.model, this.packageInfo, this.editProfile,
    this.trxHistory, this.trxActivity, this.addAssets, this.changePin, this.password, this.wallet,
    this.signOut, this.snackBar,  this.popScreen, this.switchBio,
    this.createPin,
    this.callBack
  });

  Widget build(BuildContext context){
    return Column(
      children: [

        MenuHeader(),

        // History
        MenuSubTitle(index: 0),

        MyListTile(
          index: 0,
          subIndex: 0,
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => TrxHistory("hello"))
            );
          },
        ),

        MyListTile(
          index: 0,
          subIndex: 1,
          onTap: () {
            // callBack(_result);
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => TrxActivity())
            );
          },
        ),

        // Wallet
        MenuSubTitle(index: 1),

        MyListTile(
          index: 1,
          subIndex: 0,
          onTap: (){
            createPin(context);
          },
        ),

        MyListTile(
          index: 1,
          subIndex: 1,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddAsset())
            );
          },
        ),

        // Security
        MenuSubTitle(index: 2),

        MyListTile(
          index: 2,
          subIndex: 0,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ChangePin())
            );
          },
        ),

        MyListTile(
          index: 2,
          subIndex: 1,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ChangePassword())
            );
          },
        ),

        MyListTile(
          enable: false,
          index: 2,
          subIndex: 2,
          trailing: Switch(
            value: model.switchBio,
            onChanged: switchBio,
          ),
          onTap: null,
        ),

        // Account
        MenuSubTitle(index: 3),
        
        MyListTile(
          index: 3,
          subIndex: 0,
          onTap: () async{
            await dialog(context, MyText(text: "Under reconstruction", color: "#000000"), Text("Message"));
            // Navigator.pop(context);
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(builder: (context) => ChangePassword())
            // );
          },
        ),

        MyListTile(
          index: 3,
          subIndex: 1,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  title: Center(
                    child: textScale(
                      text: "Are you sure you want to exit?",
                      hexaColor: "#000000",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text("No"),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        dialogLoading(context, content: "Logging out");
                        AppServices.clearStorage();
                        await Future.delayed(Duration(seconds: 1), () {
                          // Close Button
                          // Navigator.pop(context);
                          // // Close Dialog Loading
                          // Navigator.pop(context);
                          // // Close Drawer
                          // Navigator.pop(context);
                          // callBack({'log_out': true});
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => Login()
                            ),
                            ModalRoute.withName('/')
                          );
                        });
                      },
                    )
                  ],
                );
              }
            );
          },
        ),
      ]
    );
  }
}
