import 'package:wallet_apps/index.dart';

class AddSuccess extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      body: addSuccessBodyWidget(context),
    );
  } 
}

Widget addSuccessBodyWidget(BuildContext context) {

  return Container(
    padding: EdgeInsets.only(left: 43.0, right: 43.0, top: 16.0),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container( /* Icon Round Button */
          height: 122, width: 122,
          margin: EdgeInsets.only(bottom: 33.0),
          decoration: BoxDecoration(
            color: hexaCodeToColor(AppColors.greenColor),
            borderRadius: BorderRadius.circular(60.0)
          ),
          child: Icon(Icons.done, size: 90.0, color: hexaCodeToColor(AppColors.greenColor),),
        ),
        Container( /* Congratulation Text */
          margin: EdgeInsets.only(bottom: 17.0),
          child: Text('Congratulation', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24.0),),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 17.0, left: 6.0, right: 6.0),
          child: Text(
            "We will received your information with in 24 hours", 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        customFlatButton( /* Done Button */
          context, 
          "Done", "addSuccessScreen", AppColors.blueColor,
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
  );
}