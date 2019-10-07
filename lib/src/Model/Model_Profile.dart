import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';

class ModelProfile {
  /* Verify Step 1 */
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

  fetchDataOfUser() async {
    final data = await fetchData('userDataLogin');
    Map<String, dynamic> userData = data['queryUserById'];
    return userData;
  }
}