import 'package:wallet_apps/src/store_small_data/data_store.dart';

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

  Future<Map<String, dynamic>> fetchDataOfUser() async {
    final data = await fetchData('userDataLogin');
    Map<String, dynamic> userData = data['queryUserById'];
    return userData;
  }
}