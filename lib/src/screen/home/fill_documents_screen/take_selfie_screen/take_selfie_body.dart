import 'package:wallet_apps/index.dart';

Widget selfieBodyWidget(
  BuildContext context,
  Bloc bloc,
  ModelDocument _modelDocuments,
  Function popScreen, Function navigatePage
) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        MyAppBar(title: "Upload Document"),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 22.0),
                  child: Text("Take Selfie", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 29.17),
                  child: Text(
                    "Take selfie of you with your ID/Passport included date", 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                // Container( /* Card of sample take photo */
                //   margin: EdgeInsets.only(bottom: 29.17),
                //   width: double.infinity, height: 189.26,
                //   child: ,
                // ),
                Container(
                  margin: EdgeInsets.only(bottom: 29.17),
                  child: Container(
                    width: double.infinity, height: 189.26,
                    child: Image.asset("assets/selfie.png", fit: BoxFit.fill,),
                  ),
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
    ),
  );
}