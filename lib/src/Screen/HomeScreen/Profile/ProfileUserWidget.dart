/* Package of flutter */
import 'package:Wallet_Apps/src/Graphql_Service/Query_Document.dart';
import 'package:Wallet_Apps/src/Graphql_Service/ReQueryGraphQL.dart';
import 'package:Wallet_Apps/src/Model/Model_Profile.dart';
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Provider_General.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart' as prefix0;
import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/DialogPrivateKey/DialogPrivateKeyWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/SetPinCode/SetConfirmPin.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/SetPinCode/SetPin.dart';
import 'package:Wallet_Apps/src/Services/Remove_All_Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/* Directory of file */
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Drawer.dart';
import './ProfileUserBody.dart';

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
  ModelProfile modelProfile = ModelProfile();
  Map<String, dynamic> userData;
  /* Login Inside Dialog */
  bool isProgress = false, isFetch = false, isTick = false, isSuccessPin = false, isHaveWallet = false;
  /* Property For RefetchUserData From GraphQL */
  bool reQueryUserData = false; String userIds;


  /* InitState */
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  /* Fetch User Data From Local Storage*/
  void fetchUserData() async {
    int period = 1;

    /* If No ReQuery Period Of Fetch Data */
    if ( reQueryUserData == false) period = 1;
    else period = 2;
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
  dialogBox(BuildContext context) async {
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: 
      /* If PIN Not Yet Set */
      _pin == '' ? 
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: SetPinWidget(error)
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
        userIds = Provider.idsUser;
        reQueryUserData = true;
        isFetch = false;
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
    setState(() => isProgress = true );
    Future.delayed(Duration(seconds: 2), () {
      clearStorage();
      setState(() => isProgress = false );
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /* Trigger Snack Bar Function */
  snackBar(String contents) {
    final snackbar = SnackBar(
      content: Text(contents),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  /* Build Function */
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appbarWidget(openMyDrawer, titleAppBar('Profiles'), snackBar),
      drawer: Stack(
        children: <Widget>[
          drawerOnly(context, logOut),
          isProgress == false ? Container() : loading()
        ],
      ),
      body: reQueryUserData == false 
      ? Stack(
        children: <Widget>[
          /* User Information */
          /* IsFetch By Default false */
          isFetch == true ?
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: bodyWidget(context, userData, snackBar, dialogBox, isHaveWallet),
          )
          /* Progress Loading */
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              loading()
            ],
          ),
        ],
      )
      /* ReQuery User Data With Graphql After Set PIN And Get Wallet */
      :reQuery(
        bodyWidget(context, userData, snackBar, dialogBox, isHaveWallet),
        queryUser(userIds),
        "Profile",
        fetchUserData
      ), 
    );
  }
}