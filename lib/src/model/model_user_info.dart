import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class ModelUserInfo {

  Bloc bloc = Bloc();
  
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
  String gender;
  String profileImg;
  String occupation;
  String nationality, country;
  String city;
  String countryCode, phoneNumber; 
  String address;
  String buildNumber, postalCode;

  Future<Map<String, dynamic>> fetchDataOfUser() async {
    final data = await fetchData('userDataLogin');
    Map<String, dynamic> userData = data['queryUserById'];
    return userData;
  }
}