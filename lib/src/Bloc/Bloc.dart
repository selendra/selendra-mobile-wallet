import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import './Validator_Mixin.dart';
import '../Rest_Api/Rest_Api.dart';
import '../Provider/Reuse_Widget.dart';
import '../Store_Small_Data/Data_Storage.dart';

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
  
  /* User Sign Up */
  get emailSignUp => _usersignup.stream.transform(validateEmail);

  /* Add Data Input To Stream */
  Function(String) get addEmail => _email.sink.add;
  Function(String) get addPassword => _password.sink.add;
  Function(String) get addUsersign => _usersignup.sink.add;

  /* Rest Api User Lgoin, Get Respone, Save Data Respone, And Catch Error */
  Future<bool> submitMethod(BuildContext context) async {
    return await userLogin(_email.value, _password.value)
    .then((onValue) async {
      if (onValue['message'] == null) {
        await setData(onValue, 'userToken');
        return true;
      }
      /* When Error Pop Up Dialog */
      else await dialog(context, Text('${(onValue['message']+' !')}'), Icon(Icons.error_outline, color: Colors.red,));
      /* Return False When Error To Disable Login Button */
      return false;
    })
    .catchError((onError){
      dialog(context, Text("Something goes wrong !"), Icon(Icons.error_outline, color: Colors.red,));
      return false;
    });
  }

  /* Rest Api User Register, Get Respone, Save Data Respone, And Catch Error */
  Future<bool> registerUser(BuildContext context) async {
    return await userRegister(_email.value, _password.value).then((onValue) async {
      await dialog(
        context, 
        Text((onValue['message'])), 
        /* Check For Change Icon On Alert */
        onValue['message'] == "User ${_email.value} already exist" 
          ? Icon(Icons.warning) : Icon(Icons.done_outline, color
          : Color(convertHexaColor(lightBlueSky)),)
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
