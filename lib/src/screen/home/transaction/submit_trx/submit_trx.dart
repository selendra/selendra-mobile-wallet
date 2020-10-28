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
  
  ModelScanPay _modelScanPay = ModelScanPay();

  FlareControls flareController = FlareControls();

  PostRequest _postRequest = PostRequest();

  bool disable = false;

  @override
  void initState() {
    AppServices.noInternetConnection(_modelScanPay.globalKey);
    _modelScanPay.controlReceiverAddress.text = widget._walletKey;
    _modelScanPay.portfolio = widget._listPortfolio;
    super.initState();
  }

  void fetchIDs() async {
    await Provider.fetchUserIds();
    setState(() {});
  }

  void removeAllFocus() {
    _modelScanPay.nodeAmount.unfocus();
    _modelScanPay.nodeMemo.unfocus();
  }

  Future<bool> validateInput() { /* Check User Fill Out ALL */
    if (_modelScanPay.controlAmount.text != null &&
        _modelScanPay.controlAmount.text != "" &&
        _modelScanPay.controlReceiverAddress != null &&
        _modelScanPay.controlReceiverAddress.text.isNotEmpty &&
        _modelScanPay.asset != null) {
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
    if (_modelScanPay.nodeAmount.hasFocus) {
      _modelScanPay.responseAmount = instanceValidate.validateSendToken(value);
      enableButton();
      if (_modelScanPay.responseAmount != null)
        return _modelScanPay.responseAmount += "wallet";
    }
    return _modelScanPay.responseWallet;
  }

  String validateAmount(String value) {
    if (_modelScanPay.nodeAmount.hasFocus) {
      _modelScanPay.responseAmount = instanceValidate.validateSendToken(value);
      enableButton();
      if (_modelScanPay.responseAmount != null)
        return _modelScanPay.responseAmount += "amount";
    }
    return _modelScanPay.responseAmount;
  }

  String validateMemo(String value) {
    if (_modelScanPay.nodeMemo.hasFocus) {
      _modelScanPay.responseMemo = instanceValidate.validateSendToken(value);
      enableButton();
      if (_modelScanPay.responseMemo != null)
        return _modelScanPay.responseMemo += "memo";
    }
    return _modelScanPay.responseMemo;
  }

  void onChanged(String value) {
    _modelScanPay.formStateKey.currentState.validate();
  }

  void onSubmit(BuildContext context) {
    if (_modelScanPay.nodeReceiverAddress.hasFocus){
      FocusScope.of(context).requestFocus(_modelScanPay.nodeAmount);
    } else if (_modelScanPay.nodeAmount.hasFocus) {
      FocusScope.of(context).requestFocus(_modelScanPay.nodeMemo);
    } else {
      if (_modelScanPay.enable == true) clickSend();
    }
  }

  void enableButton() {
    if (_modelScanPay.controlAmount.text != '' && _modelScanPay.asset != null)
      setState(() => _modelScanPay.enable = true);
    else if (_modelScanPay.enable == true)
      setState(() => _modelScanPay.enable = false);
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
      //   _modelScanPay.isPay = false;
      // });
      Navigator.pop(context, _response);
    });
  }

  void payProgres() { /* Loading For User Pay */
    setState(() {
      _modelScanPay.isPay = true;
    });
    processingSubmit();
  }

  void processingSubmit() async { /* Loading Processing Animation */
    int perioud = 500;
    while (_modelScanPay.isPay == true) {
      await Future.delayed(Duration(milliseconds: perioud), () {
        if (this.mounted) setState(() => _modelScanPay.loadingDot = ".");
        perioud = 300;
      });
      await Future.delayed(Duration(milliseconds: perioud), () {
        if (this.mounted) setState(() => _modelScanPay.loadingDot = ". .");
        perioud = 300;
      });
      await Future.delayed(Duration(milliseconds: perioud), () {
        if (this.mounted) setState(() => _modelScanPay.loadingDot = ". . .");
        perioud = 300;
      });
    }
  }

  void popScreen() { /* Close Current Screen */
    Navigator.pop(context, {});
  }

  void resetAssetsDropDown(String data) { /* Reset Asset */
    setState(() {
      _modelScanPay.asset = data;
    });
    enableButton();
  }

  void clickSend() async { /* Send payment */
    // Navigator.push(context, MaterialPageRoute(builder: (contxt) => FillPin()));
    await Future.delayed(Duration(milliseconds: 100), (){ // Unfocus All Field Input
      unFocusAllField();
    }); 
    _modelScanPay.pin = await dialogBox();
    payProgres();
    try {
      var _response = await _postRequest.sendPayment(_modelScanPay);
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
    } catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message"));
    }
    await Future.delayed(Duration(milliseconds: 50), () {
      removeAllFocus();
    });
  }

  void unFocusAllField(){
    _modelScanPay.nodeAmount.unfocus();
    _modelScanPay.nodeMemo.unfocus();
    _modelScanPay.nodeReceiverAddress.unfocus();
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
      key: _modelScanPay.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SubmitTrxBody(
              enableInput: widget.enableInput,
              dialog: dialogBox,
              scanPayM: _modelScanPay,
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
            _modelScanPay.isPay == false
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


