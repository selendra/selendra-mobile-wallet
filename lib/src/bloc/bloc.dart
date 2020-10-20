import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:wallet_apps/src/backend/post/post_request.dart';
import './validator_mixin.dart';
import 'package:wallet_apps/index.dart';

class Bloc with ValidateMixin {

  PostRequest _postRequest = PostRequest();

  /* BehaviorSubject Below Are Similiar StreamController But It Has More Feature Over StreamController*/
  final _email = BehaviorSubject<String>();
  final _phoneNums = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _usersignup = BehaviorSubject<String>();

  /* Transform User Input To Get Validate Text */
  get emailObservable => _email.stream.transform(validateEmail);
  get phoneNumsObservable => _phoneNums.stream.transform(validatePhoneNums);
  get passwordObservable => _password.stream.transform(validatePasswords);
  // get submit => Observable.combineLatest2(emailObservable, passwordObservable, (email, password) {
  //   if (email != null && password != null) {
  //     return true;
  //   }
  //     return null;
  //   }
  // );

  /* User Sign Up */
  get emailSignUp => _usersignup.stream.transform(validateEmail);

  /* Add Data Input To Stream */
  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPhoneNums => _phoneNums.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsersign => _usersignup.sink.add;

  Future<bool> loginMethod(BuildContext context, String _byEmailOrPhoneNums, String _passwords, String _endpoints, String _label) async {
    /* Rest Api User Lgogin, Get Respone, Save Data Respone, And Catch Error */
    // return await _postRequest.userLogin(_byEmailOrPhoneNums, _passwords, _endpoints, _label).then((_response) async {
    //   Navigator.pop(context); /* Close Loading Process */
    //   if (_response['status_code'] != '502') {
    //     if (_response.keys.contains("error")) {
    //       await dialog( context, textAlignCenter(text: _response['error']["message"]), textMessage());
    //       return false;
    //     } else { /* If Successfully */
    //       if (_response.keys.contains("token")) {
    //         _response.addAll({
    //           "isLoggedIn": true
    //         });
    //         await StorageServices.setData(_response, 'user_token');
    //         return true;
    //       } else { /* If Incorrect Email */
    //         await dialog( context, textAlignCenter(text: _response["message"]), textMessage());
    //         return false;
    //       }
    //     }
    //   } else {
    //     await dialog(context, textAlignCenter(text: "Something gone wrong !"), textMessage());
    //     return false;
    //   }
    // });
  }

  /* Rest Api User Register, Get Respone, Save Data Respone, And Catch Error */
  Future<bool> registerMethod(
    BuildContext context,
    String _byEmailOrPhoneNums,
    String _passwords,
    String _endpoints,
    String _label
  ) async {
    // Map<String, dynamic> response = await _postRequest.registerByPhone(_byEmailOrPhoneNums, _passwords, _endpoints, _label);
    // print(response);
    // return await _postRequest.userRegister(_byEmailOrPhoneNums, _passwords, _endpoints, _label).then((_response) async {
    //   Navigator.pop(context); /* Close Loading Screen */
    //   await dialog(
    //     context,
    //     textAlignCenter(text: _response['message']),
    //     /* Sub Title */
    //     _response['message'] != "Successfully registered!" /* Check For Change Icon On Alert */ /* Title */
    //     ? Icon(Icons.warning, color: Colors.yellow)
    //     : Icon(
    //       Icons.done_outline,
    //       color: getHexaColor(
    //         _label == "email" ? AppColors.lightBlueSky : AppColors.greenColor
    //       ),
    //     )
    //   );
    //   return _response['message'] == "Successfully registered!" ? true : false;
    // }).catchError((onError) async {
    //   await dialog(context, textAlignCenter(text: 'Something goes wrong !'), warningTitleDialog());
    //   return false;
    // });
  }

  /* Close All Stream To Prevent Crash Program Or Memory Leak */
  dispose() {
    _email.close();
    _phoneNums.close();
    _password.close();
    _usersignup.close();
  }
}
