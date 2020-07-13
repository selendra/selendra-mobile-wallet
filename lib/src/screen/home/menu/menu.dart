import 'dart:ui';
import 'package:wallet_apps/index.dart';

class DrawerLayout extends StatefulWidget{

  final Map<String, dynamic> _userData; final PackageInfo _packageInfo; final Function drawerCallBack;

  DrawerLayout(this._userData, this._packageInfo, this.drawerCallBack);

  @override
  State<StatefulWidget> createState() {
    return DrawerLayoutState();
  }
}

class DrawerLayoutState extends State<DrawerLayout> {
  
  /* Variable */
  String error = '', _pin = '', _confirmPin = '';
  dynamic _result; 
  final _globalKey = GlobalKey<ScaffoldState>();
  ModelUserInfo _modelUserInfo = ModelUserInfo();
  Map<String, dynamic> _message;

  /* Login Inside Dialog */
  bool isProgress = false, isFetch = false, isTick = false, isSuccessPin = false, isHaveWallet = false;

  /* InitState */
  @override
  void initState() {
    _result = {};
    AppServices.noInternetConnection(_globalKey);
    setUserInfo();
    super.initState();
  }

  @override
  void dispose(){
    widget.drawerCallBack(_result);
    super.dispose();
  }

  void popScreen() {
    widget.drawerCallBack(_result);
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
        _modelUserInfo.token = _response['token'];
      });
    }
  }

  Future<void> setPinGetWallet(BuildContext context) async { /* Set PIN Dialog */
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
    if (_result != '' && _result != null) { /* From Set PIN Widget */
      if (_result['widget'] == 'Pin'){
        _pin = _result['pin'];
        setPinGetWallet(context); /* drawerCallBack */
      } else 
      if (_result['widget'] == 'confirmPin'){ /* From Set Confirm PIN Widget */
        if (_result['compare'] == false) {
          _pin = '';
          error = "PIN does not match"; /* Enable Error Text*/
          setPinGetWallet(context); /* drawerCallBack */
        } else if (_result["compare"] == true){
          _confirmPin = _result['confirm_pin'];
          _message = _result;
          await Future.delayed(Duration(milliseconds: 200), () { /* Wait A Bit and Call setPinGetWallet Function Again */
            setPinGetWallet(context); /* drawerCallBack */
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
  void navigateEditProfile() async {
    _result = await Navigator.push(context, transitionRoute(EditProfile(_modelUserInfo.userData)));
    widget.drawerCallBack(_result);
    Navigator.pop(context);
  } 

  void navigateTrxHistory() {
    widget.drawerCallBack(_result);
    Navigator.pop(context);
    Navigator.push(context, transitionRoute(TrxHistory(widget._userData['wallet'])));
  }

  void navigateAcivity() { 
    widget.drawerCallBack(_result);
    Navigator.pop(context);
    Navigator.push(context, transitionRoute(TransactionActivity()));
  }

  void navigateGetWallet() async { /* User Get Wallet */ 
    await setPinGetWallet(context); 
  }

  void navigateChangePIN() { 
    Navigator.push(context, transitionRoute(ChangePin()));
  }

  void navigateChangePass() {
    Navigator.push(context, transitionRoute(ChangePassword()));
  }

  void navigateAddAssets() async {
    _result = await Navigator.push(context, transitionRoute(AddAsset()));
  }
  
  void signOut() async { // Log Out All User Input
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
                  Navigator.pushAndRemoveUntil(
                    context, 
                    transitionRoute(WelcomeToZee()),
                    ModalRoute.withName('/')
                  );
                });
              },
            )
          ],
        );
      }
    );
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _globalKey,
      body: BackdropFilter( // Fill Blur Background
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          padding: EdgeInsets.all(19), 
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                color: getHexaColor(AppConfig.darkBlue75),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: <Widget>[
                    profileUserBody(
                      isHaveWallet, 
                      context, 
                      widget._userData, 
                      widget._packageInfo,
                      navigateEditProfile, navigateTrxHistory,
                      navigateAcivity, navigateGetWallet, 
                      navigateChangePIN, navigateChangePass,
                      navigateAddAssets, signOut, 
                      snackBar,  setPinGetWallet, popScreen
                    )
                  ],
                )
              ),
            ),
          )
        )
      ),
    );
  }
}