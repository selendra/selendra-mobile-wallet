import 'package:wallet_apps/index.dart';

class UserInfoBody extends StatelessWidget{
  
  final ModelUserInfo modelUserInfo;
  final Function onSubmit;
  final Function onChanged;
  final Function changeGender;
  final Function validateFirstName;
  final Function validateMidName;
  final Function validateLastName;
  final Function submitProfile;
  final Function popScreen;
  final PopupMenuItem Function(Map<String, dynamic>) item;

  UserInfoBody({
    this.modelUserInfo,
    this.onSubmit,
    this.onChanged,
    this.changeGender,
    this.validateFirstName,
    this.validateMidName,
    this.validateLastName,
    this.submitProfile,
    this.popScreen,
    this.item
  });

  Widget build(BuildContext context){
    return Column(
      children: <Widget>[

        MyAppBar(
          title: "User Information",
          action: (){
            Navigator.pop(context);
          },
        ),

        MyIllustrate(
          imagePath: 'assets/user_info.svg',
        ),

        Form(
          key: modelUserInfo.formStateAddUserInfo,
          child: Column(
            children: <Widget>[
              MyInputField(
                labelText: "First name",
                textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                controller: modelUserInfo.controlFirstName, 
                focusNode: modelUserInfo.nodeFirstName, 
                validateField: validateFirstName, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              MyInputField(
                labelText: "Mid name",
                textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                controller: modelUserInfo.controlMidName, 
                focusNode: modelUserInfo.nodeMidName, 
                validateField: validateMidName, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              MyInputField(
                labelText: "Last name",
                textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                controller: modelUserInfo.controlLastName ,
                focusNode: modelUserInfo.nodeLastName, 
                validateField: validateLastName, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              // Container( /* First Name Field */
              //   margin: EdgeInsets.only(bottom: 12.0),
              //   child: inputField(
              //     context: context,
              //     labelText: "First Name",
              //     widgetName: "userInfoScreen",
              //     textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
              //     controller: modelUserInfo.controlFirstName,
              //     focusNode: modelUserInfo.nodeFirstName,
              //     validateField: validateFirstName,
              //     onChanged: onChanged,
              //     action: onSubmit
              //   ),
              // ),
              // Container( /* Mid Name Field */
              //   margin: EdgeInsets.only(bottom: 12.0),
              //   child: inputField(
              //     context: context,
              //     labelText: "Mid Name", 
              //     widgetName: "userInfoScreen",
              //     textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
              //     controller: modelUserInfo.controlMidName,
              //     focusNode: modelUserInfo.nodeMidName,
              //     validateField: validateMidName,
              //     onChanged: onChanged,
              //     action: onSubmit
              //   ),
              // ),
              // Container( /* Last Name Field */
              //   margin: EdgeInsets.only(bottom: 12.0),
              //   child: inputField(
              //     context: context,
              //     labelText: "Last Name", 
              //     widgetName: "userInfoScreen",
              //     textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
              //     controller: modelUserInfo.controlLastName,
              //     focusNode: modelUserInfo.nodeLastName,
              //     validateField: validateLastName,
              //     onChanged: onChanged,
              //     action: onSubmit,
              //     inputAction: TextInputAction.done,
              //   ),
              // ),
              // Container( /* Gender Picker */
              //   margin: EdgeInsets.only(bottom: 12.0),
              //   child: customDropDown(
              //     modelUserInfo.genderLabel,
              //     [
              //       {"gender": "Male"},
              //       {"gender": "Female"}
              //     ],
              //     modelUserInfo,
              //     changeGender,
              //     item
              //   ),
              // ),
              MyFlatButton(
                textButton: "Submit",
                action: (){
                  submitProfile();
                }
              )
              // customFlatButton(/* Submit Button */
              //   context,
              //   "Submit",
              //   "userInfoScreen",
              //   AppColors.greenColor,
              //   FontWeight.normal,
              //   size18,
              //   EdgeInsets.only(top: 15.0, bottom: size10),
              //   EdgeInsets.only(top: size15, bottom: size15),
              //   BoxShadow(
              //     color: Colors.black54.withOpacity(modelUserInfo.enable == false ? 0 : 0.3), 
              //     blurRadius: 10.0, 
              //     spreadRadius: 2.0, 
              //     offset: Offset(2.0, 5.0),
              //   ),
              //   modelUserInfo.enable == false ? null : submitProfile
              // )
            ],
          ),
        )
      ],
    );
  }
}


