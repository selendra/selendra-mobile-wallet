import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/confirm_mnemonic.dart';

class CreateMnemonic extends StatelessWidget{

  String mnemonic = "defense indoor vendor service cream hard maid dtail seat mobile position kangaroo";
  
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
                      text: 'Backup mnemonic',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: "#FFFFFF",
                      bottom: 12,
                    )
                  ),
                  
                  MyText(
                    textAlign: TextAlign.left,
                    text: 'Use paper and pen to correctly copy mnemonics',
                    fontWeight: FontWeight.w500,
                    color: "#FFFFFF",
                    bottom: 12,
                  ),

                  Card(
                    child: MyText(
                      text: mnemonic,
                      textAlign: TextAlign.left,
                      fontSize: 25,
                      color: AppColors.secondary_text,
                      fontWeight: FontWeight.bold,
                      pLeft: 16, right: 16, top: 16, bottom: 16
                    )
                  )
                ],
              ),
            ),

            Expanded(
              child: Container(),
            ),

            MyFlatButton(
              edgeMargin: EdgeInsets.only(left: 66, right: 66, bottom: 16),
              textButton: 'Next',
              action: () async {
                await dialog(
                  context, 
                  Text('Sorry! we are not allow you to screen shot mnemonic, please write down your mnemonic on paper before you go next !'), 
                  Text("Please note", style: TextStyle(fontWeight: FontWeight.bold)),
                  action: FlatButton(
                    child: Text('Next'),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmMnemonic()
                        )
                      );
                    },
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