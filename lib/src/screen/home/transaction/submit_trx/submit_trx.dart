import 'dart:ui';
import 'package:flare_flutter/flare_controls.dart';
import 'package:wallet_apps/index.dart';

class SubmitTrx extends StatefulWidget {
  
  final String _walletKey;
  final List<dynamic> _listPortfolio;
  final bool enableInput;

  SubmitTrx(this._walletKey, this.enableInput, this._listPortfolio);
  @override
  State<StatefulWidget> createState() {
    return SubmitTrxState();
  }
}

class SubmitTrxState extends State<SubmitTrx> {
  
  ModelScanPay _scanPayM = ModelScanPay();

  FlareControls flareController = FlareControls();

  PostRequest _postRequest = PostRequest();

  bool disable = false;

  @override
  void initState() {
    AppServices.noInternetConnection(_scanPayM.globalKey);
    _scanPayM.controlReceiverAddress.text = widget._walletKey;
    _scanPayM.portfolio = widget._listPortfolio;
    super.initState();
  }

  void fetchIDs() async {
    await Provider.fetchUserIds();
    setState(() {});
  }

  void removeAllFocus() {
    _scanPayM.nodeAmount.unfocus();
    _scanPayM.nodeMemo.unfocus();
  }

  Future<bool> validateInput() { /* Check User Fill Out ALL */
    if (_scanPayM.controlAmount.text != null &&
        _scanPayM.controlAmount.text != "" &&
        _scanPayM.controlReceiverAddress != null &&
        _scanPayM.controlReceiverAddress.text.isNotEmpty &&
        _scanPayM.asset != null) {
      return Future.delayed(Duration(milliseconds: 50), () {
        return true;
      });
    }
    return null;
  }

  Future<String> dialogBox() async { /* Show Pin Code For Fill Out */
    String _result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: FillPin(),
        );
      }
    );
    return _result;
  }

  String validateWallet(String value){
    if (_scanPayM.nodeAmount.hasFocus) {
      _scanPayM.responseAmount = instanceValidate.validateSendToken(value);
      enableButton();
      if (_scanPayM.responseAmount != null)
        return _scanPayM.responseAmount += "wallet";
    }
    return _scanPayM.responseWallet;
  }

  String validateAmount(String value) {
    if (_scanPayM.nodeAmount.hasFocus) {
      _scanPayM.responseAmount = instanceValidate.validateSendToken(value);
      enableButton();
      if (_scanPayM.responseAmount != null)
        return _scanPayM.responseAmount += "amount";
    }
    return _scanPayM.responseAmount;
  }

  String validateMemo(String value) {
    if (_scanPayM.nodeMemo.hasFocus) {
      _scanPayM.responseMemo = instanceValidate.validateSendToken(value);
      enableButton();
      if (_scanPayM.responseMemo != null)
        return _scanPayM.responseMemo += "memo";
    }
    return _scanPayM.responseMemo;
  }

  void onChanged(String value) {
    _scanPayM.formStateKey.currentState.validate();
  }

  void onSubmit(BuildContext context) {
    if (_scanPayM.nodeReceiverAddress.hasFocus){
      FocusScope.of(context).requestFocus(_scanPayM.nodeAmount);
    } else if (_scanPayM.nodeAmount.hasFocus) {
      FocusScope.of(context).requestFocus(_scanPayM.nodeMemo);
    } else {
      if (_scanPayM.enable == true) clickSend();
    }
  }

  void enableButton() {
    if (_scanPayM.controlAmount.text != '' && _scanPayM.asset != null)
      setState(() => _scanPayM.enable = true);
    else if (_scanPayM.enable == true)
      setState(() => _scanPayM.enable = false);
  }

  Future enableAnimation(var _response) async {
    setState(() {
      disable = true;
    });
    flareController.play('Checkmark');
    Timer(Duration(seconds: 2), (){
      // setState(() {
      //   disable = false;
      // });
      // setState(() {
      //   _scanPayM.isPay = false;
      // });
      Navigator.pop(context, _response);
    });
  }

  void payProgres() { /* Loading For User Pay */
    setState(() {
      _scanPayM.isPay = true;
    });
    processingSubmit();
  }

  void processingSubmit() async { /* Loading Processing Animation */
    int perioud = 500;
    while (_scanPayM.isPay == true) {
      await Future.delayed(Duration(milliseconds: perioud), () {
        if (this.mounted) setState(() => _scanPayM.loadingDot = ".");
        perioud = 300;
      });
      await Future.delayed(Duration(milliseconds: perioud), () {
        if (this.mounted) setState(() => _scanPayM.loadingDot = ". .");
        perioud = 300;
      });
      await Future.delayed(Duration(milliseconds: perioud), () {
        if (this.mounted) setState(() => _scanPayM.loadingDot = ". . .");
        perioud = 300;
      });
    }
  }

  void popScreen() { /* Close Current Screen */
    Navigator.pop(context, {});
  }

  void resetAssetsDropDown(String data) { /* Reset Asset */
    setState(() {
      _scanPayM.asset = data;
    });
    enableButton();
  }

  void clickSend() async { /* Send payment */
    // Navigator.push(context, MaterialPageRoute(builder: (contxt) => FillPin()));
    await Future.delayed(Duration(milliseconds: 100), (){ // Unfocus All Field Input
      unFocusAllField();
    }); 
    _scanPayM.pin = await dialogBox();
    payProgres();
    try {
      var _response = await _postRequest.sendPayment(_scanPayM);
      if (_response["status_code"] == 200) {
        if (!_response.containsKey('error')) {
          await enableAnimation(_response);
          // await dialog(context, textAlignCenter(text: _response["message"]), Icon(Icons.done_outline, color: getHexaColor(AppColors.blueColor)));
        } else {
          await dialog(context, textAlignCenter(text: _response["error"]['message']), warningTitleDialog());
        }
      } else {
        await dialog(context, textAlignCenter(text: 'Something goes wrong'), warningTitleDialog());
      }
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message")); 
      snackBar(_scanPayM.globalKey, e.message.toString());
    } catch (e) {
      await dialog(context, Text(e.message.toString()), Text("Message")); 
    }
    await Future.delayed(Duration(milliseconds: 50), () {
      removeAllFocus();
    });
  }

  void unFocusAllField(){
    _scanPayM.nodeAmount.unfocus();
    _scanPayM.nodeMemo.unfocus();
    _scanPayM.nodeReceiverAddress.unfocus();
  }

  PopupMenuItem item(Map<String, dynamic> list) { /* Display Drop Down List */
    return PopupMenuItem(
      value: list.containsKey("asset_code") /* Check Asset Code Key */
      ? list["asset_code"]
      : "XLM",
      child: Align(
        alignment: Alignment.center,
        child: Text(
          list.containsKey("asset_code") /* Check Asset Code Key */
          ? list["asset_code"]
          : "XLM",
        ),
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scanPayM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SubmitTrxBody(
              enableInput: widget.enableInput,
              dialog: dialogBox,
              scanPayM: _scanPayM,
              validateWallet: validateWallet, 
              validateAmount: validateAmount, 
              validateMemo: validateMemo,
              onChanged: onChanged,
              onSubmit: onSubmit,
              payProgress: payProgres,
              validateInput: validateInput,
              clickSend: clickSend,
              resetAssetsDropDown: resetAssetsDropDown,
              item: item
            ),
            _scanPayM.isPay == false
            ? Container()
            : BackdropFilter( // Fill Blur Background
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CustomAnimation.flareAnimation(flareController, "assets/animation/check.flr", "Checkmark")
                  )
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}


