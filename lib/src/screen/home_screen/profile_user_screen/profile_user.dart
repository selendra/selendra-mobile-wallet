import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/private_key_dialog_screen/private_key_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_confirm_pin_code_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_pin_code_dialog.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/* Directory of file */
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import './profile_user_body.dart';

class ProfileUser extends StatefulWidget{

  final Map<String, dynamic> _userData;

  ProfileUser(this._userData);

  @override
  State<StatefulWidget> createState() {
    return ProfileUserState();
  }
}

class ProfileUserState extends State<ProfileUser> {
  
  /* Variable */
  String error = '', _pin = '', _confirmPin = '';
  dynamic _result = ""; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();
  ModelUserInfo modelProfile = ModelUserInfo();
  Map<String, dynamic> _message;
  /* Login Inside Dialog */
  bool isProgress = false, isFetch = false, isTick = false, isSuccessPin = false, isHaveWallet = false;
  /* Property For RefetchUserData From GraphQL */
  bool reQueryUserData = false;
  
  ModelSignUp _modelSignUp = ModelSignUp();

  /* InitState */
  @override
  void initState() {
    setUserInfo();
    super.initState();
  }

  void setUserInfo() async {
    _modelSignUp.controlFirstName.text = widget._userData['first_name'];
    _modelSignUp.controlMidName.text = widget._userData['mid_name'];
    _modelSignUp.controlLastName.text = widget._userData['last_name'];
    _modelSignUp.genderLabel = widget._userData['gender'] == "M" ? "Male" : "Female";
    _modelSignUp.gender = widget._userData['gender'];
    await fetchData("user_token").then((_response){ /* Fetch Token To Concete Authorization Update Profile User Info */
      _modelSignUp.token = _response['token'];
    });
  }

  void dialogBox(BuildContext context) async { /* Set PIN Dialog */
    _result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: 
      _pin == '' ? /* If PIN Not Yet Set */
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: SetPinDialog(error)
        );
      } :
      _confirmPin == '' ? /* Set PIN Done And Then Set Confirm Pin */
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: SetConfirmPin(_pin),
        );
      } :
      (BuildContext context) { /* Comfirm PIN Success Shower Dialog Of Private Key */
        return Material(
          color: Colors.transparent,
          child: PrivateKeyDialog(_message),
        );
      }
    );
    /* From Set PIN Widget */
    if (_result != null) {
      if (_result['widget'] == 'Pin'){
        _pin = _result['pin'];
        /* CallBack */
        dialogBox(context);
      } else 
      /* From Set Confirm PIN Widget */
      if (_result['widget'] == 'confirmPin'){
        if (_result['compare'] == false) {
          _pin = '';
          error = "PIN does not match"; /* Set Error */
          dialogBox(context); /* CallBack */
        } else if (_result["compare"] == true){
          _confirmPin = _result['confirm_pin'];
          _message = _result;
          await Future.delayed(Duration(milliseconds: 200), () { /* Wait A Bit and Call DialogBox Function Again */
            dialogBox(context); /* CallBack */
          });
        }
      } else { /* Success Set PIN And Push SnackBar */
        _pin = ""; /* Reset Pin Confirm PIN And Result To Empty */
        _confirmPin = "";
        snackBar(_result['message']); /* Copy Private Key Success And Show Message From Bottom */
      }
    } else {
      _pin = ""; /* Reset Pin Confirm PIN And Result To Empty */
      _confirmPin = "";
    }
  }

  /* ----------------------Side Bar -------------------------*/

  /* Trigger Snack Bar Function */
  void snackBar(String contents) {
    final snackbar = SnackBar(
      duration: Duration(seconds: 2),
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

  void popScreen() {
    Navigator.pop(context, _result);
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
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: profileUserBodyWidget(isHaveWallet, context, widget._userData, _modelSignUp, snackBar, dialogBox, popScreen),
              )
            ),
          ],
        )
      )
    );
  }
}