import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/menu/get_wallet/private_key/private_key_body.dart';

class PrivateKey extends StatefulWidget {

  final Map<String, dynamic> data;

  PrivateKey({
    this.data
  });

  @override
  _PrivateKeyState createState() => _PrivateKeyState();
}

class _PrivateKeyState extends State<PrivateKey> {

  bool copy = false;

  void onChanged(bool value){
    setState(() {
      copy = value;
    });
  }

  void saveData(){
    Clipboard.setData(ClipboardData(text: widget.data['message']["seed"]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: PrivateKeyBody(
          copy: copy,
          onChanged: onChanged
          // data: widget.data
        )
      ),
    );
  }
}