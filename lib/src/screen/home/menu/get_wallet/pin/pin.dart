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
      getWalletM.disableButton = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: PinBody(
          getWalletM: getWalletM,
          onSubmit: onSubmit,
        ),
      ),
    );
  }
}