import 'package:wallet_apps/index.dart';

class FromContact extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return FromContactState();
  }

}

class FromContactState extends State<FromContact>{

  ModelGetWalletFromContact _modelGetWalletFromContact;

  @override
  initState(){
    _modelGetWalletFromContact = ModelGetWalletFromContact();
    super.initState();
  }

  @override
  dispose(){
    _modelGetWalletFromContact.controllerToContact.clear();
    _modelGetWalletFromContact.nodeToContact.unfocus();
    super.dispose();
  }
  
  String validatePhoneNumber(String value){
    if (_modelGetWalletFromContact.nodeToContact.hasFocus){
      _modelGetWalletFromContact.responseToContactField = instanceValidate.validatePhone(value);
      if (_modelGetWalletFromContact.responseToContactField == null) enableButton(true);
      else if (_modelGetWalletFromContact.enable) enableButton(false);
    }
    return _modelGetWalletFromContact.responseToContactField;
  }

  void enableButton(bool enable){
    setState((){
      _modelGetWalletFromContact.enable = enable;
    });
  }

  void onChanged(String value){
    _modelGetWalletFromContact.formState.currentState.validate();
  }

  void onSubmit(BuildContext context){
    if (_modelGetWalletFromContact.nodeToContact.hasFocus){
      if (_modelGetWalletFromContact.enable) submitToContact(context);
    }
  }

  void submitToContact(BuildContext context) async {
    // dialogLoading(context, content: "Requesting");
    // var response = await getWalletFromContact(_modelGetWalletFromContact);
    // Navigator.pop(context); // Close Dialog Loading
    // if(response['status_code'] == 200 && response.containsKey('wallet')){
    //   response = await Navigator.push(
    //     context, 
    //     MaterialPageRoute(builder: (context) => SendPayment(response['wallet'], false, widget._listPortFolio))  
    //   );
    //   if (response["status_code"] == 200) {
    //     Navigator.pop(context, response);
    //   }
    // } else {
    //   await dialog(context, textAlignCenter(text: response['message']), textMessage());
    // }
    // print("Hello");
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
          child: Column(
            children: <Widget>[

              MyAppBar(
                title: "Wallet look up",
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              
              Flexible(
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: FromContactBody(
                      modelGetWalletFromContact: _modelGetWalletFromContact,
                      validatePhoneNumber: validatePhoneNumber,
                      onChanged: onChanged,
                      onSubmit: onSubmit,
                      submitToContact: submitToContact,
                    ), /* Scan Pay Body Widget */
                  ),
                ),
              ),
            ],
          )
        )
    );
  }

}