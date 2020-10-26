import 'package:wallet_apps/index.dart';

Widget documentsBodyWidget(
  BuildContext context,
  Bloc bloc,
  ModelDocument _modelDocuments,
  Function popScreen, Function navigatePage
) {
  return Column(
    children: <Widget>[
      MyAppBar(
        title: "Upload Documents",
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 22.0),
                child: Text("Scan the Front", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 29.17),
                child: Text(
                  "Take photo of your front ID card Passport or other documents", 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Container( /* Card of sample take photo */
                margin: EdgeInsets.only(bottom: 29.17),
                child: Image.asset("assets/front_picture.png", width: double.infinity, fit: BoxFit.fill,),
              ),
              Container( /* Upload documents */
                margin: EdgeInsets.only(bottom: 12.0),
                child: fieldPicker(
                  context, 
                  "Take photo", "addDocumentScreen", 
                  Icons.camera_alt, 
                  _modelDocuments, 
                  navigatePage
                ),
              ),
              customFlatButton(
                context, 
                "Upload", "uploadDocumentScreen", AppColors.blueColor,                  
                FontWeight.normal,
                size18,
                EdgeInsets.only(top: 15.0),
                EdgeInsets.only(top: size15, bottom: size15),
                BoxShadow(
                  color: Color.fromRGBO(0,0,0,0.54),
                  blurRadius: 5.0
                ), 
                null
              )
            ],
          ),
        ),
      )
    ],
  );
}