import 'package:wallet_apps/index.dart';

class FillPin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FillPinState();
  }
}

class FillPinState extends State<FillPin> {

  TextEditingController _pinPutController = TextEditingController();

  FocusNode _pinNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      // border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.grey.withOpacity(0.5)
    );
  }

  @override
  initState(){
    _pinNode.requestFocus();
    super.initState();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: MyText(
        text: "Fill pin ",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PinPut(
            focusNode: _pinNode,
            controller: _pinPutController,
            fieldsCount: 4,
            selectedFieldDecoration: _pinPutDecoration,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              color: Colors.grey.withOpacity(0.5)
            ),
            followingFieldDecoration: _pinPutDecoration,
            onSubmit: (String value){
              Navigator.pop(context, _pinPutController.text);
            },
          ),
          
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: MyText(
                text: "Close"
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}