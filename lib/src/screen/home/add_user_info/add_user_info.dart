/* Flutter Package */
import 'dart:io';
import 'package:flutter/cupertino.dart';
/* Directory of file */
import 'package:wallet_apps/index.dart';

class AddUserInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddUserInfoState();
  }
} 

class AddUserInfoState extends State<AddUserInfo>{

  final _globalKey = GlobalKey<ScaffoldState>();

  ModelUserInfo _modelUserInfo = ModelUserInfo();

  List<String> dropDownList = ["Male", "Female"];

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    getData();
    super.initState();
  }
  
  getData() async { /* fetch data user login */
    Map<String, dynamic> data = await StorageServices.fetchData('userDataLogin');
    _modelUserInfo.fetchEmail = data['queryUserById']; 
    setState(() {});
  }
  
  void snackBar() { /* Trigger Snack Bar Function */
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _globalKey.currentState.showSnackBar(snackbar);
  }
  
  void logOut() { /* Log Out Method */
    dialogLoading(context); /* Loading */
    Future.delayed(Duration(seconds: 2), () {
      Timer(Duration(milliseconds: 500), () => Navigator.pushReplacementNamed(context, '/'));
    });
  }

  Future<bool> validatorProfileUser() async { /* Validate user AddProfileWidget input */
    bool isTrue;
    // print(fetchEmail['email']);
    // print('${_modelUserInfo.firstName}, ${_modelUserInfo.lastName}, ${_modelUserInfo.occupation} ${_modelUserInfo.gender} ${_modelUserInfo.nationality} ${_modelUserInfo.country} ${_modelUserInfo.city} ${_modelUserInfo.countryCode} ${_modelUserInfo.phoneNumber} ${_modelUserInfo.address} ${_modelUserInfo.buildNumber} ${_modelUserInfo.postalCode}');
    if ( 
        _modelUserInfo.firstName != null && _modelUserInfo.firstName != "" &&
        _modelUserInfo.lastName != null && _modelUserInfo.lastName != "" &&
        _modelUserInfo.occupation != null && _modelUserInfo.occupation != "" &&
        _modelUserInfo.gender != null && _modelUserInfo.gender != "" &&
        _modelUserInfo.nationality != null && _modelUserInfo.nationality != "" &&
        _modelUserInfo.country != null && _modelUserInfo.country != "" &&
        _modelUserInfo.city != null && _modelUserInfo.city != "" &&
        _modelUserInfo.countryCode != null && _modelUserInfo.countryCode != "" &&
        _modelUserInfo.phoneNumber != null && _modelUserInfo.phoneNumber != "" &&
        _modelUserInfo.address != null && _modelUserInfo.address != "" &&
        _modelUserInfo.buildNumber != null && _modelUserInfo.buildNumber != "" &&
        _modelUserInfo.postalCode != null && _modelUserInfo.postalCode != "" 
      ) { isTrue = true;}
    return isTrue;
  }

  void textChanged(String fieldType, String changed) {
    if (fieldType == "First name") {
      _modelUserInfo.firstName = changed;
    } else
    if( fieldType == "Mid name") {
      _modelUserInfo.midName = changed;
    } else
    if( fieldType == "Last name") {
      _modelUserInfo.lastName = changed;
    } else
    if( fieldType == "Description") {
      _modelUserInfo.description = changed;
    } else
    if( fieldType == "Occupation") {
      _modelUserInfo.occupation = changed;
    } else
    if( fieldType == "Nationality") {
      _modelUserInfo.nationality = changed;
    } else
    if( fieldType == "Country") {
      _modelUserInfo.country = changed;
    } else
    if( fieldType == "City") {
      _modelUserInfo.city = changed;
    } else 
    if (fieldType == "CountryCode") {
      _modelUserInfo.countryCode = changed;
    } else 
    if (fieldType == "PhoneNumber") {
      _modelUserInfo.phoneNumber = changed;
    } else 
    if (fieldType == "Address") {
      _modelUserInfo.address = changed;
    } else 
    if (fieldType == "Building number") {
      _modelUserInfo.buildNumber = changed;
    } else 
    if (fieldType == "Postal code") {
      _modelUserInfo.postalCode = changed;
    }
  }

  void resetGender(String valueChange){ /* Set gender to setState for display on UI */
    setState(() { _modelUserInfo.gender = valueChange; });
  }

  Future<File> triggerImage() async { /* Trigger image from gallery */
    var imageFile = await gallery();
    setState(() {
      _modelUserInfo.isUploading = true;
      _modelUserInfo.isImage = false;
    });
    if ( imageFile != null) { 
      _modelUserInfo.file = imageFile; /* Set Image for display on screen */
    } 
    else { /* Image canceled. Set Default Image*/
      if (_modelUserInfo.file == null) { /* If User Have Already Upload At The Last Time. No Need To Set Default Image */
        setState(() {
          _modelUserInfo.isUploading = false;
        });
      } else {
        setState(() {  
          _modelUserInfo.isUploading = true;
          _modelUserInfo.isImage = true;
        });
      }
    }
    return imageFile;
  }

  void resetImage(String imageUrl) {
    setState(() {
      _modelUserInfo.isImage = true;
      _modelUserInfo.profileImg = imageUrl;
    });
  }

  void clickNext() async {
    /* Loading */
    // dialogLoading(context);
    // runMutation({
    //   'emails': _modelUserInfo.fetchEmail['email'],
    //   'first_names': _modelUserInfo.firstName,
    //   'mid_names': _modelUserInfo.midName != null ? _modelUserInfo.midName : "",
    //   'last_names': _modelUserInfo.lastName,
    //   'descriptions': _modelUserInfo.description,
    //   'genders': _modelUserInfo.gender,
    //   'profile_imgs': _modelUserInfo.profileImg != null ? _modelUserInfo.profileImg : "",
    //   'Occupations': _modelUserInfo.occupation,
    //   'Countrys': _modelUserInfo.country,
    //   'Nationalitys': _modelUserInfo.nationality,
    //   'Citys': _modelUserInfo.city,
    //   'CountryCodes': _modelUserInfo.countryCode,
    //   'PhoneNumbers': _modelUserInfo.phoneNumber,
    //   'BuildingNumbers': _modelUserInfo.buildNumber,
    //   'Addresses': _modelUserInfo.address,
    //   'PostalCodes': _modelUserInfo.postalCode
    // });
  }

  void popScreen() {
    Navigator.pop(context);
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,  
      body: scaffoldBGDecoration(
        child: addUserInfobody(
          instanceValidate,
          context, 
          dropDownList, 
          _modelUserInfo, 
          triggerImage, 
          resetGender, 
          validatorProfileUser, resetImage, 
          textChanged, clickNext, popScreen
        )
      )
    );
  }
}