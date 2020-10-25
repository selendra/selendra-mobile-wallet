import 'package:wallet_apps/index.dart';

class PinBody extends StatelessWidget{

  final GetWalletModel getWalletM;
  final Function onSubmit;

  PinBody({
    this.getWalletM,
    this.onSubmit
  });

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            title: "Get wallet",
            margin: EdgeInsets.only(bottom: 16.0),
            onPressed: (){
              Navigator.pop(context);
            }
          ),

          Container(
            margin: EdgeInsets.only(bottom: 30.0),
            child: SvgPicture.asset('assets/pin.svg', width: 300, height: 250)
          ),

          MyText(
            bottom: 60.0,
            width: 300.0,
            text: "Please fill your pin"
          ),

          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: PinPut(
              focusNode: getWalletM.pinNode,
              controller: getWalletM.pinController,
              fieldsCount: 4,
              selectedFieldDecoration: getWalletM.pinPutDecoration,
              submittedFieldDecoration: getWalletM.pinPutDecoration.copyWith(
                color: Colors.grey.withOpacity(0.5)
              ),
              followingFieldDecoration: getWalletM.pinPutDecoration,
              eachFieldConstraints: getWalletM.boxConstraint,
              onSubmit: onSubmit,
            ),
          ),

          Row(
            children: [
              GestureDetector(
                child: MyText(
                  text: "Clear",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}