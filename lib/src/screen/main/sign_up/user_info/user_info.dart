import 'package:wallet_apps/index.dart';

class UserInfo extends StatefulWidget {

  final ModelSignUp _modelSignUp;

  UserInfo(this._modelSignUp);

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo> {
  
  ModelUserInfo _modelUserInfo = ModelUserInfo();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelUserInfo.globalKey);
    getToken();
    super.initState();
  }
  
  @override
  void dispose() {
    /* Clear Everything When Pop Screen */
    _modelUserInfo.controlFirstName.clear();
    _modelUserInfo.controlMidName.clear();
    _modelUserInfo.controlLastName.clear();
    _modelUserInfo.enable = false;
    super.dispose();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  /* Get Token To Make Authentication With Add User Info */
  void getToken() async {
    if(widget._modelSignUp.label == "email"){
      _backend.response = await _postRequest.loginByEmail(widget._modelSignUp.controlEmails.text, widget._modelSignUp.controlPassword.text);
    } else {
      _backend.response = await _postRequest.loginByPhone(widget._modelSignUp.controlPhoneNums.text, widget._modelSignUp.controlPassword.text);
    }
    print(_backend.response.body);
    _backend.decode = json.decode(_backend.response.body);
    if (_backend.decode.containsKey('token')) {
      await StorageServices.setData(_backend.decode, "user_token");
    }
  }

  /* Change Select Gender */
  void changeGender(String gender) async {
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

  /* Submit Profile User */
  void submitProfile(BuildContext context) async {
    /* Show Loading Process */
    dialogLoading(context); 
    _backend.response = await _postRequest.uploadProfile(_modelUserInfo, '/userprofile'); /* Post Request Submit Profile */
    /* Convert String To Object */
    _backend.decode = json.decode(_backend.response.body);
    /* Close Loading Process */
    Navigator.pop(context);
    if (_backend.response != null && _backend.decode['token'] == null) {
      /* Set Profile Success */
      await dialog(context, Text("${_backend.decode['message']}", textAlign: TextAlign.center,), Icon(Icons.done_all, color: getHexaColor(AppColors.greenColor)));
      /* Clear Storage */
      AppServices.clearStorage();
      /* Remove All Screen And Push Login Screen */
      await Future.delayed(Duration(microseconds: 500), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          ModalRoute.withName('/')
        );
      });
    } else {
      await dialog(context, Text("${_backend.decode}"), Text("Message"));
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
