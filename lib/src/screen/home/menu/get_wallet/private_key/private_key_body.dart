import 'package:circular_check_box/circular_check_box.dart';
import 'package:wallet_apps/index.dart';

class PrivateKeyBody extends StatelessWidget {

  final Map<String, dynamic> data;
  final bool copy;
  final bool check;
  final Function copyPress;
  final Function onChanged;

  // final Map data;

  PrivateKeyBody({
    this.data,
    this.copy,
    this.check,
    this.copyPress,
    this.onChanged
  //   // this.data
  });

  @override
  Widget build(BuildContext context) {

    final double left = 25;
    final double right = 25;

    return Column(
      children: [
        MyAppBar(
          title: "Private key"
        ),

        Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: SvgPicture.asset('assets/secure.svg', width: 300, height: 250)
            ),
            
            // Display when pin and confirm does not match
            MyText(
              bottom: 30.0,
              left: left, right: right,
              text: """Please keep your key secure. This secret key will only be showed to you once.\nSelendra will not be able to help you recover it if lost.""",
              textAlign: TextAlign.left,
            ),

            Card(
              margin: EdgeInsets.only(left: left, right: right, bottom: 30),
              color: hexaCodeToColor(AppColors.cardColor),
              child:Container(
                margin: EdgeInsets.all(left), 
                child: Row(
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: MyText(
                        text: "Mnemonic:",
                        textAlign: TextAlign.start,
                      )
                    ),
                    
                    Expanded(
                      child: MyText(
                        left: 6,
                        text: "${data['message']['seed']}",
                        color: AppColors.secondary_text,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ),
            ),

            Container(
              width: 400.0,
              padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularCheckBox(
                    disabledColor: Colors.white,
                    inactiveColor: Colors.white,
                    activeColor: hexaCodeToColor(AppColors.secondary),
                    value: check, onChanged: copy ? onChanged : null),
                  MyText(text: "Accept copied", color: "#FFFFFF",)
                ],
              ),
            ),

            Container(
              // padding: EdgeInsets.only(left: 16, right: 81),
              width: 350.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: copyPress,
                        child: MyText(
                          text: copy ? "Copied" : "Copy",
                          color: "#FFFFFF",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ),
                  ),

                  Expanded(
                    child: MyFlatButton(
                      textButton: "Done",
                      buttonColor: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: size18,
                      hasShadow: true,
                      action: !check ? null : (){
                        Navigator.pop(context, {"success": true});
                      }
                    )
                  )
                ],
              )
            ),
          ],
        )
      ],
    );
  }
}