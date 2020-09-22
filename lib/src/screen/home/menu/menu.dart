import 'dart:ui';
import 'package:wallet_apps/index.dart';

class Menu extends StatefulWidget{

  final Map<String, dynamic> _userData; final PackageInfo _packageInfo; final Function callBack;

  Menu(this._userData, this._packageInfo, this.callBack);

  @override
  State<StatefulWidget> createState() {
    return MenuState();
  }
}

class MenuState extends State<Menu> {
  
  /* Variable */
  String error = '', _pin = '', _confirmPin = '';
  Map<String, dynamic> _result; 
  final _globalKey = GlobalKey<ScaffoldState>();
  ModelUserInfo _modelUserInfo = ModelUserInfo();
  Map<String, dynamic> _message;
  
  MenuModel _menuModel = MenuModel();

  LocalAuthentication _localAuth = LocalAuthentication();

  /* Login Inside Dialog */
  bool isProgress = false, isFetch = false, isTick = false, isSuccessPin = false, isHaveWallet = false;

  Backend _backend = Backend();

  /* InitState */
  @override
  void initState() {
    _result = {};
    AppServices.noInternetConnection(_globalKey);
    setUserInfo();
    checkAvailableBio();
    super.initState();
  }

  @override
  void dispose(){
    widget.callBack(_result);
    super.dispose();
  }

  void popScreen() {
    widget.callBack(_result);
    Navigator.pop(context);
  }

  void setUserInfo() async {
    if (widget._userData.length != 0){
      _modelUserInfo.userData = {
        "first_name": widget._userData['first_name'],
        "mid_name": widget._userData['mid_name'],
        "last_name": widget._userData['last_name'],
        "gender": widget._userData['gender'] == "M" ? "Male" : "Female",
        "label": "profile"
      };
      await StorageServices.fetchData("user_token").then((_response){ /* Fetch Token To Concete Authorization Update Profile User Info */
        _backend.mapData = _response;
      });
    }
  }

  Future<void> createPin(BuildContext context) async { /* Set PIN Dialog */
    _result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: 
      _pin == '' ? /* If PIN Not Yet Set */
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: disableNativePopBackButton(SetPinDialog(error))
        );
      } :
      _confirmPin == '' ? /* Set PIN Done And Then Set Confirm Pin */
      (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: disableNativePopBackButton(SetConfirmPin(_pin)),
        );
      } :
      (BuildContext context) { /* Comfirm PIN Success Shower Dialog Of Private Key */
        return Material(
          color: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => await Future(() => false),
            child: disableNativePopBackButton(PrivateKeyDialog(_message)),
          ),
        );
      }
    );
    
    if (_result.isNotEmpty){/* From Set PIN Widget */
      if (_result["dialog_name"] == 'Pin'){
        _pin = _result['pin'];
        createPin(context); /* callBack */
      } else 
      if (_result["dialog_name"] == 'confirmPin'){ /* From Set Confirm PIN Widget */
        if (_result['compare'] == false) {
          _pin = '';
          error = "PIN does not match"; /* Enable Error Text*/
          createPin(context); /* callBack */
        } else if (_result["compare"] == true){
          _confirmPin = _result['confirm_pin'];
          _message = _result;
          await Future.delayed(Duration(milliseconds: 200), () { /* Wait A Bit and Call setPinGetWallet Function Again */
            createPin(context); /* callBack */
          });
        }
      } else { /* Success Set PIN And Push SnackBar */
        _pin = ""; /* Reset Pin Confirm PIN And Result To Empty */
        _confirmPin = "";
        snackBar(_result['message']); /* Copy Private Key Success And Show Message From Bottom */
      }
    } else { /* Reset Pin Confirm PIN And Result To Empty */
      _pin = "";  
      _confirmPin = "";
    }
  }
  
  /* --------------------Function-------------------- */
  void editProfile() async {
    _result = await Navigator.push(context, transitionRoute(EditProfile(_modelUserInfo.userData)));
    widget.callBack(_result);
    Navigator.pop(context);
  } 

  void trxHistroy() {
    widget.callBack(_result);
    Navigator.pop(context);
    Navigator.push(context, transitionRoute(TrxHistory(widget._userData['wallet'])));
  }

  void trxActivity() { 
  }

  void wallet() async { /* User Get Wallet */ 
    await createPin(context); 
  }

  void changePin() { 
    Navigator.push(context, transitionRoute(ChangePin()));
  }

  void password() {
    Navigator.push(context, transitionRoute(ChangePassword()));
  }

  void addAssets() async {
    _result = await Navigator.push(context, transitionRoute(AddAsset()));
  }

  void checkAvailableBio() async {
    await StorageServices.fetchData('biometric').then((value) {
      if (value != null){
        if (value['bio'] == true){
          setState(() {
            _menuModel.switchBio = value['bio'];
          });
        }
      }
    });
  }

  void switchBiometric(bool value) async {
    if (value){
      await authenticateBiometric().then((values) async {
        if (_menuModel.authenticated){
          _menuModel.switchBio = value;
          await StorageServices.setData({'bio': values}, 'biometric');
        }
      });
    } else {
      await authenticateBiometric().then((values) async {
        if(values) {
          _menuModel.switchBio = value;
          await StorageServices.removeKey('biometric');
        }
      });
    }
    // // Reset Switcher
    setState(() { });
  }

  Future<bool> authenticateBiometric() async {
    try {
      // Trigger Authentication By Finger Print
      _menuModel.authenticated = await _localAuth.authenticateWithBiometrics(
        localizedReason: '',
        useErrorDialogs: true,
        stickyAuth: true
      );
    } on PlatformException catch (e){ }
    return _menuModel.authenticated;
  }
  
  void signOut() async { // Log Out All User Input
  }

  /* ----------------------Side Bar -------------------------*/

  /* Trigger Snack Bar Function */
  void snackBar(String contents) {
    final snackbar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(contents),
    );
    _globalKey.currentState.showSnackBar(snackbar);
  }

  Widget build(BuildContext context){
    return Drawer(
      child: SafeArea(
        child: Container(
          width: 305,
          color: hexaCodeToColor(AppColors.bgdColor),
          child: MenuBody(
            isHaveWallet: isHaveWallet, 
            userInfo: widget._userData,
            model: _menuModel ,
            packageInfo: widget._packageInfo,
            editProfile: editProfile,  
            trxHistory: trxHistroy,
            trxActivity: trxActivity, 
            wallet: wallet, 
            changePin: changePin, 
            password: password,
            addAssets: addAssets, 
            signOut: signOut, 
            snackBar: snackBar, 
            popScreen: popScreen,
            switchBio: switchBiometric,
            callBack: widget.callBack
          ),
        ),
      ),
    );
  //   Scaffold(
  //     backgroundColor: Colors.transparent,
  //     key: _globalKey,
  //     body: BackdropFilter( // Fill Blur Background
  //       filter: ImageFilter.blur(
  //         sigmaX: 5.0,
  //         sigmaY: 5.0,
  //       ),
  //       child: Container(
  //         padding: EdgeInsets.all(19), 
  //         child: SafeArea(
  //           child: SingleChildScrollView(
  //             physics: BouncingScrollPhysics(),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: hexaCodeToColor(AppColors.bgdColor),
  //                 borderRadius: BorderRadius.circular(10),
  //                 border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
  //               ),
  //               child: MenuBody(
  //                 isHaveWallet: isHaveWallet, 
  //                 userInfo: widget._userData,
  //                 model: _menuModel ,
  //                 packageInfo: widget._packageInfo,
  //                 editProfile: editProfile,  trxHistory: trxHistroy,
  //                 trxActivity: trxActivity, wallet: wallet, 
  //                 changePin: changePin, password: password,
  //                 addAssets: addAssets, signOut: signOut, 
  //                 snackBar: snackBar, popScreen: popScreen,
  //                 switchBio: switchBiometric,
  //               )
  //             ),
  //           ),
  //         )
  //       )
  //     ),
  //   );
  }
}