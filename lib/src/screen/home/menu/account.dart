import 'package:flutter/material.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:wallet_apps/src/components/component.dart';
import 'package:wallet_apps/src/components/route_animation.dart';

import '../../../../index.dart';

class Account extends StatefulWidget {
  final WalletSDK sdk;
  final keyring;

  Account(this.sdk, this.keyring);
  static const route = '/account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  KeyPairData _currentAcc;

  void deleteAccout() async {
    await dialog(context, Text('Are you sure to delete your account?'),
        Text('Delete Account'),
        action: FlatButton(onPressed: _deleteAccount, child: Text('Delete')));
  }

  Future<void> _deleteAccount() async {
    try {
      await widget.sdk.api.keyring.deleteAccount(
        widget.keyring,
        _currentAcc,
      );
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context,
          RouteAnimation(enterPage: Welcome()), ModalRoute.withName('/'));
    } catch (e) {
      await dialog(context, Text(e.toString()), Text('Opps'));
    }
  }

  Future<void> _changePassword(String oldPass, String newPass) async {
    try {
      final res = await widget.sdk.api.keyring
//        .changePassword(widget.keyring, _testAcc, _testPass, 'a654321');
          .changePassword(widget.keyring, oldPass, newPass);

      if (res != null) {
        await dialog(context, Text('You password has changed!!'),
            Text('Change Passworld'));
      }
    } catch (e) {
      await dialog(context, Text(e.toString()), Text('Opps'));
    }
  }

  void changePasswordDialog() async {
    await dialog(
        context,
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Old Password'),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'New Password'),
              ),
            ],
          ),
        ),
        Text('Change Password'));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.keyring.keyPairs.length > 0) {
        setState(() {
          _currentAcc = widget.keyring.keyPairs[0];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                MyAppBar(
                  title: "Account",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: hexaCodeToColor(AppColors.cardColor),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              right: 16, top: 16, left: 16, bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Name: ${_currentAcc.name}',
                                color: "#FFFFFF",
                                fontSize: 18,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              MyText(
                                text: 'Public Key: ${_currentAcc.pubKey}',
                                color: "#FFFFFF",
                                fontSize: 18,
                                overflow: TextOverflow.fade,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              MyText(
                                text: 'Address: ${_currentAcc.address}',
                                color: "#FFFFFF",
                                fontSize: 18,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                          //child: SvgPicture.asset('assets/male_avatar.svg'),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            changePasswordDialog();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 70,
                            child: MyText(
                              text: 'Change Password',
                              color: "#FFFFFF",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            //child: SvgPicture.asset('assets/male_avatar.svg'),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: deleteAccout,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 70,
                            child: MyText(
                              text: 'Delete Account',
                              color: "#FF0000",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            //child: SvgPicture.asset('assets/male_avatar.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
