import 'package:flutter_sms/flutter_sms.dart';
import 'package:wallet_apps/index.dart';

class ReferralProgramBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        MyAppBar(
          title: "Refer to friend",
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        SvgPicture.asset("assets/invitation.svg", width: double.infinity, height: 400),

        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          margin: EdgeInsets.only(bottom: 40 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              MyText(
                bottom: 16,
                text: "REWARD 50 TOKEN OF SEL",
                fontSize: 25,
                color: "#FFFFFF",
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),

              MyText(
                text: "Invite friends join SELENDRA and get reward token of SEL each time they complete their sign up.",
                textAlign: TextAlign.left,
              )
            ],
          )
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Column(
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //       },
            //       child: MyCircularImage(
            //         colorImage: Colors.white,
            //         width: 70, height: 70,
            //         imageHeight: 30, imageWidth: 30,
            //         padding: const EdgeInsets.all(17),
            //         margin: EdgeInsets.only(top: 16, bottom: 16),
            //         decoration: BoxDecoration(
            //           color: hexaCodeToColor(AppColors.secondary),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black54.withOpacity(0.3), 
            //               blurRadius: 40.0, 
            //               spreadRadius: 2.0, 
            //               offset: Offset(2.0, 5.0),
            //             )
            //           ],
            //           borderRadius: BorderRadius.circular(40)
            //         ),
            //         imagePath: "assets/icons/telegram.svg"
            //       )
            //     ),

            //     MyText(
            //       text: "Telegram",
            //       fontSize: 18,
            //       color: "#FFFFFF"
            //     )
            //   ],
            // ),

            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    String _result = await sendSMS(message: 'https://selendra.com/', recipients: ["+85515894139"]);
                    // print(_result);
                  },
                  child: MyCircularImage(
                    colorImage: Colors.white,
                    width: 70, height: 70,
                    imageHeight: 30, imageWidth: 30,
                    margin: EdgeInsets.all(16),
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: hexaCodeToColor(AppColors.secondary),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.3), 
                          blurRadius: 40.0, 
                          spreadRadius: 2.0, 
                          offset: Offset(2.0, 5.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(40)
                    ),
                    imagePath: "assets/icons/message.svg"
                  )
                ),

                MyText(
                  text: "SMS",
                  fontSize: 18,
                  color: "#FFFFFF"
                )
              ],
            ),

            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    try{
                      ShareExtend.share(
                        'https://selendra.com/',
                        'text',
                        sharePanelTitle: "Code: hello world",
                        subject: "Download selendra: ",
                      );
                    } catch (e) {
                    }
                  },
                  child: MyCircularImage(
                    colorImage: Colors.white,
                    width: 70, height: 70,
                    imageHeight: 30, imageWidth: 30,
                    padding: const EdgeInsets.all(17),  
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: hexaCodeToColor(AppColors.secondary),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.3), 
                          blurRadius: 40.0, 
                          spreadRadius: 2.0, 
                          offset: Offset(2.0, 5.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(40)
                    ),
                    imagePath: "assets/icons/more.svg"
                  )
                ),

                MyText(
                  text: "More",
                  fontSize: 18,
                  color: "#FFFFFF"
                )
              ]
            )
          ],
        )
      ],
    );
  }
}