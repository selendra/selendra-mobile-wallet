import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

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
    var userIds = await fetchData('user_token');
    if (userIds != null){
      idsUser = await userIds['id'];
    }
  }
  
  /* Fetch Token */
  static fetchToken() async {
    var token = await fetchData('user_token');
    return token;
  }

}