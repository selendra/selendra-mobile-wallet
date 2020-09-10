import 'package:wallet_apps/index.dart';

class MyInputField extends StatelessWidget{

  final Key key;
  final String labelText;
  final String prefixText;
  final bool obcureText;
  final bool enableInput;
  final List<TextInputFormatter> textInputFormatter;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconButton icon;
  final Function validateField;
  final Function onChanged;
  final Function action;  

  MyInputField({/* User Input Field */
    this.key,
    this.labelText,
    this.prefixText,
    this.obcureText = false,
    this.enableInput = true,
    this.textInputFormatter,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    @required this.controller,
    @required this.focusNode,
    this.icon,
    @required this.validateField,
    @required this.onChanged,
    @required this.action
  });

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0, top: 2.0),
      child: TextFormField(
        key: key,
        enabled: enableInput,
        focusNode: focusNode,
        keyboardType: inputType,
        obscureText: obcureText,
        controller: controller,
        textInputAction: inputAction,
        style: TextStyle(color: hexaCodeToColor(AppColors.textColor), fontSize: 18.0),
        validator: validateField,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: focusNode.hasFocus || controller.text != ""
            ? hexaCodeToColor("#FFFFF").withOpacity(0.3)
            : hexaCodeToColor(AppColors.textColor)
          ),
          prefixText: prefixText,
          prefixStyle: TextStyle(color: hexaCodeToColor(AppColors.textColor), fontSize: 18.0),
          /* Prefix Text */
          filled: true, 
          fillColor: hexaCodeToColor(AppColors.cardColor),
          enabledBorder: myOutlineInput(controller.text != ""
            ? hexaCodeToColor("#FFFFFF").withOpacity(0.3)
            : Colors.transparent
          ),
          /* Enable Border But Not Show Error */
          border: errorOutline(),
          /* Show Error And Red Border */
          focusedBorder: myOutlineInput(hexaCodeToColor("#FFFFFF").withOpacity(0.3)),
          /* Default Focuse Border Color*/
          focusColor: hexaCodeToColor("#ffffff"),
          /* Border Color When Focusing */
          contentPadding: EdgeInsets.fromLTRB(21, 20, 21, 20), // No Content Padding = -10.0 px
          suffixIcon: icon,
        ),
        inputFormatters: textInputFormatter,
        /* Limit Length Of Text Input */
        onChanged: onChanged,
        onFieldSubmitted: (value) {
          action(context);
        },
      )
    );
  }
}

/* User input Outline Border */
OutlineInputBorder myOutlineInput(Color borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: size1),
    borderRadius: BorderRadius.circular(8)
  );
}