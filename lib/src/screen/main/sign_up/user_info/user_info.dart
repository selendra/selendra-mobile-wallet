import 'package:wallet_apps/index.dart';

class UserInfo extends StatefulWidget {

  final String registerBy; final String userAccount; final String passwords;

  UserInfo(this.registerBy, this.userAccount, this.passwords);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {
  
  ModelUserInfo _userInfoM = ModelUserInfo();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_userInfoM.globalKey);
    /* If Registering Account */
    // if (widget.passwords != null) getToken();
    super.initState();
  }
  
  @override
  void dispose() {
    /* Clear Everything When Pop Screen */
    _userInfoM.controlFirstName.clear();
    _userInfoM.controlMidName.clear();
    _userInfoM.controlLastName.clear();
    _userInfoM.enable = false;
    super.dispose();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  /* Get Token To Make Authentication With Add User Info */
  void getToken() async {
    if(widget.registerBy == "email"){
      _backend.response = await _postRequest.loginByEmail(widget.userAccount, widget.passwords);
    } else {
      _backend.response = await _postRequest.loginByPhone(widget.userAccount, widget.passwords);
    }
    _backend.mapData = json.decode(_backend.response.body);
    if (_backend.mapData.containsKey('token')) {
      await StorageServices.setData(_backend.mapData, "user_token");
    }
  }

  /* Change Select Gender */
  void changeGender(String gender) async {
    _userInfoM.genderLabel = gender;
    setState((){
      if (gender == "Male")
        _userInfoM.gender = "M";
      else
        _userInfoM.gender = "F";
    });
    await Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        /* Unfocus All Field */
        if (_userInfoM.gender != null)
          enableButton(); /* Enable Button If User Set Gender */
        _userInfoM.nodeFirstName.unfocus();
        _userInfoM.nodeMidName.unfocus();
        _userInfoM.nodeLastName.unfocus();
      });
    });
  }

  void onSubmit() {
    if (_userInfoM.nodeFirstName.hasFocus) {
      FocusScope.of(context).requestFocus(_userInfoM.nodeMidName);
    } else if (_userInfoM.nodeMidName.hasFocus) {
      FocusScope.of(context).requestFocus(_userInfoM.nodeLastName);
    } else {
      _userInfoM.nodeFirstName.unfocus();
      _userInfoM.nodeMidName.unfocus();
      _userInfoM.nodeLastName.unfocus();
    }
  }

  void onChanged(String value) {
    _userInfoM.formStateAddUserInfo.currentState.validate();
  }

  String validateFirstName(String value) {
    if (_userInfoM.nodeFirstName.hasFocus) {
      _userInfoM.responseFirstname =
          instanceValidate.validateUserInfo(value);
      if (_userInfoM.responseFirstname == null)
        return null;
      else
        _userInfoM.responseFirstname += "first name";
    }
    return _userInfoM.responseFirstname;
  }

  String validateMidName(String value) {
    if (_userInfoM.nodeMidName.hasFocus) {
      _userInfoM.responseMidname = instanceValidate.validateUserInfo(value);
      if (_userInfoM.responseMidname == null)
        return null;
      else
        _userInfoM.responseMidname += "mid name";
    }
    return _userInfoM.responseMidname;
  }

  String validateLastName(String value) {
    if (_userInfoM.nodeLastName.hasFocus) {
      _userInfoM.responseLastname =
          instanceValidate.validateUserInfo(value);
      if (_userInfoM.responseLastname == null)
        return null;
      else
        _userInfoM.responseLastname += "last name";
    }
    return _userInfoM.responseLastname;
  }

  // Submit Profile User
  void submitProfile() async {

    // Show Loading Process
    dialogLoading(context); 

    try{
      // Post Request Submit Profile
      await _postRequest.uploadProfile(_userInfoM).then((value) async {

        _backend.response = value;

        if (_backend.response != null){

          // Convert String To Object
          _backend.mapData = json.decode(_backend.response.body);

          // Close Loading Process
          Navigator.pop(context);
          if (_backend.response != null && _backend.mapData['token'] == null) {
            // Set Profile Success
            await dialog(context, Text("${_backend.mapData['message']}", textAlign: TextAlign.center,), Icon(Icons.done_all, color: hexaCodeToColor(AppColors.greenColor)));        
            if (widget.passwords != null) {
              // Clear Storage
              AppServices.clearStorage();
              // Remove All Screen And Push Login Screen
              await Future.delayed(Duration(microseconds: 500), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  ModalRoute.withName('/')
                );
              });
            } else {
              await Future.delayed(Duration(microseconds: 500), () {
                Navigator.pop(context);
              });
            }
          } else {
            await dialog(context, Text("${_backend.mapData}"), Text("Message"));
            Navigator.pop(context);
          }

        }
      });
    }  on SocketException catch (e){
      await Future.delayed(Duration(milliseconds: 300), () { });
      AppServices.openSnackBar(_userInfoM.globalKey, e.message);
    } catch (e){
      await dialog(context, Text("${e.message}"), Text("Message"));
    } 
  }

  PopupMenuItem item(Map<String, dynamic> list) {
    return PopupMenuItem(
      value: list['gender'],
      child: Text("${list['gender']}"),
    );
  }

  void enableButton() => _userInfoM.enable = true;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _userInfoM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: UserInfoBody(
          modelUserInfo: _userInfoM,
          onSubmit: onSubmit,
          onChanged: onChanged,
          changeGender: changeGender,
          validateFirstName: validateFirstName,
          validateMidName: validateMidName,
          validateLastName: validateLastName,
          submitProfile: submitProfile,
          popScreen: popScreen,
          item: item
        )
      ),
    );
  }
}
