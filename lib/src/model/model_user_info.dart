import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class ModelUserInfo {
  
  final formStateAddUserInfo = GlobalKey<FormState>();

  Map<String, dynamic> userData;

  String token, genderLabel = "Gender", gender;
  String responseFirstname, responseMidname, responseLastname;

  var submitResponse;

  bool enable = false;

  FocusNode nodeFirstName = FocusNode();
  FocusNode nodeMidName = FocusNode();
  FocusNode nodeLastName = FocusNode();

  TextEditingController controlFirstName = TextEditingController();
  TextEditingController controlMidName = TextEditingController();
  TextEditingController controlLastName = TextEditingController();
  
  TextEditingController controlOccupation = TextEditingController(text: '');
  TextEditingController controlNationality = TextEditingController(text: '');
  TextEditingController controlCountry = TextEditingController(text: '');

  FocusNode nodeOccupatioin = FocusNode();
  FocusNode nodeNationality = FocusNode();
  FocusNode nodeCountry = FocusNode();
  
  String firstName;
  String midName;
  String lastName;
  String description;
  String profileImg;
  String occupation;
  String nationality, country;
  String city;
  String countryCode, phoneNumber; 
  String address;
  String buildNumber, postalCode;
  /* File image from picker */
  File file; 

  bool isImage = false; bool isValidate = false; bool isProgress = false; bool isUploading = false;

  Map<String, dynamic> fetchEmail = {};
}