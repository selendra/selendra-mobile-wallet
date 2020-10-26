import 'package:wallet_apps/index.dart';

Widget fillDocumentBodyWidget(
  BuildContext context,
  ModelDocument _modelDocument,
  Function setDocumentName,
  Function triggerImage, Function validatorUser, Function popScreen, 
  Function resetImage, Function triggerDate, Function clickSubmit, Function textChanged, Function navigatePage
) {
  return Column(
    children: <Widget>[
      MyAppBar(
        title: "Upload Documents"
      ),
      Expanded( /* Field User Input */
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
            child: Column(
              children: <Widget>[
                Container( /* Document Type */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    context: context, 
                    labelText: "Document type",
                    widgetName: 'fillDocsScreen',
                    textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                    inputAction: TextInputAction.next, 
                    controller: _modelDocument.controllerDocsType, 
                    focusNode: _modelDocument.nodeDocsType, 
                    validateField: instanceValidate.validateDocument,
                    onChanged: textChanged, 
                    action: null
                  ),
                ),
                Container( /* Document Number */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField( 
                    context: context, 
                    labelText: "Document number", 
                    widgetName: 'fillDocsScreen',
                    textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                    inputAction: TextInputAction.next, 
                    controller: _modelDocument.controllerDocsNumber, 
                    focusNode: _modelDocument.nodeDocsNumber, 
                    validateField: instanceValidate.validateDocument, 
                    onChanged: textChanged, 
                    action: null
                  ),
                ),
                Container( /* Issue Date */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker( 
                    context, 
                    "Issue date", "fillDocsScreen",
                    Icons.calendar_today, 
                    _modelDocument, 
                    triggerDate
                  ),
                ),
                Container( /* Expired Date */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker( 
                    context, 
                    "Expired date", "fillDocsScreen", 
                    Icons.calendar_today, 
                    _modelDocument, 
                    triggerDate
                  ),
                ),
                Container( /* Upload documents */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker(
                    context, 
                    "Upload documents", "fillDocsScreen", 
                    Icons.camera_alt, 
                    _modelDocument, 
                    navigatePage
                  ),
                ),
                Container( /* Take selfie */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker(
                    context, 
                    "Take selfie", "fillDocsScreen", 
                    Icons.camera_alt, 
                    _modelDocument, 
                    navigatePage
                  ),
                ),
                FutureBuilder( /* Submit button */
                  future: validatorUser(),
                  builder: (context, snapshot){
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: customFlatButton(
                        context, 
                        "Submit", "fillDocsScreen", AppColors.blueColor,                 
                        FontWeight.normal,
                        size18,
                        EdgeInsets.only(top: 15.0),
                        EdgeInsets.only(top: size15, bottom: size15),
                        BoxShadow(
                          color: Color.fromRGBO(0,0,0,0.54),
                          blurRadius: 5.0
                        ), 
                        snapshot.hasData ? clickSubmit : null
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ),
      )
    ],
  );
}
