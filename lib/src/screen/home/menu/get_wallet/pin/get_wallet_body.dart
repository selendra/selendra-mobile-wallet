import 'package:wallet_apps/index.dart';

class GetWallet extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return GetWalletState();
  }
}

class GetWalletState extends State<GetWallet>{

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: PinBody(),
      ),
    );
  }
}