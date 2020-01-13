import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/private_key_dialog_screen/private_key_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_confirm_pin_code_dialog.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/set_pin_code_dialog_screen/set_pin_code_dialog.dart';
import 'package:wallet_apps/src/screen/main_screen/welcome_to_zees_screen/welcome_to_zees.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/* Directory of file */
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import './profile_user_body.dart';

class ProfileUser extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ProfileUserState();
  }
}

class ProfileUserState extends State<ProfileUser> {
  
  /* Variable */
  String error = '', _pin = '', _confirmPin = '';
  var _result; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();
  ModelUserInfo modelProfile = ModelUserInfo();
  Map<String, dynamic> userData, _message;
  /* Login Inside Dialog */
  bool isProgress = false, isFetch = false, isTick = false, isSuccessPin = false, isHaveWallet = false;
  /* Property For RefetchUserData From GraphQL */
  bool reQueryUserData = false;
  
  ModelSignUp _modelSignUp = ModelSignUp();

  /* InitState */
  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  void fetchUserData() async { 
    await getUserProfile().then((_response){ /* Get Request User Data And Set To Control To Each Fill */
      _modelSignUp.wallet = _response['wallet'];
      setState(() {
        _modelSignUp.controlFirstName.text = _response['first_name'];
        _modelSignUp.controlMidName.text = _response['mid_name'];
        _modelSignUp.controlLastName.text = _response['last_name'];
        _modelSignUp.genderLabel = _response['gender'] == "M" ? "Male" : "Female";
        _modelSignUp.gender = _response['gender'];
      });
    });
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
  /* Log Out Method */
  void logOut() async {
    /* Loading */
    dialogLoading(context);
    Future.delayed(Duration(seconds: 2), () {
      clearStorage();
      Navigator.pop(context);
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeToZee()), ModalRoute.withName('/'));
    });
  }

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

  void nextPage() {
    
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
        child: 
        // reQueryUserData == false 
        // ? 
        Stack(
          children: <Widget>[
            Container( /* Blur Background */
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: profileUserBodyWidget(isHaveWallet, context, userData, _modelSignUp, snackBar, dialogBox, popScreen),
              )
                // isFetch == true /* User Information */ /* IsFetch By Default false */
                // ? 
                // /* Progress  Loading */
                // : Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     loading()
                //   ],
                // ),
            ),
          ],
        )
      )
    );
  }
}