import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import './validator_mixin.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class Bloc with ValidatorMixin {

  /* BehaviorSubject Below Are Similiar StreamController But It Has More Feature Over StreamController*/  
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _usersignup = BehaviorSubject<String>();

  /* Transform User Input To Get Validate Text */
  get emailObservable => _email.stream.transform(validateEmail);
  get passwordObservable => _password.stream.transform(validatePassword);
  get submit => Observable.combineLatest2(emailObservable, passwordObservable, (email, password) {
    if ( email != null && password != null ) {
      return true;
    }
    return null;
  });
  
  get emailSignUp => _usersignup.stream.transform(validateEmail); /* User Sign Up */

  /* Add Data Input To Stream */
  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsersign => _usersignup.sink.add;

  
  Future<bool> loginMethod(BuildContext context, String byEmailOrPhoneNums, String passwords, String endpoints, String schema) async { /* Rest Api User Lgogin, Get Respone, Save Data Respone, And Catch Error */
    return userLogin(
      // _email.value, 
      // _password.value
    byEmailOrPhoneNums, passwords, endpoints, schema
    )
    .then((onValue) async {
      Navigator.pop(context);
      print("Sumbit response $onValue");
      if (onValue.keys.contains("error")) {
        dialog(context, Text(onValue['error']["message"]), Icon(Icons.error_outline, color: Colors.red,));
        return false;
      } else { /* If Successfully */
        if (onValue.keys.contains("token")) {
          dialog(context, Text("Successfully"), Icon(Icons.error_outline, color: Colors.green,));
          await setData(onValue, 'userToken');
          return true;
        } else { /* If Incorrect Email */
          dialog(context, Text(onValue["message"]), Icon(Icons.error_outline, color: Colors.red,));
          return false;
        }
      }
    });
  }

  Future<bool> registerMethod(
    BuildContext context, 
    String byEmailOrPhoneNums, String passwords, String endpoints, String schema
  ) async { /* Rest Api User Register, Get Respone, Save Data Respone, And Catch Error */
    return await userRegister(byEmailOrPhoneNums, passwords, endpoints, schema).then((onValue) async {
      Navigator.pop(context); /* Close Loading Screen */
      await dialog(context, Text((onValue['message'])
        ), 
        onValue['message'] != "Successfully registered!" /* Check For Change Icon On Alert */
          ? Icon(Icons.warning, color: Colors.yellow) : Icon(Icons.done_outline, color
          : getHexaColor(lightBlueSky),
        )
      );
      return onValue['message'] == "Successfully registered!" ? true : false;
    })
    .catchError((onError) async {
      await dialog(context, Text('Something goes wrong !'), Icon(Icons.warning));
      return false;
    });
  }

  /* Close All Stream To Prevent Crash Program Or Memory Leak */
  dispose() {
    _email.close();
    _password.close();
    _usersignup.close();
  }
}
