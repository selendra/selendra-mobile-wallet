import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelScanInvoice {
  
  final formState1 = GlobalKey<FormState>();
  final formState2 = GlobalKey<FormState>();

  TextEditingController controlBillNO = TextEditingController(text: ""), 
    controlAmount = TextEditingController(text: ""), 
    controlLocation = TextEditingController(text: ""),
    controlApproveCode = TextEditingController(text: "");

  FocusNode nodeBillNo = FocusNode(), nodeAmount = FocusNode(), nodeApproveCode = FocusNode();
  FocusNode nodeLocation = FocusNode();

  SimpleAutoCompleteTextField textField;

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> listNameOfBranches = [], listIdOfBranch = [];

  String shopName, responseLocation, responseBillNO, responseAmount, responseApproveCode;
  Map<String, dynamic> imageUri; 

  bool enable1 = false, enable2 = false;
  
  File imageCapture;
}