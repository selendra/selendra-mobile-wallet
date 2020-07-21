import 'package:wallet_apps/index.dart';

class SmsComponent {
  static Widget boxCode({
    double left: 0.0, double right: 0.0,
    FocusNode focusNode,
    TextEditingController controller,
    Function onChanged,
  }){
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        margin: EdgeInsets.only(left: left, right: right),
        child: SizedBox(
          width: 50.0,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(1), WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              ),
              /* Prefix Text */
              filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
              enabledBorder: outlineInput(getHexaColor("#FFFFFF").withOpacity(0.3)),
              /* Enable Border But Not Show Error */
              border: errorOutline(),
              /* Show Error And Red Border */
              focusedBorder: outlineInput(getHexaColor("#FFFFFF").withOpacity(0.3)),
              /* Default Focuse Border Color*/
              focusColor: getHexaColor("#ffffff"),
              /* Border Color When Focusing */
              contentPadding: EdgeInsets.only(top: 23,right: 5.0, bottom: 23, left: 5), // No Content Padding = -10.0 px
            ),
            onChanged: (String value){
              print("my value");
              onChanged(value);
            },
          )
        ),
      ),
    );
  }
}