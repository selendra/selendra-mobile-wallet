import 'package:wallet_apps/src/screen/home/dashboard/get_wallet_from_contact/get_wallet_from_contact_body.dart';
import 'package:wallet_apps/index.dart';

class GetWalletFromContact extends StatefulWidget{

  final List<dynamic> _listPortFolio;

  GetWalletFromContact(this._listPortFolio);

  @override
  State<StatefulWidget> createState() {
    return GetWalletFromContactState();
  }

}

class GetWalletFromContactState extends State<GetWalletFromContact>{

  ModelGetWalletFromContact _modelGetWalletFromContact;

  @override
  initState(){
    _modelGetWalletFromContact = ModelGetWalletFromContact();
    super.initState();
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

  @override
  dispose(){
    _modelGetWalletFromContact.controllerToContact.clear();
    _modelGetWalletFromContact.nodeToContact.unfocus();
    super.dispose();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
          child: Column(
            children: <Widget>[
              containerAppBar( /* AppBar */
                context,
                Row(
                  children: <Widget>[
                    iconAppBar( /* Arrow Back Button */
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      Alignment.centerLeft,
                      EdgeInsets.all(0),
                      (){
                        Navigator.pop(context);
                      },
                    ),
                    containerTitle("Wallet look up", 50.0, Colors.white, FontWeight.normal)
                  ],
                )
              ),
              Flexible(
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: getWalletFromContactBody(
                      context: context,
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