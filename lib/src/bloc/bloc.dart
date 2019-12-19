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

  
  Future<bool> submitMethod(BuildContext context, String emailOrPhoneNums, String passwords, String endpoints) async { /* Rest Api User Lgogin, Get Respone, Save Data Respone, And Catch Error */
    return userLogin(
      // _email.value, 
      // _password.value
      emailOrPhoneNums, passwords, endpoints
    )
    .then((onValue) async {
      print("Sumbit response $onValue");
      if (onValue['message'] == null) {
        await setData(onValue, 'userToken');
        return true;
      }
      else { /* When Error Pop Up Dialog */
        await dialog(
          context, 
          Text('${(onValue['message']+' !')}'), 
          Icon(Icons.error_outline, color: Colors.red,)
        );
      }
      /* Return False When Error To Disable Login Button */
      return false;
    })
    .catchError((onError){
      dialog(context, Text("Something goes wrong !"), Icon(Icons.error_outline, color: Colors.red,));
      return false;
    });
  }

  Future<bool> registerUser(BuildContext context) async { /* Rest Api User Register, Get Respone, Save Data Respone, And Catch Error */
    return await userRegister(_email.value, _password.value).then((onValue) async {
      await dialog(context, Text((onValue['message'])
        ), 
        onValue['message'] == "User ${_email.value} already exist" /* Check For Change Icon On Alert */
          ? Icon(Icons.warning) : Icon(Icons.done_outline, color
          : getHexaColor(lightBlueSky),
        )
      );
      return true;
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
