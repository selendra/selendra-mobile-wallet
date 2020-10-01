import 'package:wallet_apps/index.dart';

class AddAssetBody extends StatelessWidget{

  final ModelAsset assetM;
  final Function validateAssetCode; 
  final Function validateIssuer;
  final Function popScreen; 
  final Function onChanged; 
  final Function onSubmit; 
  final Function submitAsset;

  AddAssetBody({
    this.assetM,
    this.validateAssetCode,
    this.validateIssuer,
    this.popScreen,
    this.onChanged,
    this.onSubmit,
    this.submitAsset
  });

  Widget build(BuildContext context) {
    return Column(
      children: [

        Flexible(
          child: MyAppBar(
            title: "Add asset",
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),

        Expanded(
          child: SvgPicture.asset('assets/add_data.svg', width: 293, height: 216),
        ),

        Expanded(
          child: Form(
            key: assetM.formStateAsset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyInputField(
                  pBottom: 16.0,
                  labelText: "Asset Code",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputType: TextInputType.text,
                  controller: assetM.controllerAssetCode,
                  focusNode: assetM.nodeAssetCode,
                  validateField: validateAssetCode,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),
                
                MyInputField(
                  pBottom: 29,
                  labelText: "Issuer",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputType: TextInputType.text,
                  controller: assetM.controllerIssuer,
                  focusNode: assetM.nodeIssuer,
                  validateField: validateIssuer,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),

                MyFlatButton(
                  textButton: "Submit",
                  buttonColor: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: size18,
                  edgeMargin: EdgeInsets.only(left: 66, right: 66),
                  hasShadow: true,
                  action: assetM.enable == false ? null : submitAsset
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}