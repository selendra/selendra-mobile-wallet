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

  Backend _backend = Backend();

  PostRequest _postRequest = PostRequest();

  @override
  void initState() {
    widget.getWalletM.confirmPinController = TextEditingController();
    widget.getWalletM.confirmPinNode = FocusNode();
    Timer(Duration(milliseconds: 500), (){
      widget.getWalletM.confirmPinNode.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void onSubmit(String value){
    setState(() {
      widget.getWalletM.disableButton2 = false;
    });
  }

  void clearInput(){
    setState((){
      widget.getWalletM.confirmPinController.text = '';
    });
  }

  void submit() async {

    widget.getWalletM.confirmPinNode.unfocus();

    dialogLoading(context);

    if (widget.getWalletM.pinController.text != widget.getWalletM.confirmPinController.text){
      Navigator.pop(context, {"response": false});
    } else {
      _backend.response = await _postRequest.retreiveWallet(widget.getWalletM.confirmPinController.text);

      // Close Loading
      Navigator.pop(context);

      _backend.mapData = json.decode(_backend.response.body);
      _backend.mapData.addAll({"response": true});
      Navigator.pop(context, _backend.mapData);
      //   Navigator.pop(context, {"response": true, "message": {"seed": "Hello world"}});
      // });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: ConfirmPinBody(
          getWalletM: widget.getWalletM,
          onClear: clearInput,
          onSubmit: onSubmit,
          submit: submit
        ),
      ),
    );
  }
}