import 'package:wallet_apps/index.dart';

class PrivateKeyBody extends StatelessWidget {

  final bool copy;
  final bool check;
  final Function copyPress;
  final Function onChanged;

  // final Map data;

  PrivateKeyBody({
    this.copy,
    this.check,
    this.copyPress,
    this.onChanged
  //   // this.data
  });

  @override
  Widget build(BuildContext context) {
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
              width: 350.0,
              text: """Please keep your key secure. This secret key will only be showed to you once.\nSelendra will not be able to help you recover it if lost.""",
            ),

            Container(
              width: 400.0,
              padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.red,
                    value: check,
                    onChanged: copy ? onChanged : null,
                    // isCopy == false ? null : (data) {
                    //   userCheckBox();
                    // }
                  ),
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