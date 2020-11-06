import 'package:wallet_apps/index.dart';

class Pin extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return PinState();
  }
}

class PinState extends State<Pin>{

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  GetWalletModel getWalletM = GetWalletModel();

  var response;

  @override
  void initState() {
    getWalletM.pinController = TextEditingController();
    getWalletM.pinNode.requestFocus();
    super.initState();
  }

  void onSubmit(String value){
    setState(() {
      getWalletM.disableButton1 = false;
    });
  }

  void onChanged(String value){
    print("Onchanged $value");
    if (getWalletM.error && getWalletM.pinController.text.isEmpty) setState((){
      getWalletM.error = false;
      getWalletM.disableButton1 = true;
    });
  }

  void submit () async {
    // Map<String, dynamic> popData = {
    //   "dialog_name": "Pin",
    //   "pin": getWalletM.pinController.text
    // };
    getWalletM.pinNode.unfocus();
    response = await Navigator.push(
      context,
      transitionRoute(ConfirmPin(getWalletM: getWalletM,))
    );
    print(response);

    // Pin And ConfirmPin Do not Match
    if (response != null){
      if (response['response'] == false){
        setState((){
          getWalletM.error = true;
          getWalletM.pinNode.requestFocus();
        });
      } 
      
      // Pin And ConfirmPin Do Match And Navigate To PrivateKey Screen
      else if (response['message'].length == 3 ) {
        response = await Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateKey(data: response,)));
        // Succcessfully copy
        if (response != null){
          Navigator.pop(context, response);
        } else {
          Navigator.pop(context);
        }
      } else {
        await dialog(context, Text(response['message']), Text("Message"));
        Navigator.pop(context);
      }
    }
  }

  void clearField(){
    setState((){
      getWalletM.pinController.text = '';
      if (getWalletM.error) setState((){getWalletM.error = false;});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: PinBody(
          getWalletM: getWalletM,
          onChanged: onChanged,
          onSubmit: onSubmit,
          submit: submit,
          clearField: clearField
        ),
      ),
    );
  }
}