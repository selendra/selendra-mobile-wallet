import 'package:wallet_apps/index.dart';

class UserInfo extends StatefulWidget {

  final Map<String, dynamic> _userData;

  UserInfo(this._userData);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {
  
  ModelUserInfo _modelUserInfo = ModelUserInfo();

  PostRequest _postRequest = PostRequest();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelUserInfo.globalKey);
    if (widget._userData['label'] == 'profile') {
      replaceDataToController();
    } else if (widget._userData['label'] == 'email' ||
        widget._userData['label'] == 'phone') {
      getTokenByLogin();
    }
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void getTokenByLogin() async {
    /* Get Token To Make Authentication With Add User Info */
    Map<String, dynamic> _res = await _postRequest.userLogin(
        widget._userData['email_phone'],
        widget._userData['passwords'],
        widget._userData['label'] == "email"
            ? "/loginbyemail"
            : "/loginbyphone",
        widget._userData['label']);
    if (_res.containsKey('token')) {
      await StorageServices.setData(_res, "user_token");
    }
  }

  void replaceDataToController() {
    /* Replace Data From Profile Screen After Push User Informtaion Screen */
    _modelUserInfo.controlFirstName.text = widget._userData['first_name'];
    _modelUserInfo.controlMidName.text = widget._userData['mid_name'];
    _modelUserInfo.controlLastName.text = widget._userData['last_name'];
    _modelUserInfo.genderLabel = widget._userData['gender'];
    if (_modelUserInfo.genderLabel == "Male")
      _modelUserInfo.gender = "M";
    else
      _modelUserInfo.gender = "F";
    enableButton();
  }

  void changeGender(String gender) async {
    /* Change Select Gender */
    _modelUserInfo.genderLabel = gender;
    if (gender == "Male")
      _modelUserInfo.gender = "M";
    else
      _modelUserInfo.gender = "F";
    await Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        /* Unfocus All Field */
        if (_modelUserInfo.gender != null)
          enableButton(); /* Enable Button If User Set Gender */
        _modelUserInfo.nodeFirstName.unfocus();
        _modelUserInfo.nodeMidName.unfocus();
        _modelUserInfo.nodeLastName.unfocus();
      });
    });
  }

  void onSubmit(BuildContext context) {
    if (_modelUserInfo.nodeFirstName.hasFocus) {
      FocusScope.of(context).requestFocus(_modelUserInfo.nodeMidName);
    } else if (_modelUserInfo.nodeMidName.hasFocus) {
      FocusScope.of(context).requestFocus(_modelUserInfo.nodeLastName);
    } else {
      _modelUserInfo.nodeFirstName.unfocus();
      _modelUserInfo.nodeMidName.unfocus();
      _modelUserInfo.nodeLastName.unfocus();
    }
  }

  void onChanged(String value) {
    _modelUserInfo.formStateAddUserInfo.currentState.validate();
  }

  String validateFirstName(String value) {
    if (_modelUserInfo.nodeFirstName.hasFocus) {
      _modelUserInfo.responseFirstname =
          instanceValidate.validateUserInfo(value);
      if (_modelUserInfo.responseFirstname == null)
        return null;
      else
        _modelUserInfo.responseFirstname += "first name";
    }
    return _modelUserInfo.responseFirstname;
  }

  String validateMidName(String value) {
    if (_modelUserInfo.nodeMidName.hasFocus) {
      _modelUserInfo.responseMidname = instanceValidate.validateUserInfo(value);
      if (_modelUserInfo.responseMidname == null)
        return null;
      else
        _modelUserInfo.responseMidname += "mid name";
    }
    return _modelUserInfo.responseMidname;
  }

  String validateLastName(String value) {
    if (_modelUserInfo.nodeLastName.hasFocus) {
      _modelUserInfo.responseLastname =
          instanceValidate.validateUserInfo(value);
      if (_modelUserInfo.responseLastname == null)
        return null;
      else
        _modelUserInfo.responseLastname += "last name";
    }
    return _modelUserInfo.responseLastname;
  }

  void submitProfile(BuildContext context) async {
    /* Submit Profile User */
    dialogLoading(context); /* Show Loading Process */
    _modelUserInfo.submitResponse = await _postRequest.uploadUserProfile(_modelUserInfo, '/userprofile'); /* Post Request Submit Profile */
    Navigator.pop(context); /* Close Loading Process */
    if (_modelUserInfo.submitResponse != null && _modelUserInfo.token == null) {
      /* Set Profile Success */
      await dialog(context, Text("${_modelUserInfo.submitResponse['message']}", textAlign: TextAlign.center,), Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor)));
      if (widget._userData['label'] == 'profile') {
        Navigator.pop(context);
      } else {
        AppServices.clearStorage();
        Future.delayed(Duration(microseconds: 500), () { // Remove All Screen And Push Login Screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            ModalRoute.withName('/')
          );
        });
      }
    } else {
      /* Edit Profile Success */
      await dialog(context, Text("${_modelUserInfo.submitResponse['message']}"), Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor)));
      Navigator.pop(context);
    }
  }

  PopupMenuItem item(Map<String, dynamic> list) {
    return PopupMenuItem(
      value: list['gender'],
      child: Text("${list['gender']}"),
    );
  }

  void enableButton() => _modelUserInfo.enable = true;

  @override
  void dispose() {
    /* Clear Everything When Pop Screen */
    _modelUserInfo.controlFirstName.clear();
    _modelUserInfo.controlMidName.clear();
    _modelUserInfo.controlLastName.clear();
    _modelUserInfo.enable = false;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _modelUserInfo.globalKey,
      body: scaffoldBGDecoration(
        child: userInfoBody(
          context,
          _modelUserInfo,
          onSubmit,
          onChanged,
          changeGender,
          validateFirstName,
          validateMidName,
          validateLastName,
          submitProfile,
          popScreen,
          item
        )
      ),
    );
  }
}