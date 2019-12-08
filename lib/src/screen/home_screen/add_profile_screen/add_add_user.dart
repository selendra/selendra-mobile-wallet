/* Flutter Package */
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
/* Directory of file */
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import './add_user_info_body.dart';
import 'package:wallet_apps/src/graphql/services/mutation_document.dart';
import 'package:wallet_apps/src/screen/home_screen/drawer_widget.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

class AddProfileWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddProfileState();
  }
} 

class AddProfileState extends State<AddProfileWidget>{

  Map<String, dynamic> fetchEmail;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ModelUserInfo _modelUserInfo = ModelUserInfo();

  /* File image from picker */
  File file; 

  bool isImage = false; bool isValidate = false; bool isProgress = false; bool isUploading = false;

  List<String> dropDownList = ["Male", "Female"];

  @override
  void initState() {
    super.initState();
    getData();
  }

  /* fetch data user login */
  getData() async {
    Map<String, dynamic> data = await fetchData('userDataLogin');
    fetchEmail = data['queryUserById']; 
    setState(() {});
  }
  /* Open Drawer Method */
  void openDrawer() => _scaffoldKey.currentState.openDrawer();

  /* Trigger Snack Bar Function */
  void snackBar() {
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  /* Log Out Method */
  void logOut() {
    /* Loading */
    dialogLoading(context);
    Future.delayed(Duration(seconds: 2), () {
      Timer(Duration(milliseconds: 500), () => Navigator.pushReplacementNamed(context, '/'));
    });
  }

  /* Validate user AddProfileWidget input */
  Future<bool> validatorProfileUser() async { 
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

  /* Set gender to setState for display on UI */
  void resetGender(String valueChange){
    setState(() { _modelUserInfo.gender = valueChange; });
  }

  /* Trigger image from gallery */
  Future<File> triggerImage() async {
    var imageFile = await gallery();
    setState(() {
      isUploading = true;
      isImage = false;
    });
    if ( imageFile != null) {
      /* Set Image for display on screen */
      file = imageFile;
    } 
    /* If User Cancel Image Selection. Set Default Image*/
    else {
      /* If User Have Already Upload At The Last Time. No Need To Set Default Image */
      if (file == null) {
        setState(() {
          isUploading = false;
        });
      } else {
        setState(() {  
          isUploading = true;
          isImage = true;
        });
      }
    }
    return imageFile;
  }

  void resetImage(String imageUrl) {
    setState(() {
      isImage = true;
      _modelUserInfo.profileImg = imageUrl;
    });
  }

  void clickNext(RunMutation runMutation) async {
    /* Loading */
    dialogLoading(context);
    runMutation({
      'emails': fetchEmail['email'],
      'first_names': _modelUserInfo.firstName,
      'mid_names': _modelUserInfo.midName != null ? _modelUserInfo.midName : "",
      'last_names': _modelUserInfo.lastName,
      'descriptions': _modelUserInfo.description,
      'genders': _modelUserInfo.gender,
      'profile_imgs': _modelUserInfo.profileImg != null ? _modelUserInfo.profileImg : "",
      'Occupations': _modelUserInfo.occupation,
      'Countrys': _modelUserInfo.country,
      'Nationalitys': _modelUserInfo.nationality,
      'Citys': _modelUserInfo.city,
      'CountryCodes': _modelUserInfo.countryCode,
      'PhoneNumbers': _modelUserInfo.phoneNumber,
      'BuildingNumbers': _modelUserInfo.buildNumber,
      'Addresses': _modelUserInfo.address,
      'PostalCodes': _modelUserInfo.postalCode
    });
  }

  void popScreen() {
    Navigator.pop(context);
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  
      body: Mutation(
        options: MutationOptions(document: addUser),
        builder: (RunMutation runMutation, QueryResult result){
          return Stack(
            children: <Widget>[
              /* Body verify user 1 */
              userInfobodyWidget(
                context, 
                runMutation, 
                dropDownList, 
                fetchEmail, 
                _modelUserInfo, 
                file, 
                triggerImage, 
                isImage, isUploading, 
                resetGender, 
                validatorProfileUser, 
                resetImage, textChanged, clickNext, popScreen
              ),
            ],
          );
        },
        update: (Cache cache, QueryResult result) async {
          /* Pop Loading */
          await Future.delayed(Duration(milliseconds: 800), () => Navigator.pop(context));
          /* Push Add Document */ 
          Navigator.pushNamed(context, '/addDocument');
        },
        onCompleted: (dynamic resultData){
        },
      )
    );
  }
}