import 'package:wallet_apps/index.dart';

class MyInputField extends StatelessWidget{

  final Key key;
  final BuildContext context;
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
    this.context,
    this.labelText,
    this.prefixText,
    this.obcureText = false,
    this.enableInput = true,
    this.textInputFormatter,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.controller,
    this.focusNode,
    this.icon,
    this.validateField,
    @required this.onChanged,
    @required this.action
  });

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 10),
      child: TextFormField(
        key: key,
        enabled: enableInput,
        focusNode: focusNode,
        keyboardType: inputType,
        obscureText: obcureText,
        controller: controller,
        textInputAction: inputAction,
        style: TextStyle(color: getHexaColor("#ffffff"), fontSize: 18.0),
        validator: validateField,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: focusNode.hasFocus || controller.text != ""
            ? getHexaColor("#FFFFF").withOpacity(0.3)
            : getHexaColor("#ffffff")
          ),
          prefixText: prefixText,
          prefixStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          /* Prefix Text */
          filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
          enabledBorder: outlineInput(controller.text != ""
            ? getHexaColor("#FFFFFF").withOpacity(0.3)
            : Colors.transparent
          ),
          /* Enable Border But Not Show Error */
          border: errorOutline(),
          /* Show Error And Red Border */
          focusedBorder: outlineInput(getHexaColor("#FFFFFF").withOpacity(0.3)),
          /* Default Focuse Border Color*/
          focusColor: getHexaColor("#ffffff"),
          /* Border Color When Focusing */
          contentPadding: EdgeInsets.all(23), // No Content Padding = -10.0 px
          suffixIcon: icon
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