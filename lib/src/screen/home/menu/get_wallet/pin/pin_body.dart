import 'package:wallet_apps/index.dart';

class PinBody extends StatelessWidget{

  final GetWalletModel getWalletM;
  final Function onChanged;
  final Function onSubmit;
  final Function submit;
  final Function clearField;

  PinBody({
    this.getWalletM,
    this.onChanged,
    this.onSubmit,
    this.submit,
    this.clearField,
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
          
          // Display when pin and confirm does not match
          if (getWalletM.error) MyText(
            bottom: 30.0,
            width: 300.0,
            text: "Pin does not match",
          ),

          MyText(
            bottom: 60.0,
            width: 300.0,
            text: "Please fill your pin"
          ),

          Container(
            margin: EdgeInsets.only(left: 81, right: 81),
            child: Column(
              children: [

                MyPinput(
                  getWalletM: getWalletM,
                  controller: getWalletM.pinController,
                  focusNode: getWalletM.pinNode,
                  onChanged: onChanged,
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
                          onTap: clearField,
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
                        textButton: "Next",
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