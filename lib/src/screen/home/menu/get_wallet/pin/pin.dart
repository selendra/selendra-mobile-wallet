import 'package:wallet_apps/index.dart';

class Pin extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return PinState();
  }
}

class PinState extends State<Pin>{

  GetWalletModel getWalletM = GetWalletModel();

  @override
  void initState() {
    getWalletM.pinNode.requestFocus();
    super.initState();
  }

  void onSubmit(String value){
    setState(() {
      getWalletM.disableButton1 = false;
    });
    if (getWalletM.error) getWalletM.error = false;
  }

  void submit () async {
    // Map<String, dynamic> popData = {
    //   "dialog_name": "Pin",
    //   "pin": getWalletM.pinController.text
    // };
    var response = await Navigator.push(
      context,
      transitionRoute(ConfirmPin(getWalletM: getWalletM,))
    );

    if (response == false){
      setState((){
        getWalletM.error = true;
      });
    }
  }

  void clearField(){
    setState((){
      getWalletM.pinController.text = '';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: PinBody(
          getWalletM: getWalletM,
          onSubmit: onSubmit,
          submit: submit,
          clearField: clearField
        ),
      ),
    );
  }
}