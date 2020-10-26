import 'package:wallet_apps/index.dart';

class ConfirmPinBody extends StatelessWidget{

  final GetWalletModel getWalletM;
  final Function onSubmit;
  final Function submit;

  ConfirmPinBody({
    this.getWalletM,
    this.onSubmit,
    this.submit
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
            text: "Please fill your confirm pin"
          ),

          Container(
            margin: EdgeInsets.only(left: 81, right: 81),
            child: Column(
              children: [
                MyPinput(
                  focusNode: getWalletM.confirmPinNode,
                  controller: getWalletM.confirmPinController,
                  getWalletM: getWalletM,
                  onSubmit: onSubmit,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: MyText(
                            text: "Clear",
                            color: "#FFFFFF",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ),
                    ),

                    Expanded(
                      child: MyFlatButton(
                        // width: 150,
                        textButton: "Submit",
                        buttonColor: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: size18,
                        hasShadow: true,
                        action: getWalletM.disableButton1 == true ? null : (){
                          submit();
                        }
                      )
                    )
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}