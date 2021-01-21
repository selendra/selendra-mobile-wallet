import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/create_user_info/user_infor.dart';

class ConfirmMnemonic extends StatelessWidget{

  List<Map<int, String>> mnemonicList = [
    {0: 'defense'}, 
    {1: "indoor"}, 
    {2: 'vendor'}, 
    {3: 'service'} ,
    {4: 'cream'}, 
    {5: 'hard'},
    {6: 'maid'}, 
    {7: 'detail'},
    {8: 'seat'}, 
    {9: 'mobile'}, 
    {10: 'position'},
    {11: 'kangaroo'}
  ];
  
  Widget build(BuildContext context){
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            MyAppBar(
              color: hexaCodeToColor(AppColors.cardColor),
              title: 'Create Account',
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Confirm the mnemonic',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: "#FFFFFF",
                      bottom: 12,
                    )
                  ),
                  
                  MyText(
                    textAlign: TextAlign.left,
                    text: 'Please click on the mnemonic in the correct order to confirm',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: "#FFFFFF",
                    bottom: 12,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: MyText(
                      text: 'Reset',
                      bottom: 16,
                      color: AppColors.secondary_text
                    )
                  ),

                  // Field of Mnemonic
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(bottom: 16),
                    color: hexaCodeToColor(AppColors.cardColor),
                  ),
                  
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1.5
                  ),
                  itemCount: mnemonicList.length,
                  itemBuilder: (context, int i){
                    return Container(
                      alignment: Alignment.center,
                      color: hexaCodeToColor(AppColors.cardColor),
                      height: 10,
                      child: MyText(
                        text: mnemonicList[i][i],
                        fontSize: 18,
                        color: AppColors.secondary_text,
                        fontWeight: FontWeight.bold,
                        // pLeft: 6, right: 10,
                      )
                    );
                  },
                )
                // builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //     maxCrossAxisExtent: 100,
                //     crossAxisSpacing: 10.0,
                //     mainAxisSpacing: 5.0
                //   ),//(orientation == Orientation.portrait) ? 2 : 3),
                //   // scrollDirection: Axis.horizontal,
                //   itemCount: 10,
                //   itemBuilder: (context, int i){
                //     return Container(
                //       color: hexaCodeToColor(AppColors.cardColor),
                //       height: 10,
                //       child: MyText(
                //         text: mnemonicList[i][i],
                //         fontSize: 25,
                //         color: AppColors.secondary_text,
                //         fontWeight: FontWeight.bold,
                //         pLeft: 6, right: 16, top: 16
                //       )
                //     );
                //   }
                // ),
              )
            ),

            Expanded(
              child: Container(),
            ),

            MyFlatButton(
              edgeMargin: EdgeInsets.only(left: 66, right: 66, bottom: 16),
              textButton: 'Next',
              action: () async {
                await dialog(context, Text('We are not allow you to screen shot mnemonic'), Text("Message"));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyUserInfo()
                  )
                );
              },
            )
            
          ],
        ),
      )
    );
  }
}