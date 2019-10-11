/* Flutter Package */
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
/* Directory of file */
import 'package:Wallet_Apps/src/Model/Model_Profile.dart';
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/AddProfile/AddProfileBody.dart';
import 'package:Wallet_Apps/src/Graphql_Service/Mutation_Document.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Drawer.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';

class AddProfileWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddProfileState();
  }
} 

class AddProfileState extends State<AddProfileWidget>{

  Map<String, dynamic> fetchEmail;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ModelProfile model = ModelProfile();

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
    // print('${model.firstName}, ${model.lastName}, ${model.occupation} ${model.gender} ${model.nationality} ${model.country} ${model.city} ${model.countryCode} ${model.phoneNumber} ${model.address} ${model.buildNumber} ${model.postalCode}');
    if ( 
        model.firstName != null && model.firstName != "" &&
        model.lastName != null && model.lastName != "" &&
        model.occupation != null && model.occupation != "" &&
        model.gender != null && model.gender != "" &&
        model.nationality != null && model.nationality != "" &&
        model.country != null && model.country != "" &&
        model.city != null && model.city != "" &&
        model.countryCode != null && model.countryCode != "" &&
        model.phoneNumber != null && model.phoneNumber != "" &&
        model.address != null && model.address != "" &&
        model.buildNumber != null && model.buildNumber != "" &&
        model.postalCode != null && model.postalCode != "" 
      ) { isTrue = true;}
    return isTrue;
  }

  void textChanged(String fieldType, String changed) {
    if (fieldType == "First name") {
      model.firstName = changed;
    } else
    if( fieldType == "Mid name") {
      model.midName = changed;
    } else
    if( fieldType == "Last name") {
      model.lastName = changed;
    } else
    if( fieldType == "Description") {
      model.description = changed;
    } else
    if( fieldType == "Occupation") {
      model.occupation = changed;
    } else
    if( fieldType == "Nationality") {
      model.nationality = changed;
    } else
    if( fieldType == "Country") {
      model.country = changed;
    } else
    if( fieldType == "City") {
      model.city = changed;
    } else 
    if (fieldType == "CountryCode") {
      model.countryCode = changed;
    } else 
    if (fieldType == "PhoneNumber") {
      model.phoneNumber = changed;
    } else 
    if (fieldType == "Address") {
      model.address = changed;
    } else 
    if (fieldType == "Building number") {
      model.buildNumber = changed;
    } else 
    if (fieldType == "Postal code") {
      model.postalCode = changed;
    }
  }

  /* Set gender to setState for display on UI */
  void resetGender(String valueChange){
    setState(() { model.gender = valueChange; });
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
      model.profileImg = imageUrl;
    });
  }

  void clickNext(RunMutation runMutation) async {
    /* Loading */
    dialogLoading(context);
    runMutation({
      'emails': fetchEmail['email'],
      'first_names': model.firstName,
      'mid_names': model.midName != null ? model.midName : "",
      'last_names': model.lastName,
      'descriptions': model.description,
      'genders': model.gender,
      'profile_imgs': model.profileImg != null ? model.profileImg : "",
      'Occupations': model.occupation,
      'Countrys': model.country,
      'Nationalitys': model.nationality,
      'Citys': model.city,
      'CountryCodes': model.countryCode,
      'PhoneNumbers': model.phoneNumber,
      'BuildingNumbers': model.buildNumber,
      'Addresses': model.address,
      'PostalCodes': model.postalCode
    });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  
      drawer: drawerOnly(context, logOut),
      appBar: appbarWidget(openDrawer, titleAppBar('Add User Info'), snackBar),
      body: Mutation(
        options: MutationOptions(document: addUser),
        builder: (RunMutation runMutation, QueryResult result){
          return Stack(
            children: <Widget>[
              /* Body verify user 1 */
              bodyWidget(runMutation, dropDownList, fetchEmail, model, file, triggerImage, isImage, isUploading, resetGender, validatorProfileUser, resetImage, textChanged, clickNext),
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