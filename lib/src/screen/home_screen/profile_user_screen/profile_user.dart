import 'package:wallet_apps/src/model/model_profile.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/private_key_dialog_screen/private_key_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_confirm_pin_code_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_pin_code_dialog.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/* Directory of file */
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/drawer_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './profile_user_body.dart';

class ProfileUserWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileUserState();
  }
}

class ProfileUserState extends State<ProfileUserWidget> {
  
  /* Variable */
  String error = '', _pin = '', _confirmPin = '', _privateKey; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();
  ModelProfile modelProfile = ModelProfile();
  Map<String, dynamic> userData;
  /* Login Inside Dialog */
  bool isProgress = false, isFetch = false, isTick = false, isSuccessPin = false, isHaveWallet = false;
  /* Property For RefetchUserData From GraphQL */
  bool reQueryUserData = false;

  /* InitState */
  @override
  void initState() {
    super.initState();
    // fetchUserData();
  }

  /* Fetch User Data From Local Storage*/
  void fetchUserData() async {
    int period = 1;
    /* If No ReQuery Period Of Fetch Data */
    if ( reQueryUserData == true) period = 2;
    /* Fetching Data */
    userData = await modelProfile.fetchDataOfUser();
    if (userData['wallet'] != null) isHaveWallet = true;
    await Future.delayed(Duration(seconds: period), (){
      setState(() {
        isFetch = true;
        reQueryUserData = false;
      });
    });
  }

  /* Set PIN Dialog */
  void dialogBox(BuildContext context) async {
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: 
      /* If PIN Not Yet Set */
      _pin == '' ?
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: SetPinDialog(error)
        );
      } :
      /* Set PIN Done And Then Set ConfirmPin */
      _confirmPin == '' ?
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: SetConfirmPinWidget(_pin),
        );
      } :
      /* Comfirm PIN Success Shower Dialog Of Private Key */
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: DialogPrivateKeyWidget(_privateKey),
        );
      }
    );
    /* From Set PIN Widget */
    if (result['widget'] == 'Pin'){
      _pin = result['pin'];
      /* CallBack */
      error = "PIN does not match";
      dialogBox(context);
    } else 
    /* From Set Confirm PIN Widget */
    if (result['widget'] == 'confirmPin'){
      if (result['compare'] == false) {
        _pin = '';
        /* CallBack */
        dialogBox(context);
      } else if (result["compare"] == true){
        _confirmPin = result['confirmPin'];
        _privateKey = result['_privateKey'];
        dialogBox(context);
      }
    } else 
    if (result['widget'] == 'dialogPrivateKey'){
      await Provider.fetchUserIds();
      snackBar(result['message']);
      setState(() {
        reQueryUserData = true;
      });
    }
  }

  /* ----------------------Side Bar -------------------------*/
  /* Trigger Drawer */
  void openMyDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }
  /* Log Out Method */
  void logOut() async {
    /* Loading */
    dialogLoading(context);
    Future.delayed(Duration(seconds: 2), () {
      clearStorage();
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /* Trigger Snack Bar Function */
  void snackBar(String contents) {
    final snackbar = SnackBar(
      content: Text(contents),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
  void _reFresh() async {
    await Provider.fetchUserIds();
    setState(() {
      reQueryUserData = true;
      isFetch = false;
    });
    _refreshController.refreshCompleted();
  }

  void nextPage() {
    
  }

  void popScreen() {
    Navigator.pop(context);
  }

  /* Build Function */
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
        controller: _refreshController,
        onRefresh: _reFresh,
        child: 
        // reQueryUserData == false 
        // ? 
        Stack(
          children: <Widget>[
            Container( /* Blur Background */
              child: profileUserBodyWidget(isHaveWallet, context, userData, snackBar, dialogBox, popScreen)
                // isFetch == true /* User Information */ /* IsFetch By Default false */
                // ? 
                // /* Progress Loading */
                // : Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     loading()
                //   ],
                // ),
            ),
          ],
        )
        // : Stack( /* ReQuery User Data With Graphql After Set PIN And Get Wallet */
        //   children: <Widget>[
        //     reQuery(
        //       loading(),
        //       queryUser(Provider.idsUser),
        //       "Profile",
        //       fetchUserData
        //     )
        //   ],
        // ),
      )
    );
  }
}