import 'package:wallet_apps/index.dart';

class ConfirmPin extends StatefulWidget {

  final GetWalletModel getWalletM;

  ConfirmPin({
    this.getWalletM
  });
  
  @override
  State<StatefulWidget> createState() {
    return ConfirmPinState();
  }
}

class ConfirmPinState extends State<ConfirmPin>{

  @override
  void initState() {
    widget.getWalletM.confirmPinNode.requestFocus();
    super.initState();
  }

  @override
  void dispose(){
    widget.getWalletM.confirmPinController.clear();
    super.dispose();
  }

  void onSubmit(String value){
    setState(() {
      widget.getWalletM.disableButton2 = false;
    });
  }

  void submit () {
    if (widget.getWalletM.pinController.text != widget.getWalletM.confirmPinController.text){
      Navigator.pop(context, false);
    }
    // Map<String, dynamic> popData = {
    //   "dialog_name": "ConfirmPin",
    //   "Confirmpin": widget.getWalletM.ConfirmpinController.text
    // };
    // Navigator.pop(context, popData);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: ConfirmPinBody(
          getWalletM: widget.getWalletM,
          onSubmit: onSubmit,
          submit: submit
        ),
      ),
    );
  }
}