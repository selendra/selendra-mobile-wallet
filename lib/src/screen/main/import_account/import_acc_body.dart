import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/models/m_import_acc.dart';
import 'package:wallet_apps/src/screen/main/contents_backup.dart';
import 'package:wallet_apps/src/screen/main/import_user_info/import_user_infor.dart';

class ImportAccBody extends StatelessWidget{

  final ImportAccModel importAccModel;
  final Function onChanged;
  final Function onSubmit;

  ImportAccBody({
    this.importAccModel,
    this.onChanged,
    this.onSubmit
  });
  
  Widget build(BuildContext context){
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            MyAppBar(
              color: hexaCodeToColor(AppColors.cardColor),
              title: 'Import Account',
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Source Type',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: "#FFFFFF",
                      bottom: 16,
                    )
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: hexaCodeToColor(AppColors.secondary),
                                width: 1.5
                              )
                            )
                          ),
                          child: MyText(
                            text: "Mnemonic",
                            color: "#FFFFFF",
                          ),
                        )
                      ),

                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: MyText(
                            text: "Keystore (json)",
                            // color: "#FFFFFF",
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: MyInputField(
                      pLeft: 0, pRight: 0,
                      pBottom: 16.0,
                      labelText: "Mnemonic",
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      controller: importAccModel.mnemonicCon, 
                      focusNode: importAccModel.mnemonicNode, 
                      // validateField: validateFirstName, 
                      textColor: "#FFFFFF",
                      maxLine: null,
                      onChanged: onChanged, 
                      onSubmit: onSubmit
                    )
                  )

                  // Card(
                  //   child: MyText(
                  //     text: mnemonic,
                  //     textAlign: TextAlign.left,
                  //     fontSize: 25,
                  //     color: AppColors.secondary_text,
                  //     fontWeight: FontWeight.bold,
                  //     pLeft: 16, right: 16, top: 16, bottom: 16
                  //   )
                  // )
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImportUserInfo()
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