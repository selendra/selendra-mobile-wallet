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
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        SvgPicture.asset('assets/user_info.svg', width: 300, height: 300),

        Form(
          key: modelUserInfo.formStateAddUserInfo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              MyInputField(
                pBottom: 16.0,
                labelText: "First name",
                textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                controller: modelUserInfo.controlFirstName, 
                focusNode: modelUserInfo.nodeFirstName, 
                validateField: validateFirstName, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              
              MyInputField(
                pBottom: 16.0,
                labelText: "Mid name",
                textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                controller: modelUserInfo.controlMidName, 
                focusNode: modelUserInfo.nodeMidName, 
                validateField: validateMidName, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              
              MyInputField(
                pBottom: 16.0,
                labelText: "Last name",
                textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                controller: modelUserInfo.controlLastName ,
                focusNode: modelUserInfo.nodeLastName, 
                validateField: validateLastName, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                changeGender("Male");
              },
              child: MyCircularImage(
                width: 70, height: 70,
                padding: const EdgeInsets.all(10),  
                decoration: BoxDecoration(
                  color: hexaCodeToColor(
                    modelUserInfo.gender == 'M' ? AppColors.selected : AppColors.cardColor 
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.3), 
                      blurRadius: 40.0, 
                      spreadRadius: 2.0, 
                      offset: Offset(2.0, 5.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(40)
                ),
                imagePath: "assets/male_avatar.svg"
              )
            ),
            MyText(
              left: 30, right: 30,
              width: 100,
              height: 21,
              text: modelUserInfo.genderLabel
            ), 

            GestureDetector(
              onTap: (){
                changeGender("Female");
              },
              child: MyCircularImage(
                width: 70, height: 70,
                padding: const EdgeInsets.all(10),  
                decoration: BoxDecoration(
                  color: hexaCodeToColor(
                    modelUserInfo.gender == 'F' ? AppColors.selected : AppColors.cardColor 
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(modelUserInfo.enable == false ? 0 : 0.3), 
                      blurRadius: 40.0, 
                      spreadRadius: 2.0, 
                      offset: Offset(2.0, 5.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(40)
                ),
                imagePath: "assets/female_avatar.svg"
              )
            )
          ],
        ),

        MyFlatButton(
          textButton: "Submit",
          edgeMargin: EdgeInsets.only(top: 29, left: 66, right: 66),
          hasShadow: modelUserInfo.enable,
          action: modelUserInfo.enable == false ? null : submitProfile
        )
      ],
    );
  }
}


