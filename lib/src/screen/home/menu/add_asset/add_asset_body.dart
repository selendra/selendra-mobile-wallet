import 'package:wallet_apps/index.dart';

Widget addAssetBody(
  BuildContext _context,
  ModelAsset _modelAsset,
  Function validateAssetCode, Function validateIssuer,
  Function popScreen, Function onChanged, Function onSubmit, Function submitAddAsset
) {
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        _context, 
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
              Icon(Icons.arrow_back, color: Colors.white,),
              Alignment.centerLeft,
              EdgeInsets.all(0),
              popScreen,
            ),
            containerTitle("Add Assets", double.infinity, Colors.white, FontWeight.normal)
          ],
        )
      ),
      Form(
        key: _modelAsset.formStateAsset,
        child: Expanded( /* Add Asset Body */
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField( /* Asset Code Field */
                      context: _context, 
                      labelText: "Asset Code", 
                      widgetName: "addAssetScreen",
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.next, 
                      controller: _modelAsset.controllerAssetCode, 
                      focusNode: _modelAsset.nodeAssetCode, 
                      validateField: validateAssetCode, 
                      onChanged: onChanged, 
                      action: onSubmit
                    ),
                  ),
                  Container( /* Issuer Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context, 
                      labelText: "Issuer",
                      widgetName: "addAssetScreen", 
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.done, 
                      controller: _modelAsset.controllerIssuer, 
                      focusNode: _modelAsset.nodeIssuer,
                      validateField: validateIssuer, 
                      onChanged: onChanged, 
                      action: onSubmit
                    ),
                  ),
                  customFlatButton( /* Add Asset Button */
                    _context, 
                    "Add assets", "addAssetScreen", AppColors.blueColor,
                    FontWeight.normal, 
                    size18,
                    EdgeInsets.only(top: 15.0),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(0,0,0,0.54),
                      blurRadius: 5.0
                    ),
                    _modelAsset.enable ? submitAddAsset : null 
                  )
                ],
              ),
            ),
          ),
        )
      ),
    ],
  );
}