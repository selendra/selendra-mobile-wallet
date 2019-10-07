import 'package:Wallet_Apps/src/Provider/Provider_General.dart';

/* Query All Document Type */
String queryAllDocument = """
  query{
    queryAllDocumentsType{
      id,
      document_name
    }
  }
"""; 

/* Query Wallet */
final queryWallet = """
  query{
    queryUserById(id: "${Provider.idsUser}"){
      wallet
    }
  }
""";

/* Query Data User */
String queryUser(String id){
  String queryDataUser = """
    query{
      queryUserById(id: "$id"){
        id
        email
        first_name
        mid_name
        last_name
        profile_img
        document_id{
          document_no
          id
        }
        user_status{
          status_name
        }
        wallet
      }
    }
  """;
  return queryDataUser;
}