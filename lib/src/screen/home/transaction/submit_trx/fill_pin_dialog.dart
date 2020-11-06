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

  BoxConstraints get boxConstraint {
    return  BoxConstraints(minWidth: 60, minHeight: 80);
  }

  @override
  initState(){
    _pinPutController.clear();
    _pinNode.requestFocus();
    super.initState();
  }

  @override
  void dispose(){
    _pinPutController.clear();
    super.dispose();
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

            selectedFieldDecoration: _pinPutDecoration.copyWith(
              color: Colors.grey.withOpacity(0.2)
            ),

            submittedFieldDecoration: _pinPutDecoration,
            followingFieldDecoration: _pinPutDecoration,

            // submittedFieldDecoration: .error 
            // ? .pinPutDecoration.copyWith(
            //   border: Border.all(width: 1, color: Colors.red)
            // ) 
            // : .pinPutDecoration,

            // followingFieldDecoration: .error 
            // ? .pinPutDecoration.copyWith(
            //   border: Border.all(width: 1, color: Colors.red)
            // )
            // : .pinPutDecoration,

            eachFieldConstraints: boxConstraint,
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            onSubmit: (value){
              Navigator.pop(context, value);
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