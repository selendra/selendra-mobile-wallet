import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/refetch_data_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/foundation.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// Query reQuery(dynamic bodyWidget, String queryDocument, String fromWidget, dynamic fetchUserData) {
//   return Query(
//     options: QueryOptions(document: queryDocument),
//     builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
//       if (result.data != null) {
//         /* Save all data user*/
//         setData(result.data, 'userDataLogin');
//         /* Save only status user */ 
//         if (result.data['queryUserById'] != null) {
//           Map<String, dynamic> statusNWallet = {
//             "status_name": result.data['queryUserById']['user_status']['status_name'],
//             "wallet": result.data['queryUserById']['wallet']
//           };
//           setData(statusNWallet, 'userStatusAndWallet');
//         }
//       }
//       return result.data != null ? result.data['queryUserById'] != null ?
//           /* If ReQuery From Profile Widget */
//           fromWidget == "Profile" ? reFetchData(bodyWidget, fetchUserData) 
//           : reFetchData(bodyWidget, fetchUserData) 
//         : loading()
//       : loading();
//     },
//   );
// }