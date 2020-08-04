import 'package:wallet_apps/index.dart';

class EditProfile extends StatefulWidget {

  final Map<String, dynamic> _userData;

  EditProfile(this._userData);

  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {

  ModelUserInfo _modelUserInfo = ModelUserInfo();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelUserInfo.globalKey);
    replaceDataToController();
    super.initState();
  }
  
  @override
  void dispose() { /* Clear Everything When Pop Screen */
    _modelUserInfo.controlFirstName.clear();
    _modelUserInfo.controlMidName.clear();
    _modelUserInfo.controlLastName.clear();
    _modelUserInfo.enable = false;
    super.dispose();
  }

  void popScreen() {
    Navigator.pop(context, '');
  }

  void replaceDataToController() {/* Replace Data From Profile Screen After Push User Informtaion Screen */
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

  void changeGender(String gender) async {/* Change Select Gender */
    _modelUserInfo.genderLabel = gender;
    if (gender == "Male")
      _modelUserInfo.gender = "M";
    else
      _modelUserInfo.gender = "F";
    await Future.delayed(Duration(milliseconds: 100), () {
      setState(() { /* Unfocus All Field */
        if (_modelUserInfo.gender != null) enableButton(); /* Enable Button If User Set Gender */
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
    /* Post Request Submit Profile */
    _backend.response = await _postRequest.uploadProfile(_modelUserInfo); 
    /* Close Loading Procxess */
    Navigator.pop(context);
    _backend.mapData = json.decode(_backend.response.body);
    /* Set Profile Success */
    if (_backend.mapData != null) { 
      await dialog(context, Text("${_backend.mapData['message']}"), Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor)));
      Navigator.pop(context, 'edit_profile');
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
        child: editProfileBody(
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
