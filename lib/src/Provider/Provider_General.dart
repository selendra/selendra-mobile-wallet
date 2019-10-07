import 'package:flutter/material.dart';
import '../Bloc/Bloc.dart';
import '../Store_Small_Data/Data_Storage.dart';

class Provider extends InheritedWidget{

  final bloc = Bloc();
  static Function refetchData;
  
  @override
  bool updateShouldNotify(_) => true;

  Provider({Widget child}) : super(child: child);

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
  
  static fetchStatusNWallet() async {
    var userStatusNWallet = await fetchData('userStatusAndWallet');
    // print(userStatusNWallet);
    return userStatusNWallet;
  }

  static String idsUser;

  static fetchUserIds() async {
    var userIds = await fetchData('userToken');
    if (userIds != null){
      idsUser = await userIds['id'];
    }
  }
  
  /* Fetch Token */
  static fetchToken() async {
    var token = await fetchData('userToken');
    return token;
  }

}