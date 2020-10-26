import 'package:wallet_apps/index.dart';

class PrivateKeyBody extends StatelessWidget {

  final bool copy;
  final Function onChanged;

  // final Map data;

  PrivateKeyBody({
    this.copy,
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
              width: 350.0,
              padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.red,
                    value: copy,
                    onChanged: onChanged
                    // isCopy == false ? null : (data) {
                    //   userCheckBox();
                    // }
                  ),
                  MyText(text: "Already copy", color: "#FFFFFF",)
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
                        onTap: (){
                        },
                        child: MyText(
                          text: "Copy",
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
                      action: (){}
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