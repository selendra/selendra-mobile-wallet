import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/create_mnemoic.dart';

class ContentsBackup extends StatelessWidget{

  final double bpSize = 16.0;
  
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
                      text: 'Backup prom',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: "#FFFFFF",
                      bottom: bpSize,
                    )
                  ),
                  
                  MyText(
                    textAlign: TextAlign.left,
                    text: 'Getting a mnemonic equals ownership of the wallet asset',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: "#FFFFFF",
                    bottom: bpSize,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Backup mnemonic',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: "#FFFFFF",
                      bottom: bpSize,
                    )
                  ),
                  MyText(
                    textAlign: TextAlign.left,
                    text: 'Use paper and pen to correctly copy mnemonics',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: "#FFFFFF",
                    bottom: bpSize,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Offline storage',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: "#FFFFFF",
                      bottom: bpSize,
                    )
                  ),
                  MyText(
                    textAlign: TextAlign.left,
                    text: 'Kepp it safe to a safe place on the isolated network\nDo not share and store mnemonics in a networked environment, such as emails, photo albums, social applications',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: "#FFFFFF",
                  ),
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
                await dialog(context, Text('We are not allow you to screen shot mnemonic'), Text("Message"));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateMnemonic()
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