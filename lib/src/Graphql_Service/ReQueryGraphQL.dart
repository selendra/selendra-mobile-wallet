import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/RefetchData.dart';
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Query reQuery(dynamic bodyWidget, String queryDocument, String fromWidget, dynamic fetchUserData) {
  return Query(
    options: QueryOptions(document: queryDocument),
    builder: (QueryResult result, {VoidCallback refetch}) {
      if (result.data != null) {
        /* Save all data user*/
        setData(result.data, 'userDataLogin');
        /* Save only status user */ 
        if (result.data['queryUserById'] != null) {
          Map<String, dynamic> statusNWallet = {
            "status_name": result.data['queryUserById']['user_status']['status_name'],
            "wallet": result.data['queryUserById']['wallet']
          };
          setData(statusNWallet, 'userStatusAndWallet');
        }
      }
      return result.data != null ? result.data['queryUserById'] != null ?
          /* If ReQuery From Profile Widget */
          fromWidget == "Profile" ? reFetchData(bodyWidget, fetchUserData) 
          : bodyWidget 
        : loading() 
      : loading();
    },
  );
}