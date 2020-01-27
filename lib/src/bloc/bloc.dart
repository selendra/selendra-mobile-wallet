import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import './validator_mixin.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class Bloc with ValidateMixin {

  /* BehaviorSubject Below Are Similiar StreamController But It Has More Feature Over StreamController*/  
  final _email = BehaviorSubject<String>();
  final _phoneNums = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _usersignup = BehaviorSubject<String>();

  /* Transform User Input To Get Validate Text */
  get emailObservable => _email.stream.transform(validateEmail);
  get phoneNumsObservable => _phoneNums.stream.transform(validatePhoneNums);
  get passwordObservable => _password.stream.transform(validatePasswords);
  get submit => Observable.combineLatest2(emailObservable, passwordObservable, (email, password) {
    if ( email != null && password != null ) {
      return true;
    }
    return null;
  });
  
  get emailSignUp => _usersignup.stream.transform(validateEmail); /* User Sign Up */

  /* Add Data Input To Stream */
  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPhoneNums => _phoneNums.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsersign => _usersignup.sink.add;

  
  Future<bool> loginMethod(BuildContext context, String _byEmailOrPhoneNums, String _passwords, String _endpoints, String _label) async { /* Rest Api User Lgogin, Get Respone, Save Data Respone, And Catch Error */
    return await userLogin(
      // _email.value, 
      // _password.value
    _byEmailOrPhoneNums, _passwords, _endpoints, _label
    )
    .then((_response) async {
      Navigator.pop(context);
      if (_response.keys.contains("error")) {
        dialog(context, Text(_response['error']["message"]), Icon(Icons.error_outline, color: Colors.red,));
        return false;
      } else { /* If Successfully */
        if (_response.keys.contains("token")) {
          // await dialog(context, Text("Successfully"), Icon(Icons.error_outline, color: Colors.green,));
          await setData(_response, 'user_token');
          return true;
        } else { /* If Incorrect Email */
          await dialog(context, Text(_response["message"]), Icon(Icons.error_outline, color: Colors.red,));
          return false;
        }
      }
    });
  }

  Future<bool> registerMethod( /* Rest Api User Register, Get Respone, Save Data Respone, And Catch Error */
    BuildContext context, 
    String _byEmailOrPhoneNums, String _passwords, String _endpoints, String _label
  ) async {
    return await userRegister(_byEmailOrPhoneNums, _passwords, _endpoints, _label).then((_response) async {
      Navigator.pop(context); /* Close Loading Screen */ 
      await dialog(
        context, 
        Text((_response['message'])), /* Sub Title */
        _response['message'] != "Successfully registered!" /* Check For Change Icon On Alert */ /* Title */
          ? Icon(Icons.warning, color: Colors.yellow) : Icon(Icons.done, color
          : getHexaColor(_label == "email" ? lightBlueSky : greenColor),
        )
      );
      return _response['message'] == "Successfully registered!" ? true : false;
    })
    .catchError((onError) async {
      await dialog(context, Text('Something goes wrong !'), Icon(Icons.warning));
      return false;
    });
  }

  /* Close All Stream To Prevent Crash Program Or Memory Leak */
  dispose() {
    _email.close();
    _phoneNums.close(); 
    _password.close();
    _usersignup.close();
  }
}
