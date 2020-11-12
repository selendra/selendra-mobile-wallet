import 'package:wallet_apps/index.dart';

class Pin extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return PinState();
  }
}

class PinState extends State<Pin>{

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  GetWalletModel _getWalletM = GetWalletModel();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  var response;

  @override
  void initState() {
    _getWalletM.pinController = TextEditingController();
    _getWalletM.pinNode.requestFocus();
    super.initState();
  }

  void onSubmit(String value){
    setState(() {
      _getWalletM.disableButton1 = false;
    });
  }

  void onChanged(String value){
    if (_getWalletM.error && _getWalletM.pinController.text.isEmpty) setState((){
      _getWalletM.error = false;
      _getWalletM.disableButton1 = true;
    });
  }

  void submit () async {

    _getWalletM.pinNode.unfocus();
    response = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => (ConfirmPin(getWalletM: _getWalletM,)))
    ); 

    print("Get wallet $response");

    print("Get wallet ${response['message'].runtimeType}");

    if (response != null){
      // Pin And ConfirmPin Do not Match
      if (response['match'] == false){
        setState((){
          _getWalletM.error = true;
          _getWalletM.pinNode.requestFocus();
        });
      } 
      // Code 001 When User Register With Email & Need To Add Phone Number
      else if (response['code'] == '001'){
        await dialog(
          context, 
          Text(response['message'], textAlign: TextAlign.center),
          Text("Message"),
          action: FlatButton(
            child: Text("Add phone"),
            onPressed: () async {
              // Push Replace Dialog Add Phone With Add Phone Screen 
              response = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPhone()));
              //Close Dialog
              Navigator.pop(context);

              if (response == null) {
                Navigator.pop(context);
              } else {
                dialogLoading(context);

                // Get Wallet
                _backend.response = await _postRequest.retreiveWallet(_getWalletM.confirmPinController.text);

                // Close Dialog
                Navigator.pop(context);
                _backend.mapData = json.decode(_backend.response.body);
                
                response = await Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateKey(data: _backend.mapData))); 
                Navigator.pop(context, response);
              }
            }
          )
        );  
      } 
      // Already Have Wallet
      // else if ( !((response['message'].runtimeType).toString() == 'String') ) {
      //   await dialog(context, Text(response['message'].toString()), Text("Message"));
      //   Navigator.pop(context);
      // }
      // Pin And ConfirmPin Do Match And Navigate To PrivateKey Screen
      else if ( !((response['message'].runtimeType).toString() == 'String') ) {
        print(response);
        response = await Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateKey(data: response,)));
        // Succcessfully copy
        if (response != null){
          Navigator.pop(context, response);
        } else {
          Navigator.pop(context);
        }
      }
      // Already Have Wallet Or Not Complete Get wallet
      else Navigator.pop(context, null);
    }
  }

  void clearField(){
    setState((){
      _getWalletM.pinController.text = '';
      if (_getWalletM.error) setState((){_getWalletM.error = false;});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: PinBody(
          getWalletM: _getWalletM,
          onChanged: onChanged,
          onSubmit: onSubmit,
          submit: submit,
          clearField: clearField
        ),
      ),
    );
  }
}