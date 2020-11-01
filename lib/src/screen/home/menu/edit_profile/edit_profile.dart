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

  ModelUserInfo _editInfoM = ModelUserInfo();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_editInfoM.globalKey);
    replaceDataToController();
    super.initState();
  }
  
  @override
  void dispose() { /* Clear Everything When Pop Screen */
    _editInfoM.controlFirstName.clear();
    _editInfoM.controlMidName.clear();
    _editInfoM.controlLastName.clear();
    _editInfoM.enable = false;
    super.dispose();
  }

  void replaceDataToController() {/* Replace Data From Profile Screen After Push User Informtaion Screen */
    _editInfoM.controlFirstName.text = widget._userData['first_name'];
    _editInfoM.controlMidName.text = widget._userData['mid_name'];
    _editInfoM.controlLastName.text = widget._userData['last_name'];
    _editInfoM.genderLabel = widget._userData['gender'];
    if (_editInfoM.genderLabel == "Male")
      _editInfoM.gender = "M";
    else
      _editInfoM.gender = "F";
    enableButton();
  }

  void changeGender(String gender) async {/* Change Select Gender */
    _editInfoM.genderLabel = gender;
    if (gender == "Male")
      _editInfoM.gender = "M";
    else
      _editInfoM.gender = "F";
    await Future.delayed(Duration(milliseconds: 100), () {
      setState(() { /* Unfocus All Field */
        if (_editInfoM.gender != null) enableButton(); /* Enable Button If User Set Gender */
        _editInfoM.nodeFirstName.unfocus();
        _editInfoM.nodeMidName.unfocus();
        _editInfoM.nodeLastName.unfocus();
      });
    });
  }

  void onSubmit(BuildContext context) {
    if (_editInfoM.nodeFirstName.hasFocus) {
      FocusScope.of(context).requestFocus(_editInfoM.nodeMidName);
    } else if (_editInfoM.nodeMidName.hasFocus) {
      FocusScope.of(context).requestFocus(_editInfoM.nodeLastName);
    } else {
      _editInfoM.nodeFirstName.unfocus();
      _editInfoM.nodeMidName.unfocus();
      _editInfoM.nodeLastName.unfocus();
    }
  }

  void onChanged(String value) {
    _editInfoM.formStateAddUserInfo.currentState.validate();
  }

  String validateFirstName(String value) {
    if (_editInfoM.nodeFirstName.hasFocus) {
      _editInfoM.responseFirstname =
          instanceValidate.validateUserInfo(value);
      if (_editInfoM.responseFirstname == null)
        return null;
      else
        _editInfoM.responseFirstname += "first name";
    }
    return _editInfoM.responseFirstname;
  }

  String validateMidName(String value) {
    if (_editInfoM.nodeMidName.hasFocus) {
      _editInfoM.responseMidname = instanceValidate.validateUserInfo(value);
      if (_editInfoM.responseMidname == null)
        return null;
      else
        _editInfoM.responseMidname += "mid name";
    }
    return _editInfoM.responseMidname;
  }

  String validateLastName(String value) {
    if (_editInfoM.nodeLastName.hasFocus) {
      _editInfoM.responseLastname =
          instanceValidate.validateUserInfo(value);
      if (_editInfoM.responseLastname == null)
        return null;
      else
        _editInfoM.responseLastname += "last name";
    }
    return _editInfoM.responseLastname;
  }

  /* Submit Profile User */
  void submitProfile() async {
    /* Show Loading Process */
    dialogLoading(context);
    /* Post Request Submit Profile */
    try {
      _backend.response = await _postRequest.uploadProfile(_editInfoM); 
      /* Close Loading Procxess */
      Navigator.pop(context);
      _backend.mapData = json.decode(_backend.response.body);
      /* Set Profile Success */
      if (_backend.mapData != null) { 
        await dialog(context, Text("${_backend.mapData['message']}", textAlign: TextAlign.center), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor)));
        Navigator.pop(context, {'dialog_name': 'edit_profile'});
      }
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message")); 
      snackBar(_editInfoM.globalKey, e.message.toString());
    } catch (e) {
      await dialog(context, Text(e.message.toString()), Text("Message")); 
    }
  }

  PopupMenuItem item(Map<String, dynamic> list) {
    return PopupMenuItem(
      value: list['gender'],
      child: Text("${list['gender']}"),
    );
  }

  void enableButton() => _editInfoM.enable = true;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _editInfoM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        bottom: 16,
        child: EditProfileBody(
          modelUserInfo: _editInfoM,
          onSubmit: onSubmit,
          onChanged: onChanged,
          changeGender: changeGender,
          validateFirstName: validateFirstName,
          validateMidName: validateMidName,
          validateLastName: validateLastName,
          submitProfile: submitProfile,
          item: item
        )
      ),
    );
  }
}
